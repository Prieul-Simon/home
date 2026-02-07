#!/bin/bash
# Pasted from https://gist.github.com/unphased/f078a5d4d974b141ccd43c224a5dd5af
# lf Previewer Script with Caching for Performance
#
# Design Goals:
# 1. Fast Scrolling: Avoid re-running expensive generation (like bat) on every scroll.
# 2. Caching: Generate full preview content once per file version, store it.
# 3. Cache Invalidation: Use file modification time (mtime) in cache keys to automatically
#    handle file changes.
# 4. Large File Handling: For text-based files, only process the head and tail lines for faster generation.
# 5. File Type Handling: Support various types (text, json, binary, compressed).
# 6. Modularity: Separate caching logic from file-specific generation logic for clarity
#    and maintainability.
# 7. Robustness: Handle temporary files safely and attempt atomic cache updates.

### Use me with lfrc config like the following:
# set previewer bat-lf-previewer
# 
# # --- Preview Commands (Send Actions to Script) ---
# 
# # Need to clear out the user_preview_command state when switching to another item
# cmd on-select set user_preview_command
# 
# # Send action strings to the previewer script via the environment variable
# cmd jump-preview-top    :set user_preview_command jump_top; set preview true
# cmd jump-preview-bottom :set user_preview_command jump_bottom; set preview true
# cmd scroll-preview-down :set user_preview_command "scroll_down:5"; set preview true
# cmd scroll-preview-up   :set user_preview_command "scroll_up:5"; set preview true
# # Optional: PageUp/PageDown (adjust amount as needed, e.g., use $LINES variable if available/reliable)
# # cmd page-preview-down :set user_preview_command "scroll_down:20"; set preview true
# # cmd page-preview-up   :set user_preview_command "scroll_up:20"; set preview true
# 
# # --- Key Mappings ---
# map g jump-preview-top
# map G jump-preview-bottom
# map J scroll-preview-down
# map K scroll-preview-up

# --- Configuration ---
CACHE_DIR="$HOME/.cache/lf-previewer"
MAX_XXD_BYTES=2048 # Limit for binary previews
PREVIEW_CHUNK_BYTES=131072  # 128KB threshold. Files larger than this (in bytes) trigger head/tail preview.
PREVIEW_HEADTAIL_BYTES=65536 # 64KB for head and 64KB for tail when truncating.

# --- Logging Setup ---
LOGFILE="$HOME/.cache/lf-previewer/previewer.log"
exec 2>> "$LOGFILE" # Redirect stderr to the log file (append)

# --- Dependency Check ---
# for cmd in realpath stat md5sum file batcat tail head printf mktemp mv rm xxd brotli zstd; do
for cmd in realpath stat md5sum file batcat tail head printf mktemp mv rm xxd zstd; do
    if ! command -v "$cmd" >/dev/null; then
        echo "Error: Required command '$cmd' not found in PATH."
        exit 1
    fi
done


# --- Helper Functions ---

