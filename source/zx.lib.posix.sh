#!/usr/bin/env sh
# shellcheck enable=all

# COMPATIBILITY NOTE:
# ---------------------------------------------------------------
#   bash/zsh/ksh93:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln bash -d
#
#   See compatibility notes below and use posix variants.
#   How to check posix:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln posix -d
# ---------------------------------------------------------------

_zx__usage() {
  _zx -tr '# ZX'
  _zx
  _zx -tr '## USAGE'
  _zx
  _zx -td -fg '```'
  _zx -n -tb     -- '   zx '
  _zx -n -ti -tf -- '   [OPTIONS] '
  _zx -n -ti     -- '   [TEXT]'
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
  _zx -e '\t zx --fg red --bg yellow --te strikeout  some waring'
  _zx
  _zx -e  --fg red --bg yellow --te strikeout  '\t some waring'
  _zx
  _zx -tr '## OPTIONS'
  _zx
  _zx     '|        |       |               |                     |'
  _zx     '|-------:|-------|---------------|---------------------|'
  _zx -fr '|    -f? | --fg= | --foreground= | --foreground-color= |'
  _zx -br '|    -b? | --bg= | --background= | --background-color= |'
  _zx -tb '|    -t? | --te= |   --emphasis= |      --text-effect= |'
  _zx -ti '|    -t? | --em= |       --emph= |         --emphasis= |'
  _zx     '|  -p??? | --ps= |        --pos= |       --positional= |'
  _zx
  _zx -tr '## VIEW FLAGS'
  _zx
  _zx '|    |    |       |        |               |'
  _zx '|----|----|-------|--------|---------------|'
  _zx '| -a | -H | --ho  | --head |   --head-only |'
  _zx '| -z | -T | --to  | --tail |   --tail-only |'
  _zx '| -w | -P | --pw  | --wrap | --prompt-wrap |'
  _zx
   
   
  _zx -tr '## COLORS'
  _zx
  _zx -etc  '|      |\e[0m    |    |         |          |         |'
  _zx -etd  '|------|\e[0m----|----|---------|----------|---------|'
  _zx -ef-k '| █▓▒░ |\e[0m -k | -0 | rgb-000 | -black   | black   |'
  _zx -ef+k '| █▓▒░ |\e[0m +k | +0 | rgb+000 | +black   | gray    |'
  _zx -ef-r '| █▓▒░ |\e[0m -r | -1 | rgb-100 | -red     | red     |'
  _zx -ef+r '| █▓▒░ |\e[0m +r | +1 | rgb+100 | +red     |         |'
  _zx -ef-g '| █▓▒░ |\e[0m -g | -2 | rgb-010 | -green   | green   |'
  _zx -ef+g '| █▓▒░ |\e[0m +g | +2 | rgb+010 | +green   |         |'
  _zx -ef-y '| █▓▒░ |\e[0m -y | -3 | rgb-110 | -yellow  | yellow  |'
  _zx -ef+y '| █▓▒░ |\e[0m +y | +3 | rgb+110 | +yellow  |         |'
  _zx -ef-b '| █▓▒░ |\e[0m -b | -4 | rgb-001 | -blue    | blue    |'
  _zx -ef+b '| █▓▒░ |\e[0m +b | +4 | rgb+001 | +blue    |         |'
  _zx -ef-m '| █▓▒░ |\e[0m -m | -5 | rgb-101 | -magenta | magenta |'
  _zx -ef+m '| █▓▒░ |\e[0m +m | +5 | rgb+101 | +magenta |         |'
  _zx -ef-c '| █▓▒░ |\e[0m -c | -6 | rgb-011 | -cyan    | cyan    |'
  _zx -ef+c '| █▓▒░ |\e[0m +c | +6 | rgb+011 | +cyan    |         |'
  _zx -ef-w '| █▓▒░ |\e[0m -w | -7 | rgb-111 | -white   | white   |'
  _zx -ef+w '| █▓▒░ |\e[0m +w | +7 | rgb+111 | +white   |         |'
  _zx
  _zx
  _zx -tr '## TEXT EFFECTS '
  _zx
  _zx -etc '|           |\e[0m   |   |    |           |        |'
  _zx -etd '|-----------|\e[0m---|---|----|-----------|--------|'
  _zx -et0 '|     reset |\e[0m 0 | n |    | clear     | reset  |'
  _zx -etb '|      bold |\e[0m 1 | b |    | bold      |        |'
  _zx -etf '|     faint |\e[0m 2 | f |    | faint     |        |'
  _zx -etd '|       dim |\e[0m 2 | d |    | dim       |        |'
  _zx -eti '|    italic |\e[0m 3 | i | it | italic    |        |'
  _zx -eti '|  emphasis |\e[0m 3 | e | em | emphasis  |        |'
  _zx -etu '| underline |\e[0m 4 | u | un | underline |        |'
  _zx -etl '|     blink |\e[0m 5 | l |    | blink     |        |'
  _zx -etr '|   reverse |\e[0m 7 | r | re | reverse   |        |'
  _zx -etc '|   conceal |\e[0m 8 | c | co | conceal   |        |'
  _zx -etx '| strikeout |\e[0m 9 | x | s  | strike    | del    |'
  _zx

}

