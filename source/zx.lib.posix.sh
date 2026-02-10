#!/usr/bin/env sh
# shellcheck enable=all

# COMPATIBILITY NOTE:
# ---------------------------------------------------------------
#  bash/zsh/ksh93:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln bash -d
#
#  See compatibility notes below and use posix variants.
#  How to check posix:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln posix -d
# ---------------------------------------------------------------

# Runtime flags
test -z "${ZX_LAZY_UNSET}"    && readonly ZX_LAZY_UNSET=false
test -z "${ZX_EXEC_GETOPTS}"  && readonly ZX_EXEC_GETOPTS=true

# Internal constants
test -z "${__ZX__FMT_SEP}"        && readonly __ZX__FMT_SEP='\ '
test -z "${__ZX__ESC_ANSI_SEP}"   && readonly __ZX__ESC_ANSI_SEP=';'

if test -z "${__ZX_SPACE_PUNCT}"; then
  __ZX_SPACE_PUNCT='\t\n\v\f\v\ !#$%&\*+,\-\:;<=>?@\[\\\x5D^_\`{|}~'
fi

_zx__usage() {
  _zx -tr '# ZX'
  _zx
  _zx -tr '## USAGE'
  _zx
  _zx -td -fg '```'
  _zx -ntb     -- '  zx '
  _zx -ntif    -- '  [OPTIONS] '
  _zx -nti     -- '  [TEXT]'
  _zx
  _zx -td -fg '```'
  _zx
  _zx -tr '## NAME'
  _zx
  _zx '  «Colourful Echo» --> «C. Echo» --> «cecho».'
  _zx '  It _sounds like /see‑EK‑oh/ in English. '
  _zx '  But in Latin it is sounds like /tse‑kho/,'
  _zx '  That is similar to:'
  _zx '    * German «Zeche» — /tseh‑uhn/ — colliery;'
  _zx '    * Russian «Цех»  — /tsekh/    — workshop.'
  _zx '  So we use «Z» to represent /ts/-_sound.'
  _zx
  _zx -tr '## EXAMPLES'
  _zx
  _zx -tr '### KEY VALUE FORM'
  _zx
  _zx -en '\t'
  _zx "zx --fg red --bg +yellow --te strikeout some 'strikeout waring'"
  _zx -en '\t'
  _zx --fg red --bg +yellow --te strikeout 'some strikeout waring'
  _zx
  _zx -en '\t'
  _zx "zx -an --fg cyan; printf 'some cyan text printed with printf '; zx -z"
  _zx -en '\t'
  _zx -an --fg cyan
  printf 'some cyan text printed with printf'
  _zx -z
  _zx
  _zx -tr '### POSITIONAL FORM'
  _zx
  _zx -en '\t'
  _zx "zx -p m/Y/ur 'magenta underlined text on a yellow'"
  _zx -en '\t'
  _zx -p m/Y/ur  'magenta underlined text on a yellow'
  _zx
  _zx -en '\t'
  _zx "zx -p magenta/Yellow/underline 'magenta underlined text on a yellow'"
  _zx -en '\t'
  _zx -p magenta/Yellow/underline  'magenta underlined text on a yellow'
  _zx
  _zx -en '\t'
  _zx "zx -p yellow/Yellow 'dark yellow text on a bright yellow field'"
  _zx -en '\t'
  _zx -p yellow/Yellow  'dark yellow text on a bright yellow field'
  _zx
  _zx -en '\t'
  _zx "zx -pmYru 'magenta underlined text on a yellow field but all reversed'"
  _zx -en '\t'
  _zx -pmYru 'magenta underlined text on a yellow field but all reversed'
  _zx
  _zx -en '\t'
  _zx "zx -anpg 'green text';"
  _zx -en '\t'
  _zx "printf 'still green text'; "
  _zx -en '\t'
  _zx "zx -anpeB 'on blue field '; "
  _zx -en '\t'
  _zx "printf 'still on blue field'; "
  _zx -en '\t'
  _zx "zx -z"
  _zx -en '\t'
  _zx -anpg 'green text '
  printf 'still green text '
  _zx -anpeB 'on blue field'
  printf 'still on blue field'
  _zx -z

  _zx
  _zx -tr '## OPTIONS'
  _zx -tc '|  ch | short |          word |                long | Description |'
  _zx -tc '|----:|------:|--------------:|--------------------:|-------------|'
  _zx -fr '| -f? | --fg= | --foreground= | --foreground-color= | see COLORS  |'
  _zx -br '| -b? | --bg= | --background= | --background-color= | see COLORS  |'
  _zx -tb '| -t? | --te= |  --emphasis= |      --text-effect= | see EFFECTS |'
  _zx -ti '| -t? | --em= |       --emph= |         --emphasis= |             |'
  _zx     '| -pX | --ps= |        --pos= |       --positional= | see FORMS  |'
  _zx     '    X=fbt or =f/b/t'
  _zx
  _zx -tr '## VIEW FLAGS'
  _zx -tc '| Ch | Ch | shrt |  word |          long |                        |'
  _zx -tc '|---:|----|------|-------:|--------------:|------------------------|'
  _zx     '| -a | -H | --ho | --head |  --head-only | starts colourful text  |'
  _zx     '| -z | -T | --to | --tail |  --tail-only | ends colourful text    |'
  _zx     '| -w | -P | --pw | --wrap | --prompt-wrap | wraps for shell prompt |'
  _zx
  _zx -tr '## COLORS'
  _zx
  _zx -e -tc   '|      |\e[0m    |    |         |          |         |'
  _zx -e -td '|------|\e[0m----|----|---------|----------|---------|\n|'
  _zx -nf-k ' █▓▒░ '
  _zx -ne   '| -k | -0 | rgb-000 | -black  | black   |\n|'
  _zx -nf-k ' █▓▒░ '
  _zx -ne   '| +k | +0 | rgb+000 | +black  | gray    |\n|'
  _zx -nf-r ' █▓▒░ '
  _zx -ne   '| -r | -1 | rgb-100 | -red    | red     |\n|'
  _zx -nf+r ' █▓▒░ '
  _zx -ne   '| +r | +1 | rgb+100 | +red    |         |\n|'

  _zx -ef-g '| █▓▒░ |\e[0m -g | -2 | rgb-010 | -green  | green  |'
  _zx -ef+g '| █▓▒░ |\e[0m +g | +2 | rgb+010 | +green  |         |'
  _zx -ef-y '| █▓▒░ |\e[0m -y | -3 | rgb-110 | -yellow  | yellow  |'
  _zx -ef+y '| █▓▒░ |\e[0m +y | +3 | rgb+110 | +yellow  |         |'
  _zx -ef-b '| █▓▒░ |\e[0m -b | -4 | rgb-001 | -blue    | blue    |'
  _zx -ef+b '| █▓▒░ |\e[0m +b | +4 | rgb+001 | +blue    |         |'
  _zx -ef-m '| █▓▒░ |\e[0m -m | -5 | rgb-101 | -magenta | magenta |'
  _zx -ef+m '| █▓▒░ |\e[0m +m | +5 | rgb+101 | +magenta |         |'
  _zx -ef-c '| █▓▒░ |\e[0m -c | -6 | rgb-011 | -cyan    | cyan    |'
  _zx -ef+c '| █▓▒░ |\e[0m +c | +6 | rgb+011 | +cyan    |         |'
  _zx -ef-w '| █▓▒░ |\e[0m -w | -7 | rgb-111 | -white  | white  |'
  _zx -ef+w '| █▓▒░ |\e[0m +w | +7 | rgb+111 | +white  |         |'
  _zx
  _zx
  _zx -tr '## EFFECTS '
  _zx
  _zx -etc '|           |\e[0m  |  |    |           |        |'
  _zx -etd '|-----------|\e[0m---|---|----|-----------|--------|'
  _zx -et0 '|     reset |\e[0m 0 |  |    | clear     | reset  |'
  _zx -etb '|      bold |\e[0m 1 | b |    | bold      |        |'
  _zx -etf '|     faint |\e[0m 2 | f |    | faint     |        |'
  _zx -etd '|       dim |\e[0m 2 | d |    | dim       |        |'
  _zx -eti '|    italic |\e[0m 3 | i | it | italic    |        |'
  _zx -eti '|  emphasis |\e[0m 3 | e | em | emphasis  |        |'
  _zx -etu '| underline |\e[0m 4 | u | un | underline |        |'
  _zx -etl '|     blink |\e[0m 5 | l |    | blink     |        |'
  _zx -etr '|  reverse |\e[0m 7 | r | re | reverse  |        |'
  _zx -etc '|  conceal |\e[0m 8 | c | co | conceal  |        |'
  _zx -etx '| strikeout |\e[0m 9 | x | s  | strike    | del    |'
  _zx

}


