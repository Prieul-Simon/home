function fish_greeting
    # switch (random 1 5)
    #     case 1
    #         echo "🐟"
    #     case 2
    #         echo "🐠"
    #     case 3
    #         echo "🐡"
    #     case 4
    #         echo "🐳"
    #     case 5
    #         echo "🦈"
    # end
    
    if test -n "$__SIMON_GREETING_FORCE_MODE"
        switch $__SIMON_GREETING_FORCE_MODE
            case "pokemon"
                pokemon_greeting
            case "duck"
                duck_greeting
            case "*"
                echo "[fish_greeting] Unknown __SIMON_GREETING_FORCE_MODE: $__SIMON_GREETING_FORCE_MODE"
        end
        return
    end

    if test "tmux-256color" = $TERM; or test "xterm-ghostty" = $TERM
        if functions -q pokemon_greeting; and command -q pokemonsay
            pokemon_greeting
        else
            duck_greeting
        end
    else
        duck_greeting
    end
end

function duck_greeting
    fortune -s | cowsay -f duck | lolcat
end
