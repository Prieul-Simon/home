# Pack nvm thanks to bass
# See https://github.com/edc/bass?tab=readme-ov-file#nvm
function nvm
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
