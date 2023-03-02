_comp_template()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="use new del ls help"

    # Complete template names
    if [[ "${prev}" =~ ^(use|new|del)$ ]]; then
        COMPREPLY=( $(compgen -W "$(ls ~/.scripts/appdata/template)" -- ${cur}) )
        return 0
    fi

    # Complete sub-commands
    case "${cur}" in
        use*|u*)
            COMPREPLY=( $(compgen -W "use" -- ${cur}) )
            ;;
        new*|n*)
            COMPREPLY=( $(compgen -W "new" -- ${cur}) )
            ;;
        del*|d*)
            COMPREPLY=( $(compgen -W "del" -- ${cur}) )
            ;;
        ls*|l*)
            COMPREPLY=( $(compgen -W "ls" -- ${cur}) )
            ;;
        help*|h*)
            COMPREPLY=( $(compgen -W "help" -- ${cur}) )
            ;;
        *)
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
    esac

    return 0
}

export -f _comp_template