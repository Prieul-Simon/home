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
    
    if test "tmux-256color" = $TERM; or test "xterm-ghostty" = $TERM; or test "xterm-256color" = $TERM
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
