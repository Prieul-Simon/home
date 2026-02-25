function pokemon_greeting --description "Greeting by a 1st gen Pokemon"
    set -l RANDOM_INT (random 1 151) # first generation is s1...151
    # set -l RANDOM_INT (random 25 25) # for testing: Pikachu
    set -l RANDOM_INT_3_DIGITS (__pad_left_3_char0 $RANDOM_INT)

    # Unfortunately, --nationalDex is bugged as 025 can return both Pikachu (025) and Pecharunt (1025) 
    # fortune -s | pokemonsay --no-name --nationalDex $RANDOM_INT_3_DIGITS

    set -l REGEXP_SEARCH_CORRECT_POKEMON "^$RANDOM_INT_3_DIGITS - "
    set -l FIRST_ITEM (pokemonsay --list | rg "$REGEXP_SEARCH_CORRECT_POKEMON" | head -n 1)
    set -l POKEMON_FULL_NAME (echo "$FIRST_ITEM" | cut --delimiter " " --fields 3) # 3rd field because format is "%nationalDex - %pokemonName"
    if test -z "$POKEMON_FULL_NAME"
        set --erase POKEMON_FULL_NAME
        set POKEMON_FULL_NAME "Smeargle" # when bugged, do this "easter egg"
    end

    set -g GREETING_MESSAGE (fortune -s | string collect)
    # set -g GREETING_MESSAGE (cheat_fish_show | string collect)
    # set -g GREETING_MESSAGE (echo -e "this is a test\nmessage !!!!" | string collect)

    __log "new pokemon greeting: debug values: ($RANDOM_INT)  ($RANDOM_INT_3_DIGITS) ($REGEXP_SEARCH_CORRECT_POKEMON) ($FIRST_ITEM) ($POKEMON_FULL_NAME)"

    set -g GREETING_FULL_MESSAGE '' "$GREETING_MESSAGE" \n \n $POKEMON_FULL_NAME

    echo $GREETING_FULL_MESSAGE | pokemonsay --no-name --pokemon "$POKEMON_FULL_NAME" | __transform_lines
end

# Adds 4 extra spaces at the beginning of each line for text
# Lolcatify the text
# Adds 12 extra spaces at the beginning of each line for pokemon sprite
function __transform_lines
    # set -f LOLCAT_LINES ''
    # set -f POKEMON_LINES ''
    set -f END_HYPHEN_LINE_COUNT 0
    set -f AFTER_END_COUNT 0
    while read -l current_line
        if test "$END_HYPHEN_LINE_COUNT" -gt 0
            set -f AFTER_END_COUNT (math $AFTER_END_COUNT + 1)
        end

        if test ' --' = (string sub --length 3 $current_line)
            set -f END_HYPHEN_LINE_COUNT (math $END_HYPHEN_LINE_COUNT + 1)
        end

        if test "$AFTER_END_COUNT" -le 4
            if test -n "$LOLCAT_LINES"
                # non-zero length
                set -f LOLCAT_LINES $LOLCAT_LINES \n$current_line
            else
                set -f LOLCAT_LINES $current_line
            end
        else
            if test -n "$POKEMON_LINES"
                # non-zero length
                set -f POKEMON_LINES $POKEMON_LINES \n$current_line
            else
                set -f POKEMON_LINES $current_line
            end
        end

        # echo $current_line
    end

    # Throw everything at the end
    # echo 'This is a debug line for separating'
    echo -e $LOLCAT_LINES | pr -T -o 4 | lolcat
    echo -e $POKEMON_LINES | pr -T -o 12
end

function __pad_left_3_char0
    set -l str "$argv[1]"
    set -l length 3
    set -l char "0"

    # Calculate the number of characters to pad
    set -l pad_length (math $length - (string length "$str"))

    # Pad the string if necessary
    if test $pad_length -gt 0
        set -l padding (string repeat --count $pad_length "$char")
        echo "$padding$str"
    else
        echo "$str"
    end
end

function __log
    set -l msg "$argv[1]"

    set -l logfile_loc $XDG_STATE_HOME/pokemon_greeting
    set -l logfile $logfile_loc/log
    mkdir --parents $logfile_loc

    set -l datetime (date)

    echo "[$datetime] $msg" >> $logfile
end
