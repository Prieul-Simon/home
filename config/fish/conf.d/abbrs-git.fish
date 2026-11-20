status is-interactive; or return

### Git abbrs

## git-commit
abbr --add --position anywhere --set-cursor='%' -- gitcommit git\ commit\ -m\ \'\%\'
abbr --add --position anywhere --set-cursor='%' -- gcommit git\ commit\ -m\ \'\%\'

## git-commit
abbr --add gstatus git status
abbr --add gitstatus git status

## git-pull
abbr --add gpull git pull -p
abbr --add gitpull git pull -p

## git-branch: interactive selection
abbr --add gitswitchbranch "git branch | fzf --preview 'git show --color=always {-1}' \
                 --bind 'enter:become(git checkout {-1})' \
                 --height 40% --layout reverse"
abbr --add gitswitchremotebranch "git branch --all | fzf --preview 'git show --color=always {-1}' \
                 --bind 'enter:become(git checkout {-1})' \
                 --height 40% --layout reverse"

## git-graph: pretty graph
abbr --add gitgraph "git log --graph --oneline --decorate --all \
    --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"

## Shortcuts for ignoring local modifications of tracked files
abbr --add git-local-ignore 'git update-index --skip-worktree'
abbr --add git-local-unignore 'git update-index --no-skip-worktree'
abbr --add git-local-show-ignored 'git ls-files -v | grep "^S"'