_zx_punct_to_sep() {
   # COMPATIBILITY NOTE:
    # ---------------------------------------------------------------
    #   bash/zsh/ksh93:
    #     res="${1//[[:punct:]]/${2}}"
    #   posix:
    #     # shellcheck disable=SC2001
    #     res=$(echo "${1}" | sed "s/[[:punct:]]/${2}/")
    #     OR
    #     awk_prog='BEGIN{$0=v;gsub(/[[:punct:]]/,s);print}'
    #     res=$(awk -vv="${1}" -vs="${2}" "${awk_prog}")
    # ---------------------------------------------------------------

    # shellcheck disable=SC2001
    _zx_punct_to_sep__=$(
      echo "${1}" | sed "s/[[:punct:]|[:space:]]/${2}/g"
  )
}

{ # _zx__text_effect__*
  _zx__text_effect__code() {
    case $(awk -vi="${1}" 'BEGIN{$0=X;print tolower(i)}') in
      0 | n | clear | reset)
        _zx__text_effect__code__=0
        ;;
      1 | b | bold)
        _zx__text_effect__code__=1
        ;;
      2 | d | f | dim | faint)
        _zx__text_effect__code__=2
        ;;
      3 | i | italic)
        _zx__text_effect__code__=3
        ;;
      4 | u | underline)
        _zx__text_effect__code__=4
        ;;
      5 | l | blink)
        _zx__text_effect__code__=5
        ;;
      7 | r | reverse)
        _zx__text_effect__code__=7
        ;;
      8 | c | conceal)
        _zx__text_effect__code__=8
        ;;
      9 | s | x | strike* | del)
        _zx__text_effect__code__=9
        ;;
      '')
        _zx__text_effect__code__=-1
        ;;
      *)
        _zx__text_effect__code__=-2
        ;;
    esac
  }
  _zx__text_effect__code_seq() {
    te_name_seq="${1}"
    te_sep="${2:-${__ZX__FMT_SEP}}"
    te_code_seq=''

    # COMPATIBILITY NOTE:
    # ---------------------------------------------------------------
    #   bash/zsh/ksh93:
    #     std_arg="${arg//[[:punct:]]/${te_sep}}"
    #   posix:
    #     # shellcheck disable=SC2001
    #     std_arg=$(echo "${arg}" | sed "s/[[:punct:]]/${te_sep}/")
    #     OR
    #     awk_prog='BEGIN{$0=v;gsub(/[[:punct:]]/,s);print}'
    #     std_arg=$(awk -vv="${arg}" -vs="${te_sep}" "${awk_prog}")
    # ---------------------------------------------------------------

    _zx_punct_to_sep "${te_name_seq}" "${te_sep}"
    te_name_seq="${_zx_punct_to_sep__}"

    te_name_seq="${te_name_seq}${te_sep}"
    while test "${te_name_seq#*"${te_sep}"}" != "${te_name_seq}"; do
      te_name="${te_name_seq%%"${te_sep}"*}"
      if test -n "${te_name}"; then
        _zx__text_effect__code "${te_name}"
        if test "${_zx__text_effect__code__}" -gt 0; then
          if test -n "${te_code_seq}"; then
            te_code_seq="${te_code_seq}${te_sep}"
          fi
          te_code_seq="${te_code_seq}${_zx__text_effect__code__}"
        elif test "${_zx__text_effect__code__}" -eq -2; then
          if test ${#te_name} -gt 1; then
            may_be_te_name_seq=$(
              echo "${te_name}" | sed "s/./&${te_sep}/g"
            )
            te_name_seq="${te_name_seq}${te_sep}${may_be_te_name_seq}"
          fi
        fi
      fi
      te_name_seq="${te_name_seq#*"${te_sep}"}"
    done
    _zx__text_effect__code_seq__="${te_code_seq}"

    unset -v _zx__text_effect__code__
    unset -v _zx_punct_to_sep__
    unset -v te_name_seq
    unset -v te_sep
    unset -v te_code_seq
    unset -v te_name
    unset -v may_be_te_name_seq
  }
}