_zx__punct_to_sep__native() {

  data="${1}"
  punct="${2}"  # [[:punct:]] or [[:punct:]|[:space:]]
  sep="${3}"

  punct_suffix="${punct}*"
  punct_prefix="*${punct}"

  _zx__replace_=''

  # shellcheck disable=SC2295
  while test "${data#${punct_prefix}}" != "${data}"; do
    # shellcheck disable=SC2295
    item="${data%%${punct_suffix}}"
    #  Example: 'a/b:cd' --> 'a'
    #     'a/b:cd' but without longest suffix '/b:cd'
    if test -n "${item}"; then
      # Handle case with empty item. E.g.: '::x:y'
      if test -n "${_zx__replace_}"; then
        # If not empty — append separator.
        _zx__replace_="${_zx__replace_}${sep}"
      fi
      _zx__replace_="${_zx__replace_}${item}"
    fi
    # shellcheck disable=SC2295
    te_name_seq="${data#${punct_prefix}}"
  done
}

_zx__punct_to_sep() {
  data="${1}"
  punct="${2}"  # [[:punct:]] or [[:punct:]|[:space:]]
  sep="${3}"

  # COMPATIBILITY NOTE:
    # ---------------------------------------------------------------
    #  bash/zsh/ksh93:
    #     res="${data//${punct}/${sep}}"
    #  posix:
    #     res=$(echo "${data}" | sed "s/${punct}+/${sep}/")
    #     OR
    #     awk_prog='BEGIN{$0=v;gsub(/[[:punct:]]/,s);print}'
    #     res=$(awk -vv="${data}" -vs="${sep}" "${awk_prog}")
    #     OR
    # ---------------------------------------------------------------

    _zx__punct_to_sep_=$(
      echo "${data}${sep}" | sed "s/${punct}+/${sep}/g"
      # Append separator to the end to handle
      # the last value as the others.
    )

}

