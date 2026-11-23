function help.python() {
    echo "Python"
    echo "  > cd my/dir/repository/"
    echo "  > python3 -m venv .venv"
    echo "  > source .venv/bin/activate.fish"
    echo "  > which pip  # should point to the local pip binary under .venv"
    echo "  > pip install <package>"
    echo "  > pip freeze > requirements.txt ## when creating a new project"
    echo "  > pip install -r requirements.txt  ## when on an existing project"
    echo "  > deactivate  # when you're done"
}