{ # _zx__color__*
  _zx__color__code_case() {
    case ${1} in
      [[:lower:]])
        _zx__color__code_case__="-${1}"
        ;;
      [[:upper:]])
        _zx__color__code_case__="+${1}"
        ;;
      *)
        _zx__color__code_case__="${1}"
        ;;
    esac
  }

  _zx__color__rename() {
    colors="cyan|magenta|yellow|black|red|green|blue|white"
    colors="${colors}|c|m|y|k|r|g|b|w"
    patten="
      s/^((d|dark|ba|basic)(\W|_)?)(${colors})$/-\4/gi;
      s/^((i|l|light|br|bright)(\W|_)?)(${colors})?$/+\4/gi;
      s/^(${colors})((\W|_)?(\-|d|dark|ba|basic))$/-\1/gi;
      s/^(${colors})((\W|_)?(\+|i|l|light|b|br|bright))$/+\1/gi;
      "
    _zx__color__rename__=$(
      echo "${1}" | sed -re "${patten}"
    )
    unset -v colors
    unset -v patten
  }

  _zx__color__std_name() {
    color=$(awk -vi="${1}" 'BEGIN{$0=X;print tolower(i)}')
    _zx__color__rename "${color}"
    case "${_zx__color__rename__}" in
      -k | k | -0 | 0 | 30 | 40 | rgb-000 | -black | black)
        _zx__color__std_name__='basic black'
        ;;
      -r | r | -1 | 1 | 31 | 41 | rgb-100 | -red | red)
        _zx__color__std_name__='basic red'
        ;;
      -g | g | -2 | 2 | 32 | 42 | rgb-010 | -green | green)
        _zx__color__std_name__='basic green'
        ;;
      -y | y | -3 | 3 | 33 | 43 | rgb-110 | -yellow | yellow)
        _zx__color__std_name__='basic yellow'
        ;;
      -b | b | -4 | 4 | 34 | 44 | rgb-001 | -blue | blue)
        _zx__color__std_name__='basic blue'
        ;;
      -m | m | -5 | 5 | 35 | 45 | rgb-101 | -magenta | magenta)
        _zx__color__std_name__='basic magenta'
        ;;
      -c | c | -6 | 6 | 36 | 46 | rgb-011 | -cyan | cyan)
        _zx__color__std_name__='basic cyan'
        ;;
      -w | w | -7 | 7 | 37 | 47 | rgb-111 | -white | white)
        _zx__color__std_name__='basic white'
        ;;
      ## bright colors
      +k | +0 | 90 | 100 | rgb+000 | +black | gray)
        _zx__color__std_name__='bright black'
        ;;
      +r | +1 | 91 | 101 | rgb+100 | +red)
        _zx__color__std_name__='bright red'
        ;;
      +g | +2 | 92 | 102 | rgb+010 | +green)
        _zx__color__std_name__='bright green'
        ;;
      +y | +3 | 93 | 103 | rgb+110 | +yellow)
        _zx__color__std_name__='bright yellow'
        ;;
      +b | +4 | 94 | 104 | rgb+001 | +blue)
        _zx__color__std_name__='bright blue'
        ;;
      +m | +5 | 95 | 105 | rgb+101 | +magenta)
        _zx__color__std_name__='bright magenta'
        ;;
      +c | +6 | 96 | 106 | rgb+011 | +cyan)
        _zx__color__std_name__='bright cyan'
        ;;
      +w | +7 | 97 | 107 | rgb+111 | +white)
        _zx__color__std_name__='bright white'
        ;;
      '')
        _zx__color__std_name__='empty color'
        ;;
      *)
        printf >&2 "\e[31mError unknown color '%s' \e[0m\n" "${color}"
        _zx__color__std_name__='unknown color'
        ;;
    esac
    unset -v color
    unset -v _zx__color__rename__
  }

  _zx__color__code_pair() {
    case "${1}" in
      'basic black')
        _zx__color__code_pair__='30 40'
        ;;
      'basic red')
        _zx__color__code_pair__='31 41'
        ;;
      'basic green')
        _zx__color__code_pair__='32 42'
        ;;
      'basic yellow')
        _zx__color__code_pair__='33 43'
        ;;
      'basic blue')
        _zx__color__code_pair__='34 44'
        ;;
      'basic magenta')
        _zx__color__code_pair__='35 45'
        ;;
      'basic cyan')
        _zx__color__code_pair__='36 46'
        ;;
      'basic white')
        _zx__color__code_pair__='37 47'
        ;;
      'bright black')
        _zx__color__code_pair__='90 100'
        ;;
      'bright red')
        _zx__color__code_pair__='91 101'
        ;;
      'bright green')
        _zx__color__code_pair__='92 102'
        ;;
      'bright yellow')
        _zx__color__code_pair__='93 103'
        ;;
      'bright blue')
        _zx__color__code_pair__='94 104'
        ;;
      'bright magenta')
        _zx__color__code_pair__='95 105'
        ;;
      'bright cyan')
        _zx__color__code_pair__='96 106'
        ;;
      'bright white')
        _zx__color__code_pair__='97 107'
        ;;
      'empty color')
        _zx__color__code_pair__='-1 -1'
        ;;
      'unknown color')
        _zx__color__code_pair__='-2 -2'
        ;;
      *)
        _zx__color__code_pair__='-3 -3'
        ;;
    esac
  }

  _zx__color__fg_code() {
    _zx__color__code_pair "${1}"
    _zx__color__fg_code__="${_zx__color__code_pair__%\ *}"
    unset -v _zx__color__code_pair__
  }

  _zx__color__bg_code() {
    _zx__color__code_pair "${1}"
    _zx__color__bg_code__="${_zx__color__code_pair__#*\ }"
    unset -v _zx__color__code_pair__
  }
}