{ # _zx__text_effect__*
  _zx__text_effect__code() {
    case $(awk -v "i=${1}" 'BEGIN{$0=X;print tolower(i)}') in
      0 | clear | reset)
        _zx__text_effect__code_=0
        ;;
      1 | b | bold)
        _zx__text_effect__code_=1
        ;;
      2 | d | f | dim | faint)
        _zx__text_effect__code_=2
        ;;
      3 | i | italic)
        _zx__text_effect__code_=3
        ;;
      4 | u | underline)
        _zx__text_effect__code_=4
        ;;
      5 | l | blink)
        _zx__text_effect__code_=5
        ;;
      7 | r | reverse)
        _zx__text_effect__code_=7
        ;;
      8 | c | conceal)
        _zx__text_effect__code_=8
        ;;
      9 | s | x | strike* | del)
        _zx__text_effect__code_=9
        ;;
      '' | e | empty)
        _zx__text_effect__code_=-1
        ;;
      *)
        _zx__text_effect__code_=-2
        ;;
    esac
  }

  _zx__text_effect__code_seq() {
    te_name_seq="${1}"
    #           Example: 'b:i:ru'.

    te_sep="${2:-${__ZX__FMT_SEP}}"
    te_code_seq=''

    _zx__punct_to_sep "${te_name_seq}" "${te_sep}"
    #           Example: 'b/i/ru'.

    te_name_seq="${_zx__punct_to_sep_}"
    #           Example: 'b:i:ru:'.

    te_sep_suffix="[${__ZX_SPACE_PUNCT}]*"
    te_sep_prefix="*[${__ZX_SPACE_PUNCT}]"

    # shellcheck disable=SC2295
    while test "${te_name_seq#${te_sep_prefix}}" != "${te_name_seq}"; do
      #         Example: 1  'i:ru:' != 'b:i:ru:'
      #                  2    'ru:' != 'i:ru:'
      #                  3       '' != 'ru:'
      #                  4        '' == '', so stop iterations.

      # shellcheck disable=SC2295
      te_name="${te_name_seq%%${te_sep_suffix}}"
      #         Example: 'b:i:ru' --> 'b'
      #                  'b:i:ru' but without longest suffix ':i:ru'

      if test -n "${te_name}"; then
        _zx__text_effect__code "${te_name}"
        # Get code.
        #       Example: 'b' --> '1'.
        if test "${_zx__text_effect__code_}" -gt 0; then
          if test -n "${te_code_seq}"; then
            # If not empty — append separator.
            te_code_seq="${te_code_seq}${te_sep}"
          fi
          te_code_seq="${te_code_seq}${_zx__text_effect__code_}"
        elif test "${_zx__text_effect__code_}" -eq -2; then
          if test ${#te_name} -gt 1; then
            # The code is unknown and te_name is more than one character.
            #   Example: te_name='ru'.

            may_be_te_name_seq=$(
              echo "${te_name}" | sed "s/./&${te_sep}/g"
            )
            te_name_seq="${te_name_seq}${te_sep}${may_be_te_name_seq}"
          fi
        fi
      fi
      # shellcheck disable=SC2295
      te_name_seq="${te_name_seq#${te_sep_prefix}}"
    done
    _zx__text_effect__code_seq_="${te_code_seq}"

    _zx__gc _zx__text_effect__code_ _zx__punct_to_sep_
    _zx__gc te_sep te_sep_suffix te_sep_prefix
    _zx__gc te_code_seq te_name te_name_seq may_be_te_name_seq
  }
}

