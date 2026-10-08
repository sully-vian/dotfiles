#!/usr/bin/env sh

set -euo pipefail

# base24
# based on https://github.com/tinted-theming/base24
export base00='#141415' # Default Background
export base01='#1c1c24' # Lighter Background (Used for status bars, line number and folding marks)
export base02='#333738' # Selection Background
export base03='#606079' # Comments, Invisibles, Line Highlighting
export base04='#878787' # Dark Foreground (Used for status bars)
export base05='#cdcdcd' # Default Foreground, Caret, Delimiters, Operators
export base06='#c3c3d5' # Light Foreground (Not often used)
export base07='#aeaed1' # Light Background (Not often used)
export base08='#d8647e' # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
export base09='#e0a363' # Integers, Boolean, Constants, XML Attributes, Markup Link Url
export base0A='#f3be7c' # Classes, Markup Bold, Search Text Background
export base0B='#7fa563' # Strings, Inherited Class, Markup Code, Diff Inserted
export base0C='#b4d4cf' # Support, Regular Expressions, Escape Characters, Markup Quotes
export base0D='#6e94b2' # Functions, Methods, Attribute IDs, Headings
export base0E='#bb9dbd' # Keywords, Storage, Selector, Markup Italic, Diff Changed
export base0F='#c48282' # Deprecated, Opening/Closing Embedded Language Tags, e.g. `<?php ?>`
export base10='TODO'    # Darker Background
export base11='TODO'    # The Darkest Background
export base12='#e08398'
export base13='#f5cb96'
export base14='#99b782'
export base15='#bebeda'
export base16='#8ba9c1'
export base17='#c9b1ca'

# ANSI
# see https://github.com/tinted-theming/base24/blob/main/styling.md
export color00="$base00"
export color01="$base08"
export color02="$base0B"
export color03="$base0A"
export color04="$base0D"
export color05="$base0E"
export color06="$base0C"
export color07="$base05"
export color08="$base03"
export color09="$base12"
export color10="$base14"
export color11="$base13"
export color12="$base16"
export color13="$base17"
export color14="$base15"
export color15="$base07"
export color16="$base09"
export color17="$base0F"
export color18="$base01"
export color19="$base02"
export color20="$base04"
export color21="$base06"