# Function to process a file, applying head/tail truncation if it exceeds a size threshold
# Arguments: $1 = input file path
#            $2 = temporary output file path where the processed content should go
#            $3 = command template string (use '%FILE%' as placeholder for the input file path)
# Uses global constants: PREVIEW_CHUNK_BYTES, PREVIEW_HEADTAIL_BYTES
process_file_with_truncation() {
    local input_f="$1"
    local output_tmp_f="$2"
    local cmd_template="$3"
    local file_to_process="$input_f" # Start assuming we process the original file
    local truncated_tmp=""           # Path to temporary truncated file, if created
    local final_cmd=""
    local ret_status=0

    # Check file size using OS-compatible stat
    local file_size
    if [[ "$(uname)" == "Darwin" ]] || [[ "$(uname)" == *BSD* ]]; then
        file_size=$(stat -f %z "$input_f") # macOS/BSD stat for size
    else
        file_size=$(stat -c %s "$input_f") # Linux/GNU stat for size
    fi

    # If file is large, create a truncated version
    if [[ $file_size -gt $PREVIEW_CHUNK_BYTES ]]; then
        # Portable mktemp: Use a template ending in XXXXXX
        truncated_tmp=$(mktemp "$CACHE_DIR/lf_preview_trunc.XXXXXX")
        # Ensure truncated temp file is cleaned up if script exits unexpectedly here
        trap 'rm -f "$truncated_tmp"' RETURN

        head -c "$PREVIEW_HEADTAIL_BYTES" "$input_f" > "$truncated_tmp"
        printf "\n\n[... File truncated (%s bytes total) ...]\n\n" "$file_size" >> "$truncated_tmp"
        tail -c "$PREVIEW_HEADTAIL_BYTES" "$input_f" >> "$truncated_tmp"
        file_to_process="$truncated_tmp" # Process the truncated file instead
    fi

    # Construct the final command by replacing the placeholder
    final_cmd=$(echo "$cmd_template" | sed "s|%FILE%|$file_to_process|g")

    # Execute the command, redirecting stdout to the output temp file
    echo "Executing command: eval \"$final_cmd\" > \"$output_tmp_f\"" >&2
    eval "$final_cmd" > "$output_tmp_f"
    ret_status=$?

    # Clean up the truncated file if it was created, and remove the trap
    if [[ -n "$truncated_tmp" ]]; then
        rm -f "$truncated_tmp"
        trap - RETURN # Disable the trap specifically for this temp file
    fi

    return $ret_status
}

# Function to generate the preview content for a given file type
# Arguments: $1 = input file path, $2 = temporary output file path
generate_preview_content() {
    local input_f="$1"
    local output_tmp_f="$2"
    local file_t # Use local scope for file_type within function

    # Determine file type (handle potential errors)
    file_t=$(file -b --mime-type "$input_f" 2>/dev/null)
    if [[ -z "$file_t" ]]; then
        echo "Error determining file type for: $input_f" > "$output_tmp_f"
        return 1 # Indicate failure
    fi

    # --- File Type Specific Generation Logic ---
    if [[ "$input_f" =~ \.json$ ]]; then
        # Define command template: try jq, fallback to batcat
        # Note: We redirect jq's stderr to /dev/null to suppress parsing errors if it fails
        # The output redirection `> "$output_tmp_f"` happens *after* the eval in the helper function
        local json_cmd_template="jq --color-output . '%FILE%' | cat -n"
        process_file_with_truncation "$input_f" "$output_tmp_f" "$json_cmd_template"
        # Capture return status if needed, though we mainly check for empty output later
    # elif [[ $file_t == "application/octet-stream" && "$input_f" =~ \.br$ ]]; then
    #     handle_compressed "brotli" "$input_f" "$output_tmp_f"
    elif [[ $file_t == application/zstd ]]; then
        handle_compressed "zstd" "$input_f" "$output_tmp_f"
    elif [[ $file_t == application/octet-stream ]]; then
        # Binary file: use xxd
        xxd -l "$MAX_XXD_BYTES" "$input_f" > "$output_tmp_f"
    else
        # Default to batcat for text files, applying truncation if large
        local text_cmd_template="batcat --style=changes,numbers --color=always '%FILE%'"
        process_file_with_truncation "$input_f" "$output_tmp_f" "$text_cmd_template"
        # Capture return status if needed
    fi

    # Check if generation produced any output
    if [[ ! -s "$output_tmp_f" ]]; then
        # If batcat/jq/xxd failed silently, provide a message
        echo "[Preview generation produced no output for $input_f]" > "$output_tmp_f"
        # Optionally return 1 here if empty output is considered an error
    fi

    return 0 # Indicate success
}