{ # _zx__color__*
  _zx__color__code_case() {
    case ${1} in
      [[:lower:]]*)
        _zx__color__code_case_="-${1}"
        ;;
      [[:upper:]]*)
        _zx__color__code_case_="+${1}"
        ;;
      *)
        _zx__color__code_case_="${1}"
        ;;
    esac
  }

  _zx__color__rename() {
    _zx__colors_="cyan|magenta|yellow|black|red|green|blue|white"
    _zx__colors_="${_zx__colors_}|c|m|y|k|r|g|b|w"
    _zx__patten_="
      s/^((d|dark|ba|basic)(\W|_)?)(${_zx__colors_})$/-\4/gi;
      s/^((i|l|light|br|bright)(\W|_)?)(${_zx__colors_})?$/+\4/gi;
      s/^(${_zx__colors_})((\W|_)?(\-|d|dark|ba|basic))$/-\1/gi;
      s/^(${_zx__colors_})((\W|_)?(\+|i|l|light|b|br|bright))$/+\1/gi;
      "
    _zx__color__rename_=$(
      awk -v "i=${1}" 'BEGIN{$0=X;print tolower(i)}' | sed -re "${_zx__patten_}"
    )
    _zx__gc _zx__colors_
    _zx__gc _zx__patten_
  }

  _zx__color__std_name() {
    # shellcheck disable=SC2312
    _zx__color__rename "${1}"
    case "${_zx__color__rename_}" in
      -k | k | -0 | 0 | 30 | 40 | rgb-000 | -black | black)
        _zx__color__std_name_='basic black'
        ;;
      -r | r | -1 | 1 | 31 | 41 | rgb-100 | -red | red)
        _zx__color__std_name_='basic red'
        ;;
      -g | g | -2 | 2 | 32 | 42 | rgb-010 | -green | green)
        _zx__color__std_name_='basic green'
        ;;
      -y | y | -3 | 3 | 33 | 43 | rgb-110 | -yellow | yellow)
        _zx__color__std_name_='basic yellow'
        ;;
      -b | b | -4 | 4 | 34 | 44 | rgb-001 | -blue | blue)
        _zx__color__std_name_='basic blue'
        ;;
      -m | m | -5 | 5 | 35 | 45 | rgb-101 | -magenta | magenta)
        _zx__color__std_name_='basic magenta'
        ;;
      -c | c | -6 | 6 | 36 | 46 | rgb-011 | -cyan | cyan)
        _zx__color__std_name_='basic cyan'
        ;;
      -w | w | -7 | 7 | 37 | 47 | rgb-111 | -white | white)
        _zx__color__std_name_='basic white'
        ;;
      ## bright colors
      +k | +0 | 90 | 100 | rgb+000 | +black | gray)
        _zx__color__std_name_='bright black'
        ;;
      +r | +1 | 91 | 101 | rgb+100 | +red)
        _zx__color__std_name_='bright red'
        ;;
      +g | +2 | 92 | 102 | rgb+010 | +green)
        _zx__color__std_name_='bright green'
        ;;
      +y | +3 | 93 | 103 | rgb+110 | +yellow)
        _zx__color__std_name_='bright yellow'
        ;;
      +b | +4 | 94 | 104 | rgb+001 | +blue)
        _zx__color__std_name_='bright blue'
        ;;
      +m | +5 | 95 | 105 | rgb+101 | +magenta)
        _zx__color__std_name_='bright magenta'
        ;;
      +c | +6 | 96 | 106 | rgb+011 | +cyan)
        _zx__color__std_name_='bright cyan'
        ;;
      +w | +7 | 97 | 107 | rgb+111 | +white)
        _zx__color__std_name_='bright white'
        ;;
      '' | [[:punct:]]* | e | empty)
        _zx__color__std_name_='empty color'
        ;;
      *)
        ( # use subshell
          _zx -n -fr -by -cauto "Error:"
          _zx -n -fr -cauto " unknown color ${1}"
          _zx
        ) >&2
        _zx__color__std_name_='unknown color'
        ;;
    esac
    _zx__gc _zx__color__rename_
  }

  _zx__color__code_pair() {
    case "${1}" in
      'basic black')
        _zx__color__code_pair_='30 40'
        ;;
      'basic red')
        _zx__color__code_pair_='31 41'
        ;;
      'basic green')
        _zx__color__code_pair_='32 42'
        ;;
      'basic yellow')
        _zx__color__code_pair_='33 43'
        ;;
      'basic blue')
        _zx__color__code_pair_='34 44'
        ;;
      'basic magenta')
        _zx__color__code_pair_='35 45'
        ;;
      'basic cyan')
        _zx__color__code_pair_='36 46'
        ;;
      'basic white')
        _zx__color__code_pair_='37 47'
        ;;
      'bright black')
        _zx__color__code_pair_='90 100'
        ;;
      'bright red')
        _zx__color__code_pair_='91 101'
        ;;
      'bright green')
        _zx__color__code_pair_='92 102'
        ;;
      'bright yellow')
        _zx__color__code_pair_='93 103'
        ;;
      'bright blue')
        _zx__color__code_pair_='94 104'
        ;;
      'bright magenta')
        _zx__color__code_pair_='95 105'
        ;;
      'bright cyan')
        _zx__color__code_pair_='96 106'
        ;;
      'bright white')
        _zx__color__code_pair_='97 107'
        ;;
      'empty color')
        _zx__color__code_pair_='-1 -1'
        ;;
      'unknown color')
        _zx__color__code_pair_='-2 -2'
        ;;
      *)
        _zx__color__code_pair_='-3 -3'
        ;;
    esac
  }

  _zx__color__fg_code() {
    _zx__color__code_pair "${1}"
    _zx__color__fg_code_="${_zx__color__code_pair_%\ *}"
    _zx__gc _zx__color__code_pair_
  }

  _zx__color__bg_code() {
    _zx__color__code_pair "${1}"
    _zx__color__bg_code_="${_zx__color__code_pair_#*\ }"
    _zx__gc _zx__color__code_pair_
  }
}