_zx__join_code_seq() {
  code_seq="${1}"
  fmt_sep="${2:-${__ZX__FMT_SEP}}"
  ansi_sep="${3:-${__ZX__ESC_ANSI_SEP}}"

  code_str=''
  code_seq="${code_seq}${fmt_sep}"
  while test "${code_seq#*"${fmt_sep}"}" != "${code_seq}"; do
    code="${code_seq%%"${fmt_sep}"*}"
    if test -n "${code}"; then
      if test "${code}" -gt 0; then
        if test -n "${code_str}"; then
          code_str="${code_str}${ansi_sep}"
        fi
        code_str="${code_str}${code}"
      fi
    fi
    code_seq="${code_seq#*"${fmt_sep}"}"
  done
  _zx__join_code_seq="${code_str}"
}

_zx__code_str() {
  fg_name="${1}"
  bg_name="${2}"
  te_name_seq="${3}"
  fmt_sep="${4:-${__ZX__FMT_SEP}}"
  ansi_sep="${5:-${__ZX__ESC_ANSI_SEP}}"

  if test -n "${fg_name}"; then
    _zx__color__std_name "${fg_name}"
    _zx__color__fg_code "${_zx__color__std_name__}"
    code_seq="${_zx__color__fg_code__}"
  fi
  if test -n "${bg_name}"; then
    _zx__color__std_name "${bg_name}"
    _zx__color__bg_code "${_zx__color__std_name__}"
    code_seq="${code_seq}${fmt_sep}${_zx__color__bg_code__}"
  fi
  if test -n "${te_name_seq}"; then
    _zx__text_effect__code_seq "${te_name_seq}" "${fmt_sep}"
    code_seq="${code_seq}${fmt_sep}${_zx__text_effect__code_seq__}"
  fi
  _zx__join_code_seq "${code_seq}" "${fmt_sep}" "${ansi_sep}"
  _zx__code_str__="${_zx__join_code_seq}"
}

_zx__out() {
  format_name="${1}"
  data="${2}"

  case "${1}" in
    *WRAPPED*)
      data="\0001${data}\0002"
      # \[ = \1 = \x01 = \0001, do not use \001! Octal format is \0nnn.
      # \] = \2 = \x02 = \0002, do not use \002! Octal format is \0nnn.
      ;;
    *) ;;

  esac
  case "${format_name}" in
    *ESCAPED*)
      printf '%b' "${data}"
      ;;
    *PRINTABLE*)
      printf '%s' "${data}"
      ;;
    *)
      printf '%s' "${data}"
      ;;
  esac
      unset -v format_name
  unset -v data
}

