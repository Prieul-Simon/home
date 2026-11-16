function print_as_ul -d "Print the given arg as an <ul>"
    string join \n"• " -- "• $argv[1]" $argv[2..-1]
end