_zx__join_code_seq() {
  code_seq="${1}"
  fmt_sep="${2:-${__ZX__FMT_SEP}}"
  ansi_sep="${3:-${__ZX__ESC_ANSI_SEP}}"

  fmt_sep_suffix="${fmt_sep}*"
  fmt_sep_prefix="*${fmt_sep}"

  code_str=''
  code_seq="${code_seq}${fmt_sep}"

  # shellcheck disable=SC2295
  while test "${code_seq#${fmt_sep_prefix}}" != "${code_seq}"; do
    code="${code_seq%%${fmt_sep_suffix}}"
    if test -n "${code}"; then
      if test "${code}" -gt 0; then
        if test -n "${code_str}"; then
          code_str="${code_str}${ansi_sep}"
        fi
        code_str="${code_str}${code}"
      fi
    fi
    code_seq="${code_seq#${fmt_sep_prefix}}"
  done
  _zx__join_code_seq_="${code_str}"
  _zx__gc code_seq fmt_sep ansi_sep code_str code
}

_zx__code_str() {
  fg_name="${1}"
  bg_name="${2}"
  te_name_seq="${3}"
  fmt_sep="${4:-${__ZX__FMT_SEP}}"
  ansi_sep="${5:-${__ZX__ESC_ANSI_SEP}}"

  if test -n "${fg_name}"; then
    _zx__color__std_name "${fg_name}"
    _zx__color__fg_code "${_zx__color__std_name_}"
    code_seq="${_zx__color__fg_code_}"
  fi
  if test -n "${bg_name}"; then
    _zx__color__std_name "${bg_name}"
    _zx__color__bg_code "${_zx__color__std_name_}"
    code_seq="${code_seq}${fmt_sep}${_zx__color__bg_code_}"
  fi
  if test -n "${te_name_seq}"; then
    _zx__text_effect__code_seq "${te_name_seq}" "${fmt_sep}"
    code_seq="${code_seq}${fmt_sep}${_zx__text_effect__code_seq_}"
  fi
  _zx__join_code_seq "${code_seq}" "${fmt_sep}" "${ansi_sep}"
  _zx__code_str_="${_zx__join_code_seq_}"

  _zx__gc fg_name bg_name te_name_seq fmt_sep ansi_sep

  _zx__gc _zx__color__std_name_
  _zx__gc _zx__color__fg_code_
  _zx__gc _zx__color__bg_code_
  _zx__gc _zx__text_effect__code_seq_
  _zx__gc _zx__join_code_seq_
}

_zx__out() {
  format_name="${1}"
  data="${2}"

  _zx__out_="${data}"

  case "${1}" in
    *WRAPPED*)
      _zx__out_="\0001${_zx__out_}\0002"
      # \[ = \1 = \x01 = \0001, do not use \001! Octal format is \0nnn.
      # \] = \2 = \x02 = \0002, do not use \002! Octal format is \0nnn.
      ;;
    *) ;;
  esac

  case "${format_name}" in
    *STRING*)
      # do nothing
      ;;
    *DEBUG*)
      printf '%s' "${_zx__out_}"
      ;;
    *ESCAPED*)
      printf '%b' "${_zx__out_}"
      ;;
    *PRINTABLE*)
      printf '%s' "${_zx__out_}"
      ;;
    *)
      # do nothing
      ;;
  esac

  _zx__gc format_name data
}

_zx__head() {
  _zx__code_str "${@}"

  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #  bash/zsh:
  #     ESC = \x1b = \e = \E
  #  ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------
  _zx__head_=''
  if test -n "${_zx__code_str_}"; then
    _zx__head_="\0033[${_zx__code_str_}m"
  fi
  _zx__gc _zx__code_str_
}