# Function to handle compressed files
# Arguments: $1 = compression type ("brotli" or "zstd"), $2 = input file, $3 = final output temp file
handle_compressed() {
    local type="$1"
    local input_comp_f="$2"
    local output_final_tmp_f="$3"
    local decomp_cmd decomp_tmp err_msg

    # Portable mktemp
    decomp_tmp=$(mktemp "$CACHE_DIR/lf_preview_decomp.XXXXXX")
    # Ensure decompressed temp file is cleaned up
    trap 'rm -f "$decomp_tmp"' RETURN

    case "$type" in
        # brotli)
        #     decomp_cmd="brotli -d \"$input_comp_f\" -o \"$decomp_tmp\" -f"
        #     err_msg="Error decompressing Brotli file"
        #     ;;
        zstd)
            decomp_cmd="zstd -qd \"$input_comp_f\" -o \"$decomp_tmp\" -f"
            err_msg="Error decompressing Zstd file"
            ;;
        *)
            echo "Unsupported compression type: $type" > "$output_final_tmp_f"
            return 1
            ;;
    esac

    # Attempt decompression
    if eval "$decomp_cmd"; then
        # Decompression succeeded, now generate preview for the *decompressed* file
        # Call generate_preview_content directly on the decompressed temp file.
        # This uses the standard generation logic (batcat, jq, etc.)
        # The output goes directly into the final output temp file for the original compressed file's cache.
        echo "Generating preview for decompressed file: $decomp_tmp" >&2
        generate_preview_content "$decomp_tmp" "$output_final_tmp_f"
        return 0
    else
        # Decompression failed
        echo "$err_msg: $input_comp_f" > "$output_final_tmp_f"
        return 1
    fi
}

# --- Main Script Logic ---

# Ensure cache directory exists
mkdir -p "$CACHE_DIR" || { echo "Error: Cannot create cache dir $CACHE_DIR"; exit 1; }

# Input validation
input_file="$1"
preview_height="$3" # Height of the preview pane (passed by lf)
echo "--- Script Start ---" >&2
if [[ -z "$input_file" ]]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Get required info: absolute path and modification time
abs_input_file=$(realpath "$input_file" 2>/dev/null)
if [[ -z "$abs_input_file" || ! -e "$abs_input_file" ]]; then
    echo "Input '$input_file' resolved to invalid path '$abs_input_file' or does not exist. Exiting cleanly." >&2
    # Handle cases like directories or non-existent files gracefully for lf
    # lf might call the previewer even for directories before realizing it shouldn't
    exit 0 # Exit cleanly, lf will handle it
fi
# Get modification time (seconds since epoch) compatible with Linux and macOS/BSD
if [[ "$(uname)" == "Darwin" ]] || [[ "$(uname)" == *BSD* ]]; then
    mtime=$(stat -f %m "$abs_input_file") # macOS/BSD stat
else
    mtime=$(stat -c %Y "$abs_input_file") # Linux/GNU stat
fi
echo "Input File: $input_file -> Abs: $abs_input_file, Mtime: $mtime, Height: $preview_height" >&2

# Calculate cache key
file_hash=$(echo -n "$abs_input_file" | md5sum | cut -d' ' -f1)
cache_base="$CACHE_DIR/${file_hash}_${mtime}"
echo "Cache Base: $cache_base" >&2
cache_file="$CACHE_DIR/${file_hash}_${mtime}.preview"


# --- Cache Check ---
if [[ -f "$cache_file" ]]; then
    echo "Cache Hit: $cache_file" >&2
    # Cache Hit: Do nothing here. The offset calculation and display
    # happens later, after potentially generating the cache if it was missing.
    : # No-op
else
    echo "Cache Miss: $cache_file" >&2
    # --- Cache Miss: Generate and Cache Preview ---
    echo "Generating preview cache for $input_file..." >&2 # Debug message (stderr is redirected)

    # Use a temporary file for the intermediate full preview content
    # Portable mktemp
    preview_content_tmp=$(mktemp "$CACHE_DIR/lf_preview_gen.XXXXXX")
    # Ensure temporary file is cleaned up on exit/interrupt, unless successfully moved
    trap 'rm -f "$preview_content_tmp"' EXIT SIGINT SIGTERM

    # Call the generation function
    if generate_preview_content "$abs_input_file" "$preview_content_tmp"; then
        echo "Generation succeeded for $abs_input_file." >&2
        # Generation succeeded, atomically move to cache
        mv "$preview_content_tmp" "$cache_file" || {
            echo "Error moving temp file to cache: $cache_file" # Log error
            rm -f "$preview_content_tmp" # Ensure cleanup if mv fails
            # Optionally display an error preview or exit differently
            echo "[Error caching preview]"
            exit 1 # Still exit 1 for lf scrolling mechanism
        }
        # Disable trap as the file has been moved successfully
        trap - EXIT SIGINT SIGTERM
        # Log generated line count
        echo "Cache file created: $cache_file ($(wc -l < "$cache_file") lines)" >&2
    else
        # Generation failed, move the temp file (containing error message) to cache
        echo "Generation failed for $abs_input_file. Caching error message." >&2
        echo "[Preview generation failed for $input_file]" # Log message
        mv "$preview_content_tmp" "$cache_file" || {
             echo "Error moving error temp file to cache: $cache_file" # Log error
             rm -f "$preview_content_tmp"
             echo "[Error caching preview failure message]"
             exit 1
        }
        # Disable trap as the file has been moved successfully
        trap - EXIT SIGINT SIGTERM
    fi
