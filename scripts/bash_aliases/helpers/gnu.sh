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
