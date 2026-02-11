# Pack nvm thanks to bass
# See https://github.com/edc/bass?tab=readme-ov-file#nvm
function nvm
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv

    set -l bstatus $status

    if test $bstatus -gt 0
        return $bstatus
    end

    if test (count $argv) -lt 1
        return 0
    end

    if test $argv[1] = use; or test $argv[1] = install
        set -gx NVM_HAS_RUN 1
    end

    return 0
end
