function __simon_create_alias() {
    local alias_name="$1"
    local real_command="$2"

    # local escaped_command="${real_command//\'/\'\"\'\"\'}"
    alias "$alias_name"="
        echo '> Will run the alias command: '\"'\"'$real_command'\"'\";
        $real_command;
    "
}