_zx__tail() {
  _zx__text_effect__code reset
  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #  bash/zsh:
  #     ESC = \x1b = \e = \E
  #  ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------

  _zx__tail_=''
  if test -n "${_zx__text_effect__code_}"; then
    _zx__tail_="\0033[${_zx__text_effect__code_}m"
  fi
  _zx__gc _zx__text_effect__code_
}

_zx__pos() {
  arg="${1}"
  te_sep="${2:-${__ZX__FMT_SEP}}"
  pos_sep="${3}"
  LONG_POS_MARKER='[-+/!:=\ ]'
  case "${arg}" in
     *${LONG_POS_MARKER}*)
      local_sep="${te_sep}"
      # COMPATIBILITY NOTE:
      # ---------------------------------------------------------
      #  bash/zsh/ksh93:
      #     std_arg="${arg//[[:punct:]]/${local_sep}}"
      #  posix:
      #     # shellcheck disable=SC2001
      #     std_arg=$(echo "${arg}" | sed "s/[[:punct:]]/${local_sep}/g")
      #     OR
      #     std_arg=$(echo "${arg}" | awk -v X="${local_sep}" '{gsub(/[[:punct:]]/,X); print}'
      # ---------------------------------------------------------
      # shellcheck disable=SC2001
      arg=$(
        echo "${arg}${local_sep}" | sed -E "s/${LONG_POS_MARKER}+/${local_sep}/g"
      )

      local_sep_suffix="[${local_sep}]*"
      local_sep_prefix="*[${local_sep}]"

      if test "${arg#${local_sep_prefix}}" != "${arg}"; then
        fg_name="${arg%%${local_sep_suffix}}"
        arg="${arg#${local_sep_prefix}}"
      fi
      if test "${arg#${local_sep_prefix}}" != "${arg}"; then
        bg_name="${arg%%${local_sep_prefix}}"
        arg="${arg#${local_sep_prefix}}"
      fi
      if test "${arg#${local_sep_prefix}}" != "${arg}"; then
        te_name_seq="${arg}"
      fi
      _zx__gc local_sep
      ;;
    *)
      # COMPATIBILITY NOTE:
      # ---------------------------------------------------------
      #  bash/zsh/ksh93:
      #     fg_name="${arg:0:1}"
      #     bg_name="${arg:1:1}"
      #     te_name_seq="${arg:2}"
      #  posix:
      #     fg_name=$(echo "${arg}" | cut -c1)
      #     bg_name=$(echo "${arg}" | cut -c2)
      #     te_name_seq=$(echo "${arg}" | cut -c3-)
      # ---------------------------------------------------------

      fg_name=$(echo "${arg}" | cut -c1)
      bg_name=$(echo "${arg}" | cut -c2)
      te_name_seq=$(echo "${arg}" | cut -c3-)

      # shellcheck disable=SC2001
      #  bash==5.1.16
      #  complex substitution:
      #  split every char with ${te_sep}
      te_name_seq=$(echo "${te_name_seq}" | sed "s/./&${te_sep}/g")
      ;;
  esac
  _zx__gc arg te_sep LONG_POS_MARKER

  _zx__color__code_case "${fg_name}"
  _zx__pos__fg_name_="${_zx__color__code_case_}"
  _zx__color__code_case "${bg_name}"
  _zx__pos__bg_name_="${_zx__color__code_case_}"
  _zx__pos__te_name_seq_="${te_name_seq}"
  _zx__gc _zx__color__code_case_

  if test -n "${pos_sep}"; then
    _zx__pos_="${fg_name}${pos_sep}${bg_name}${pos_sep}${te_name_seq}"
  fi
  _zx__gc  fg_name bg_name te_name_seq pos_sep
}

