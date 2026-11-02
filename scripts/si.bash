_si() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    opts="-n --notation -o --output -p --precision -u --unit -c --completions -v --version -h --help"

    case "$prev" in
        -n|--notation)
            COMPREPLY=( $(compgen -W "general fixed scientific e E" -- "$cur") )
            return 0
            ;;
        -o|--output)
            COMPREPLY=( $(compgen -W "ascii utf json" -- "$cur") )
            return 0
            ;;
        -c|--completions)
            COMPREPLY=( $(compgen -W "bash zsh" -- "$cur") )
            return 0
            ;;
        -p|--precision|-u|--unit)
            return 0
            ;;
    esac

    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
}

complete -F _si si
