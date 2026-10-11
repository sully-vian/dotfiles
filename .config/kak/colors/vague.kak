# Name:         vague
# Description:  A cool, dark, low contrast colorscheme. Pastel yet vivid, like a fleeting memory... 
# Translation:  Adapted for Kakoune from vague.vim (Artem Krinitsyn)

evaluate-commands %sh{
    # Core palette extracted from vague.vim
    bg="rgb:141415"
    bg_alt="rgb:252530"
    bg_light="rgb:333738"
    bg_status="rgb:1c1c24"
    fg="rgb:cdcdcd"
    fg_dim="rgb:606079"

    # Syntax colors
    red="rgb:d8647e"
    orange="rgb:e0a363"
    yellow="rgb:f3be7c"
    green="rgb:7fa563"
    cyan="rgb:6e94b2"
    teal="rgb:9bb4bc"
    blue="rgb:7e98e8"
    purple="rgb:aeaed1"
    pink="rgb:c48282"
    peach="rgb:e8b589"
    special="rgb:b4d4cf"
    operator="rgb:90a0b5"

    echo "
        # ----------------------------------------------------------------------
        # UI Faces
        # ----------------------------------------------------------------------
        set-face global Default ${fg},${bg}
        set-face global PrimarySelection default,${bg_light}
        set-face global SecondarySelection default,${bg_alt}
        
        set-face global PrimaryCursor ${bg},${fg}
        set-face global SecondaryCursor ${bg},${purple}
        set-face global PrimaryCursorEol ${bg},${fg}
        set-face global SecondaryCursorEol ${bg},${purple}
        
        set-face global LineNumbers ${fg_dim},default
        set-face global LineNumberCursor ${fg},default+b
        set-face global LineNumbersWrapped ${fg_dim},default
        
        set-face global MenuForeground ${bg_alt},${fg}
        set-face global MenuBackground ${fg},${bg_alt}
        set-face global MenuInfo ${teal},${bg_alt}
        set-face global Information ${fg},${bg_alt}
        
        set-face global Error ${red},default+b
        set-face global DiagnosticError ${red}
        set-face global DiagnosticWarning ${yellow}
        
        set-face global StatusLine ${fg},${bg_status}
        set-face global StatusLineMode ${peach},${bg_status}
        set-face global StatusLineInfo ${cyan},${bg_status}
        set-face global StatusLineValue ${orange},${bg_status}
        set-face global StatusCursor ${bg_status},${fg}
        set-face global Prompt ${fg},${bg_status}
        
        set-face global MatchingChar default,${bg_light}+b
        set-face global BufferPadding ${fg_dim},default
        set-face global Whitespace ${fg_dim},default

        # ----------------------------------------------------------------------
        # Syntax Faces
        # ----------------------------------------------------------------------
        set-face global value ${orange}
        set-face global type ${teal}
        set-face global variable ${purple}
        set-face global module ${blue}
        set-face global function ${pink}
        set-face global string ${peach}+i
        set-face global keyword ${cyan}
        set-face global operator ${operator}
        set-face global attribute ${special}
        set-face global comment ${fg_dim}+i
        set-face global docstring ${fg_dim}+i
        set-face global meta ${cyan}
        set-face global builtin ${purple}

        # ----------------------------------------------------------------------
        # Markup / Markdown Faces
        # ----------------------------------------------------------------------
        set-face global title ${fg}+b
        set-face global header ${fg}+b
        set-face global bold default+b
        set-face global italic default+i
        set-face global mono ${green}
        set-face global block ${cyan}
        set-face global link ${blue}
        set-face global bullet ${orange}
        set-face global list ${fg}

        # ----------------------------------------------------------------------
        # Version Control / Git
        # ----------------------------------------------------------------------
        # Mapped from DiffAdd, DiffChange, DiffDelete
        set-face global diff_added ${green}
        set-face global diff_changed ${yellow}
        set-face global diff_deleted ${red}
    "
}