_zx__getopt() {
  nm='_zx'
  so='' # — short opt_seq
  ## MAIN SHORT opt_seq
  so="${so}f:" # — foreground
  so="${so}b:" # — background
  so="${so}t:" # — opt_text effect or emphasis
  so="${so}p:" # — positional form
  so="${so}h"  # — help
  so="${so}v"  # — version
  so="${so}aH" # — head only
  so="${so}zT" # — tail only
  so="${so}wP" # — prompt wrap
  so="${so}s"  # — do not output anything; sets _zx-string

  ## ECHO COMPATIBILITY SHORT opt_seq:
  so="${so}n"  # — do not output the trailing newline.
  so="${so}e"  # — enable escapes interpretation for opt_text.
  so="${so}E"  # — disable escapes interpretation for opt_text.
  so="${so}Dd"  # — disable escapes interpretation for all.

  ## COREUTILS COMPATIBILITY SHORT opt_seq:
  so="${so}c::a"
  # -c=[always|never|auto] like with diff, ls, grep and others.
  # Plain -c means -c='auto'. Another values works as for -f.
  # -a means -c='auto'.

  lo=""
  # MAIN LONG opt_seq
  lo="${lo}fg:,foreground:,foreground-color:,"
  lo="${lo}bg:,background:,background-color:,"
  lo="${lo}te:,text-effect:,em:,emphasis:,"
  lo="${lo}ps:,pos:,positional:,"
  lo="${lo}help,"
  lo="${lo}version,"

  lo="${lo}ho,head-only," # — head only
  lo="${lo}to,tail-only," # — tail only
  lo="${lo}pw,wrap,prompt-wrap,"      # — prompt wrap
  lo="${lo}str,string,"  # — do not output anything; sets _zx-string

  ## ECHO COMPATIBILITY LONG opt_seq:
  lo="${lo}nn,no-newline,"

  lo="${lo}esc,escapes,"
  lo="${lo}ne,nesc,no-esc,no-escapes,"
  lo="${lo}debug,"

  ## COREUTILS COMPATIBILITY LONG opt_seq:
  lo="${lo}color::,auto,auto-color"
  # --color=[always|never|auto] like with diff, ls, grep.
  # Plain --color means --color='auto'. Another values
  # e.g (NOT 'always|never|auto)  works as for --foreground.
  # --auto and --auto-color means --color='auto'.

  getopt -n "${nm}" -o "${so}" -l "${lo}" -- "${@}"
  _zx__gc nm so lo
}

_zx__configure() {
  _zx__configure__options_=$(_zx__getopt "${@}")
  eval set -- "${_zx__configure__options_}"
  _zx__configure__status_=''
  while test $# -gt 0; do
    case ${1} in
      # MAIN opt_seq
      -f | --fg | --foreground | --foreground-color)
        opt_fg_name="${2}"
        shift 2
        ;;
      -b | --bg | --background | --background-color)
        opt_bg_name="${2}"
        shift 2
        ;;
      -t | --te | --text-effect | --em | --emph | --emphasis)
        if test -n "${opt_te_name_seq}"; then
          opt_te_name_seq="${opt_te_name_seq} "
        fi
        opt_te_name_seq="${opt_te_name_seq}${2}"
        shift 2
        ;;
      -p | --ps | --pos | positional)
        opt_pos_args_seq="${2}"
        shift 2
        ;;
      -h | --help)
        _zx__configure__status_='HELP'
        return 0
        ;;
      -v | --version)
        _zx__configure__status_='VERSION'
        return 0
        ;;
      -a | -H | --ho | --head | --head-only)
        opt_use_head=true
        opt_use_tail=false
        shift 1
        ;;
      -z | -T | --to | --tail | --tail-only)
        opt_use_head=false
        opt_use_tail=true
        shift 1
        ;;
      -w | -P | --pw | --wrap | --prompt-wrap)
        opt_esc_format="${opt_esc_format}+WRAPPED"
        shift 1
        ;;
      # ECHO COMPATIBILITY
      -n | --nn | --nonewline)
        # Echo compatibility.
        opt_use_newline=false
        shift 1
        ;;
      -s | --str | --string)
        opt_txt_format="${opt_txt_format}+STRING"
        opt_esc_format="${opt_esc_format}+STRING"
        opt_nln_format="${opt_txt_format}+STRING"
        shift 1
        ;;
      -e | --esc | --escapes)
        # Echo compatibility.
        opt_txt_format="${opt_txt_format}+ESCAPED"
        shift 1
        ;;
      -E | --ne | --nesc | --no-esc | --no-escapes)
        # Echo compatibility.
        opt_txt_format="${opt_txt_format}+PRINTABLE"
        shift 1
        ;;
      -D | --debug)
        # Echo compatibility.
        opt_esc_format="${opt_esc_format}+DEBUG"
        shift 1
        ;;
      # COREUTILS COMPATIBILITY
      -c | --color)
        ## Coreutils compatibility.
        arg="${2:-auto}"
        case "${arg}" in
          a | auto)
            opt_when_use_color='AUTO'
            ;;
          n | never)
            opt_when_use_color='NEVER'
            ;;
          A | always)
            opt_when_use_color='ALWAYS'
            ;;
          *)
            opt_fg_name="${arg}"
            ;;
        esac
        shift 2
        ;;
      '--' | '')
        shift 1
        break
        ;;
      *)
        _zx__configure__status_='UNKNOWN_PARAMETER'
        _zx__configure__unknown_option_="${1}"
        return 1
        ;;
    esac
  done
  opt_text="${*}"
  _zx__configure__status_='DONE'
}

