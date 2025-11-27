if status is-interactive
    # Commands to run in interactive sessions can go here

    # fzf integration
    fzf --fish | source

    # fzf default options (applies to all fzf calls)
    set -x FZF_DEFAULT_OPTS "--style minimal"

    # For Ctrl+F (file search) - using Ctrl+F instead of default Ctrl+T to avoid WezTerm conflict
    set -x FZF_CTRL_F_OPTS "--preview 'cat {}' --preview-window right:50%:wrap"

    # For Ctrl+R (command history)
    set -x FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:wrap"

    # For Alt+C (directory search)
    set -x FZF_ALT_C_OPTS "--preview 'ls -la {}'"

    # Rebind fzf file search from Ctrl+T to Ctrl+F
    bind \cf fzf-file-widget
    bind -M insert \cf fzf-file-widget

    # Custom fzf-rg function for searching code with ripgrep
    function fzf-rg
        read -P "Search: " query
        if test -n "$query"
            set result (rg --color=always --line-number --no-heading --smart-case "$query" | \
              fzf --ansi \
                  --delimiter : \
                  --preview 'bat --color=always {1} --highlight-line {2}' \
                  --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')

            if test -n "$result"
                set file (echo $result | cut -d: -f1)
                commandline -i "$file"
            end
        end
    end

    # Bind Ctrl+G to fzf-rg for ripgrep search
    bind \cg fzf-rg
end