fi

# --- Offset Calculation and Display ---

# Define paths
offset_file="${cache_base}.offset"

# Read the requested action from lf (default to 'show_current' if not set)
action=${lf_user_preview_command:-show_current}
echo "Action received: $action" >&2

# Read the current stored offset, default to 1
current_offset=1
if [[ -f "$offset_file" ]]; then
    read current_offset < "$offset_file"
    echo "Offset file found: $offset_file. Read value: $current_offset" >&2
    # Validate offset read from file
    if ! [[ "$current_offset" =~ ^[0-9]+$ ]]; then
        current_offset=1
        echo "Invalid offset read, defaulting to 1." >&2
    fi
fi

# Ensure preview height is valid
if ! [[ "$preview_height" =~ ^[1-9][0-9]*$ ]]; then
    preview_height=25 # Default height if invalid
fi
echo "Using preview height: $preview_height" >&2

# Get total lines from the cache file (needed for clamping and jump_bottom)
total_lines=1 # Default if cache file doesn't exist or is empty
if [[ -f "$cache_file" ]]; then
    total_lines=$(wc -l < "$cache_file")
    [[ "$total_lines" -lt 1 ]] && total_lines=1 # Ensure at least 1 line
    echo "Cache file total lines: $total_lines" >&2
fi

# Calculate the start line of the last page
last_page_start=$(( total_lines - preview_height + 1 ))
echo "Calculated last page start line: $last_page_start (before min clamp)" >&2
[[ "$last_page_start" -lt 1 ]] && last_page_start=1 # Ensure it's at least 1

# Calculate the new offset based on the action
new_offset=$current_offset # Start with current offset

case "$action" in
    jump_top)
        new_offset=1
        ;;
    jump_bottom)
        new_offset=$last_page_start
        ;;
    scroll_up:*)
        amount=${action#scroll_up:}
        [[ "$amount" =~ ^[0-9]+$ ]] || amount=1 # Default amount if invalid
        new_offset=$(( current_offset - amount ))
        ;;
    scroll_down:*)
        amount=${action#scroll_down:}
        [[ "$amount" =~ ^[0-9]+$ ]] || amount=1 # Default amount if invalid
        new_offset=$(( current_offset + amount ))
        ;;
    show_current|*) # Default action: just show the current offset
        new_offset=$current_offset
        ;;
esac
echo "Calculated new offset (before clamping): $new_offset" >&2

# Clamp the new offset
clamped_offset=$new_offset
[[ "$new_offset" -lt 1 ]] && new_offset=1                 # Clamp to top (min 1)
[[ "$new_offset" -gt "$last_page_start" ]] && new_offset=$last_page_start # Clamp to bottom (max last_page_start)
echo "Clamped offset: $new_offset" >&2

# Write the final clamped offset back to the offset file
echo "$new_offset" > "$offset_file" || echo "Error writing offset file: $offset_file" # Log error on failure
echo "Wrote offset $new_offset to $offset_file" >&2

# Display the content using the final calculated and clamped offset
echo "Executing display command: tail -n \"+$new_offset\" \"$cache_file\"" >&2
tail -n "+$new_offset" "$cache_file"


exit 1 # Essential for lf scrolling mechanism
