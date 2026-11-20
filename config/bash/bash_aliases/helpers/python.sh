function help.python() {
    echo "Python"
    echo "  > cd my/dir/repository/"
    echo "  > python3 -m venv .venv"
    echo "  > source .venv/bin/activate.fish"
    echo "  > which pip  # should point to the local pip binary under .venv"
    echo "  > pip install <package>"
    echo "  > pip freeze > requirements.txt"
    echo "  > deactivate  # when you're done"
}