_zx__head() {
  _zx__code_str "${@}"

  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #   bash/zsh:
  #     ESC = \x1b = \e = \E
  #   ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------
  _zx__head__="\0033[${_zx__code_str__}m"
}

_zx__tail() {
  _zx__text_effect__code reset
  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #   bash/zsh:
  #     ESC = \x1b = \e = \E
  #   ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------

  _zx__tail__="\0033[${_zx__text_effect__code__}m"
}

_zx__pos() {
  arg="${1}"
  te_sep="${2:-${__ZX__FMT_SEP}}"
  pos_sep="${3}"
  case "${arg}" in
    *[[:punct:]]*)
      local_sep="${te_sep}"
      # COMPATIBILITY NOTE:
      # ---------------------------------------------------------
      #   bash/zsh/ksh93:
      #     std_arg="${arg//[[:punct:]]/${local_sep}}"
      #   posix:
      #     # shellcheck disable=SC2001
      #     std_arg=$(echo "${arg}" | sed "s/[[:punct:]]/${local_sep}/g")
      #     OR
      #     std_arg=$(echo "${arg}" | awk -v X="${local_sep}" '{gsub(/[[:punct:]]/,X); print}'
      # ---------------------------------------------------------
      # shellcheck disable=SC2001
      arg=$(
        echo "${arg}" | sed "s/[[:punct:]|[:space:]]/${local_sep}/g"
      )
      fg_name="${arg%%"${local_sep}"*}"
      arg="${arg#*"${local_sep}"}"
      bg_name="${arg%%"${local_sep}"*}"
      arg="${arg#*"${local_sep}"}"
      te_name_seq="${arg}"
      ;;
    *)
      # COMPATIBILITY NOTE:
      # ---------------------------------------------------------
      #   bash/zsh/ksh93:
      #     fg_name="${arg:0:1}"
      #     bg_name="${arg:1:1}"
      #     te_name_seq="${arg:2}"
      #   posix:
      #     fg_name=$(echo "${arg}" | cut -c1)
      #     bg_name=$(echo "${arg}" | cut -c2)
      #     te_name_seq=$(echo "${arg}" | cut -c3-)
      # ---------------------------------------------------------

      fg_name=$(echo "${arg}" | cut -c1)
      bg_name=$(echo "${arg}" | cut -c2)
      te_name_seq=$(echo "${arg}" | cut -c3-)

      # shellcheck disable=SC2001
      #   bash==5.1.16
      #   complex substitution:
      #   split every char with ${te_sep}
      te_name_seq=$(echo "${te_name_seq}" | sed "s/./&${te_sep}/g")
      ;;
  esac
  _zx__color__code_case "${fg_name}"
  _zx__pos__fg_name="${_zx__color__code_case__}"
  _zx__color__code_case "${bg_name}"
  _zx__pos__bg_name="${_zx__color__code_case__}"
  _zx__pos__te_name_seq="${te_name_seq}"

  if test -n "${pos_sep}"; then
    _zx__pos__="${fg_name}${pos_sep}${bg_name}${pos_sep}${te_name_seq}"
  fi
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

  ## ECHO COMPATIBILITY SHORT opt_seq:
  so="${so}n"  # — do not output the trailing newline.
  so="${so}e"  # — enable escapes interpretation for opt_text.
  so="${so}E"  # — disable escapes interpretation for opt_text.
  so="${so}D"  # — disable escapes interpretation for all.

  ## COREUTILS COMPATIBILITY SHORT opt_seq:
  so="${so}c::a"
  # -c=[always|never|auto] like with diff, ls, grep and others.
  # Plain -c means -c='auto'. Another values works as for -f.
  # -a means -c='auto'.

  lo=""
  # MAIN LONG opt_seq
  lo="${lo}fg:,foreground:,foreground-color:,"
  lo="${lo}bg:,background:,background-color:,"
  lo="${lo}te:,opt_text-effect:,em:,emphasis:,"
  lo="${lo}ps:,pos:,positional:,"
  lo="${lo}help,"
  lo="${lo}version,"

  lo="${lo}ho,head-only," # — head only
  lo="${lo}to,tail-only," # — tail only
  lo="${lo}pw,wrap,prompt-wrap"      # — prompt wrap

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
  unset nm so lo
}

