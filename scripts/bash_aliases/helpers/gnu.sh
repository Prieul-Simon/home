function help.complete() {
    echo "Autocompletion on bash:"
    echo "  > batcat --version"
    echo "  > complete -p batcat"
    echo "    ~> \`complete -F _bat batcat\`"
    echo "  (We now know that function for completion is \`_bat\`)"
    echo "  > complete -F _bat my-alias-for-bat"
    echo "  (Now, \`my-alias-for-bat\` as the same completion as \`batcat\`)"
    echo "  (Read also \`tldr complete\`)"
}

function help.grep() {
    echo "Some tips / useful options of grep:"
    echo "  "
    echo "  (for Recursive, Ignore-case, Number of the matching line)"
    echo "  (s removes error messages)"
    echo "  (I stands for --binary-files=without-match i.e. skip binaries)"
    echo "  (also -r does not follow symlinks, but -R does) :"
    echo "  > grep -rinsI --exclude-dir=\".config\" dracula"
    echo "  "
    echo "  --exclude-dir"
    echo "  > grep -RHIn --exclude-dir=node_modules \"<my-search-sequence>\" ./folder_to_search"
    echo "  # multiple directories with --exclude-dir={one,two}"
    echo "  # Can also be used with recursive-grep:"
    echo "  > recursive-grep --exclude-dir={dist,node_modules} \"<my-search-sequence>\" "
    echo "  # Find then grep"
    echo "  > find . -type f -iname \"compose-test.yml\" -exec grep \"args\" {} \+"
}

function help.find() {
    echo "Usage of find"
    echo "  "
    echo "  > find path/to/directory -name '*.ext'"
}