_zx() {
  opt_fg_name=''
  opt_bg_name=''
  opt_te_name_seq=''
  opt_text=''
  opt_pos_args_seq=''

  opt_when_use_color='ALWAYS'
  opt_txt_format='PRINTABLE'
  opt_esc_format='ESCAPED'
  opt_nln_format='ESCAPED'

  opt_use_newline=true
  opt_use_head=true
  opt_use_tail=true

  _zx__configure "$@"

  case "${_zx__configure__status_}" in
    HELP)
      _zx__usage
      return 0
      ;;
    VERSION)
      _zx --text-effect reverse -- '0.1769981220'
      return 0
      ;;
    DONE) ;;

    UNKNOWN_PARAMETER)
      _zx >&2 --foreground +red -- \
        "zx: Unknown options: ${_zx__configure__unknown_option_};" \
        "with options ${_zx__configure__options_}"
      return 1
      ;;
    *)
      _zx >&2 --foreground +red --background +yellow -- \
        "zx: Unknown error" \
        "with options ${_zx__configure__options_}"
      return 1
      ;;
  esac
  _zx__gc _zx__configure__status_
  _zx__gc _zx__configure__options_

  if test -n "${opt_pos_args_seq}"; then
    _zx__pos "${opt_pos_args_seq}" "${__ZX__FMT_SEP}"
    opt_fg_name="${_zx__pos__fg_name_}"
    opt_bg_name="${_zx__pos__bg_name_}"
    opt_te_name_seq="${_zx__pos__te_name_seq_}"

    _zx__gc _zx__pos_
    _zx__gc _zx__pos__fg_name_
    _zx__gc _zx__pos__bg_name_
    _zx__gc _zx__pos__te_name_seq_
  fi

  # COREUTILS COMPATIBILITY
  output_type='FILE' && test -t '1' &&  output_type='STREAM'

  case "${opt_when_use_color}_${output_type}" in
    NEVER*)
      use_colors=false
      ;;
    ALWAYS*)
      use_colors=true
      ;;
    *STREAM)
      use_colors=true
      ;;
    *FILE)
      use_colors=false
      ;;
    *)
      use_colors=true
      ;;
  esac
  _zx_=''
  if "${use_colors}" && "${opt_use_head}"; then
    _zx__head  "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
    _zx__out  "${opt_esc_format}" "${_zx__head_}"
    _zx_="${_zx_}${_zx__out_}"
  fi
  _zx__out "${opt_txt_format}" "${opt_text}"
  _zx_="${_zx_}${_zx__out_}"
  if "${use_colors}" && "${opt_use_tail}" ; then
    if ! "${opt_use_head}" || test -n "${_zx__head_}" ; then
      # only if _zx__head_ exists
      _zx__tail  "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
      _zx__out  "${opt_esc_format}" "${_zx__tail_}"
      _zx_="${_zx_}${_zx__out_}"
    fi
  fi
  # ECHO COMPATIBILITY
  if "${opt_use_newline}"; then
    _zx__out "${opt_nln_format}" '\n'
    _zx_="${_zx_}${_zx__out_}"
  fi

  _zx__gc opt_bg_name opt_fg_name opt_te_name_seq opt_text
  _zx__gc opt_esc_format opt_nln_format opt_txt_format
  _zx__gc opt_pos_args_seq
  _zx__gc opt_use_head opt_use_tail opt_use_newline
  _zx__gc opt_when_use_color
  _zx__gc use_colors output_type

  _zx__gc __ZX__ESC_ANSI_SEP __ZX__FMT_SEP

  _zx__gc _zx__head_
  _zx__gc _zx__out_
  _zx__gc _zx__tail_

  _zx__unset_vars
}

_zx__gc() {
  if "${ZX_LAZY_UNSET}"; then
    _zx__gc_="${_zx__gc_} ${*}"
  else
    eval unset -v "${*}"
  fi
}

_zx__unset_vars() {
  if test -n "${_zx__gc_}"; then
    eval unset -v "${_zx__gc_}"
  fi
}

_zx__unset_functions() {
  unset -f _zx__usage
  unset -f _zx__punct_to_sep
  unset -f _zx__text_effect__code
  unset -f _zx__text_effect__code_seq
  unset -f _zx__color__code_case
  unset -f _zx__color__rename
  unset -f _zx__color__std_name
  unset -f _zx__color__code_pair
  unset -f _zx__color__fg_code
  unset -f _zx__color__bg_code
  unset -f _zx__join_code_seq
  unset -f _zx__code_str
  unset -f _zx__out
  unset -f _zx__head
  unset -f _zx__tail
  unset -f _zx__pos
  unset -f _zx__getopt
  unset -f _zx__configure
  unset -f _zx__gc_
}

_zx__unset_functions_all() {
  _zx__clean
  unset -f _zx
  unset -f _zx__unset_functions
  unset -f _zx__unset_functions_all
}
