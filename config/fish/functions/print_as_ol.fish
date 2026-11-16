function print_as_ol -d "Print the given arg as an <ol>"
    set -l width (string length (count $argv))
    set -l i 1
    for arg in $argv
        printf '%*d. %s\n' $width $i $arg
        set i (math $i + 1)
    end
end