_zx__configure() {
  opt=$(_zx__getopt "${@}")
  eval set -- "${opt}"
  unset opt

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
      -t | --te | --opt_text-effect | --em | --emph | --emphasis)
        opt_te_name_seq="${opt_te_name_seq} ${2}"
        shift 2
        ;;
      -p | --ps | --pos | positional)
        opt_pos_args_seq="${2}"
        shift 2
        ;;
      -h | --help)
        _zx__usage
        shift 1
        ;;
      -v | --version)
        printf '0.1768393361'
        shift 1
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
      -e | --esc | --escapes)
        # Echo compatibility.
        opt_txt_format='ESCAPED'
        shift 1
        ;;
      -E | --ne | --nesc | --no-esc | --no-escapes)
        # Echo compatibility.
        opt_txt_format='PRINTABLE'
        shift 1
        ;;
      -D | --debug)
        # Echo compatibility.
        opt_esc_format='PRINTABLE'
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
        echo "zx unknown parameter '${1}'." >&2
        shift 1
        ;;
    esac
  done
  opt_text="${*}"
}

_zx() {
  __ZX__OUTPUT_STREAM_FD=1
  __ZX__FMT_SEP=':'
  __ZX__ESC_ANSI_SEP=';'

  opt_fg_name=''
  opt_bg_name=''
  opt_te_name_seq=''
  opt_text=''
  opt_pos_args_seq=''

  opt_when_use_color='ALWAYS'
  opt_txt_format='PRINTABLE'
  opt_esc_format='ESCAPED'

  opt_use_newline=true
  opt_use_head=true
  opt_use_tail=true

  _zx__configure "$@"

  if test -n "${opt_pos_args_seq}"; then
    _zx__pos "${opt_pos_args_seq}" "${__ZX__FMT_SEP}"
    opt_fg_name="${_zx__pos__fg_name}"
    opt_bg_name="${_zx__pos__bg_name}"
    opt_te_name_seq="${_zx__pos__te_name_seq}"
  fi

  # COREUTILS COMPATIBILITY
  output_type='FILE'
  if test -t "${__ZX__OUTPUT_STREAM_FD}"; then
    output_type='STREAM'
  fi

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

  if "${use_colors}" && "${opt_use_head}"; then
    _zx__head  "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
    _zx__out   "${opt_esc_format}" "${_zx__head__}"
  fi
  _zx__out "${opt_txt_format}" "${opt_text}"
  if "${use_colors}" && "${opt_use_tail}"; then
    _zx__tail  "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
    _zx__out   "${opt_esc_format}" "${_zx__tail__}"
  fi

  # ECHO COMPATIBILITY
  if "${opt_use_newline}"; then
    _zx__out ESCAPED '\n'
  fi
}

_zx__clean() {
  unset ansi_sep
  unset arg
  unset awk_prog
  unset opt_bg_name
  unset cl
  unset code
  unset code_seq
  unset code_str
  unset color
  unset disable
  unset enable
  unset opt_fg_name
  unset fmt_sep
  unset lo
  unset local_sep
  unset newline
  unset nm
  unset opt_seq
  unset output_type
  unset patten
  unset opt_pos_args_seq
  unset pos_sep
  unset result
  unset std_arg
  unset stream_name
  unset te_code_seq
  unset te_name
  unset opt_te_name_seq
  unset te_sep
  unset opt_text
  unset use_colors
  unset use_initial_escapes
  unset opt_use_newline
  unset opt_when_use_color
  unset _zx__apply
  unset _zx__color__bg_code
  unset _zx__code_str
  unset _zx__color__code_case
  unset _zx__color__code_pair
  unset _zx__color__std_name
  unset __ZX__ESC_ANSI_SEP
  unset _zx__color__fg_code
  unset __ZX__FMT_SEP
  unset _zx__head
  unset _zx__join_code_seq
  unset __ZX__OUTPUT_STREAM_FD
  unset __ZX__OUTPUT_STREAM_FD
  unset _zx__pos
  unset _zx__pos__bg_name
  unset _zx__pos__fg_name
  unset _zx__pos__te_name_seq
  unset _zx__color__rename
  unset _zx__tail
  unset _zx__text_effect__code__
  unset _zx__text_effect__code_seq
}
