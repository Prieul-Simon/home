function showaslist -d "Show the given arg as a list"
    showaslist.ul $argv
end

function showaslist.ul -d "Show the given arg as an <ul>"
    string join \n"• " -- "• $argv[1]" $argv[2..-1]
end

function showaslist.ol -d "Show the given arg as an <ol>"
    set -l width (string length (count $argv))
    set -l i 1
    for arg in $argv
        printf '%*d. %s\n' $width $i $arg
        set i (math $i + 1)
    end
end
