#!/bin/bash

main() {
    # Require at least one argument
    if [[ $# -ne 1 ]]; then
        echo "Missing version arg. Usage: install-jdk.sh <version>" >&2
        return 1
    fi
    local version="$1"

    echo "[OpenJDK $version: installing...]"
    sudo apt install --yes openjdk-$version-jdk openjdk-$version-doc openjdk-$version-source
    echo "[OpenJDK $version: installed !]"
    echo "To generate fish completions for Java, run 'fish_update_completions'"
    echo ""
    echo ""
    echo "> java -version"
    java -version
    echo ""
    echo "> javac -version"
    javac -version
    echo ""
    echo "> javap -version"
    javap -version
    echo ""
    echo "> javadoc --version"
    javadoc --version
}
main $*
