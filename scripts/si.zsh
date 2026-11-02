#compdef si

_arguments -s -S \
    '(-n --notation)'{-n,--notation}'[Set numeric notation]:notation:(general fixed scientific e E)' \
    '(-o --output)'{-o,--output}'[Set output format]:format:(ascii utf json)' \
    '(-p --precision)'{-p,--precision}'[Set decimal precision]:precision:' \
    '(-u --unit)'{-u,--unit}'[Convert to target unit representation]:unit:' \
    '(-c --completions)'{-c,--completions}'[Generate shell completions]:shell:(bash zsh)' \
    '(-v --version)'{-v,--version}'[Display version information]' \
    '(-h --help)'{-h,--help}'[Display help information]'
