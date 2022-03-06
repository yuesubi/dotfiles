if status is-interactive
    # Commands to run in interactive sessions can go here
end


function fish_prompt
    set_color blue
    echo -n (whoami)' '
    set_color purple
    echo -n (basename (prompt_pwd))
    set_color brblue
    set_color cyan
    echo -n ' ><> '
    set_color normal
end


### ALIASES

alias ls="ls -lAh --color=auto"
alias ..="cd .."

# Creates parent directories as well
alias mkdir="mkdir -pv"

# confirmations
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias ln="ln -i"

# pacman
alias pacman="pacman --color=auto"
alias pac="sudo pacman --color=auto"

# Start Wm
alias swm="~/startwm.sh"


# Add rust to path
if test -f ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end


neofetch

# opam configuration
source /home/arch/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
