# General configuration starts

export EDITOR=`which vim`
export VISUAL=$EDITOR

PATH=$HOME/bin:$PATH
source ~/.fresh/build/shell.sh

# General configuration ends

if [[ -n $PS1 ]]; then
    : # Executed only for interactive shells
        alias dir ls -AFC

        # root CA for hiya svcs including vault.
        ROOT_CA=$HOME/.creds/certs/hiya-ca/hiya-root.cert.pem

    # Per the direnv installation instructions, this line must occur at the end of
    # .bashrc
    eval "$(direnv hook $0)"
else
    : # Executed only for non-interactive shells
fi

if shopt -q login_shell ; then
    : # Executed only for login shells
else
    : # Executed only for non-login shells
fi
