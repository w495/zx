#!/usr/bin/env sh
# WARN: Enable hashbang for checking as POSIX
# shellcheck shell=sh enable=all 


__here_path="/$(lsof -p $$ 2>/dev/null | tail -n1 | cut -d '/' -f2-)" || true
__here_dir=$(dirname "${__here_path}")

# shellcheck source=base/color-out.lib.sh
. "${__here_dir}/source/base/color-out.lib.sh"


# COMPATIBILITY NOTE:
# ---------------------------------------------------------------
#  bash/zsh/ksh93:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln bash -d
#
#  See compatibility notes below and use posix variants.
#  How to check posix:
#     shfmt -ci -i 2 -sr -s -bn -kp -ln posix -d
#
#  Remaining non-POSIX (GNU/BSD):
#     - getopt(1) with -l long options (util-linux style)
# ---------------------------------------------------------------


_cecho__usage() {

  _() {
    _cecho "$@"
  }
  
  _ -tr '# ZX'
  _
  _ -tr '## USAGE'
  _
  _ -td -fg '```'
  _ -ntb -- '  zx '
  _ -ntif -- '  [OPTIONS] '
  _ -nti -- '  [TEXT]'
  _
  _ -td -fg '```'
  _
  _ -tr '## NAME'
  _
  _ '  «Colourful Echo» --> «C. Echo» --> «cecho».'
  _ '  It _sounds like /see‑EK‑oh/ in English. '
  _ '  But in Latin it is sounds like /tse‑kho/,'
  _ '  That is similar to:'
  _ '    * German «Zeche» — /tseh‑uhn/ — colliery;'
  _ '    * Russian «Цех»  — /tsekh/    — workshop.'
  _ '  So we use «Z» to represent /ts/-_sound.'
  _
  _ -tr '## EXAMPLES'
  _
  _ -tr '### KEY VALUE FORM'
  _
  _ -en '\t'
  _ "zx --fg red --bg +yellow --te strikeout some 'strikeout waring'"
  _ -en '\t'
  _ --fg red --bg +yellow --te strikeout 'some strikeout waring'
  _
  _ -en '\t'
  _ "zx -an --fg cyan; printf 'some cyan text printed with printf '; zx -z"
  _ -en '\t'
  _ -an --fg cyan
  _ 'some cyan text printed with printf'
  _ -z
  _
  _ -tr '### POSITIONAL FORM'
  _
  _ -en '\t'
  _ "zx -p m/Y/ur 'magenta underlined text on a yellow'"
  _ -en '\t'
  _ -p m/Y/ur 'magenta underlined text on a yellow'
  _
  _ -en '\t'
  _ "zx -p magenta/Yellow/underline 'magenta underlined text on a yellow'"
  _ -en '\t'
  _ -p magenta/Yellow/underline 'magenta underlined text on a yellow'
  _
  _ -en '\t'
  _ "zx -p yellow/Yellow 'dark yellow text on a bright yellow field'"
  _ -en '\t'
  _ -p yellow/Yellow 'dark yellow text on a bright yellow field'
  _
  _ -en '\t'
  _ "zx -pmYru 'magenta underlined text on a yellow field but all reversed'"
  _ -en '\t'
  _ -pmYru 'magenta underlined text on a yellow field but all reversed'
  _
  _ -en '\t'
  _ "zx -anpg 'green text';"
  _ -en '\t'
  _ "printf 'still green text'; "
  _ -en '\t'
  _ "zx -anpeB 'on blue field '; "
  _ -en '\t'
  _ "printf 'still on blue field'; "
  _ -en '\t'
  _ "zx -z"
  _ -en '\t'
  _ -anpg 'green text '
  _ 'still green text '
  _ -anpeB 'on blue field'
  _ 'still on blue field'
  _ -z

  _
  _ -tr '## OPTIONS'
  _ -tc '|  ch | short |          word |                long | Description |'
  _ -tc '|----:|------:|--------------:|--------------------:|-------------|'
  _ -fr '| -f? | --fg= | --foreground= | --foreground-color= | see COLORS  |'
  _ -br '| -b? | --bg= | --background= | --background-color= | see COLORS  |'
  _ -tb '| -t? | --te= |  --emphasis= |      --text-effect= | see EFFECTS |'
  _ -ti '| -t? | --em= |       --emph= |         --emphasis= |             |'
  _ '| -pX | --ps= |        --pos= |       --positional= | see FORMS  |'
  _ '    X=fbt or =f/b/t'
  _
  _ -tr '## VIEW FLAGS'
  _ -tc '| Ch | Ch | shrt |  word |          long |                        |'
  _ -tc '|---:|----|------|-------:|--------------:|------------------------|'
  _ '| -a | -H | --ho | --head |  --head-only | starts colourful text  |'
  _ '| -z | -T | --to | --tail |  --tail-only | ends colourful text    |'
  _ '| -w | -P | --pw | --wrap | --prompt-wrap | wraps for shell prompt |'
  _
  _ -tr '## COLORS'
  _
  _ -e -tc '|      |\e[0m    |    |         |          |         |'
  _ -e -td '|------|\e[0m----|----|---------|----------|---------|\n|'
  _ -nf-k ' █▓▒░ '
  _ -ne '| -k | -0 | rgb-000 | -black  | black   |\n|'
  _ -nf-k ' █▓▒░ '
  _ -ne '| +k | +0 | rgb+000 | +black  | gray    |\n|'
  _ -nf-r ' █▓▒░ '
  _ -ne '| -r | -1 | rgb-100 | -red    | red     |\n|'
  _ -nf+r ' █▓▒░ '
  _ -ne '| +r | +1 | rgb+100 | +red    |         |\n|'

  _ -ef-g '| █▓▒░ |\e[0m -g | -2 | rgb-010 | -green  | green  |'
  _ -ef+g '| █▓▒░ |\e[0m +g | +2 | rgb+010 | +green  |         |'
  _ -ef-y '| █▓▒░ |\e[0m -y | -3 | rgb-110 | -yellow  | yellow  |'
  _ -ef+y '| █▓▒░ |\e[0m +y | +3 | rgb+110 | +yellow  |         |'
  _ -ef-b '| █▓▒░ |\e[0m -b | -4 | rgb-001 | -blue    | blue    |'
  _ -ef+b '| █▓▒░ |\e[0m +b | +4 | rgb+001 | +blue    |         |'
  _ -ef-m '| █▓▒░ |\e[0m -m | -5 | rgb-101 | -magenta | magenta |'
  _ -ef+m '| █▓▒░ |\e[0m +m | +5 | rgb+101 | +magenta |         |'
  _ -ef-c '| █▓▒░ |\e[0m -c | -6 | rgb-011 | -cyan    | cyan    |'
  _ -ef+c '| █▓▒░ |\e[0m +c | +6 | rgb+011 | +cyan    |         |'
  _ -ef-w '| █▓▒░ |\e[0m -w | -7 | rgb-111 | -white  | white  |'
  _ -ef+w '| █▓▒░ |\e[0m +w | +7 | rgb+111 | +white  |         |'
  _
  _
  _ -tr '## EFFECTS '
  _
  _ -etc '|           |\e[0m  |  |    |           |        |'
  _ -etd '|-----------|\e[0m---|---|----|-----------|--------|'
  _ -et0 '|     reset |\e[0m 0 |  |    | clear     | reset  |'
  _ -etb '|      bold |\e[0m 1 | b |    | bold      |        |'
  _ -etf '|     faint |\e[0m 2 | f |    | faint     |        |'
  _ -etd '|       dim |\e[0m 2 | d |    | dim       |        |'
  _ -eti '|    italic |\e[0m 3 | i | it | italic    |        |'
  _ -eti '|  emphasis |\e[0m 3 | e | em | emphasis  |        |'
  _ -etu '| underline |\e[0m 4 | u | un | underline |        |'
  _ -etl '|     blink |\e[0m 5 | l |    | blink     |        |'
  _ -etr '|  reverse |\e[0m 7 | r | re | reverse  |        |'
  _ -etc '|  conceal |\e[0m 8 | c | co | conceal  |        |'
  _ -etx '| strikeout |\e[0m 9 | x | s  | strike    | del    |'
  _
  unset _

}


_cecho__getopt() {
  nm='_cecho'
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
  so="${so}s"  # — do not output anything; sets _cecho-string

  ## ECHO COMPATIBILITY SHORT opt_seq:
  so="${so}n"  # — do not output the trailing newline.
  so="${so}e"  # — enable escapes interpretation for opt_text.
  so="${so}E"  # — disable escapes interpretation for opt_text.
  so="${so}Dd" # — disable escapes interpretation for all.

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

  lo="${lo}ho,head-only,"        # — head only
  lo="${lo}to,tail-only,"        # — tail only
  lo="${lo}pw,wrap,prompt-wrap," # — prompt wrap
  lo="${lo}str,string,"          # — do not output anything; sets _cecho-string

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
  _cout__gc nm so lo
}

_cecho__configure() {
  _cecho__configure__options_=$(_cecho__getopt "${@}")
  eval set -- "${_cecho__configure__options_}"
  _cecho__configure__status_=''
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
      _cecho__configure__status_='HELP'
      return 0
      ;;
    -v | --version)
      _cecho__configure__status_='VERSION'
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
      _cecho__configure__status_='UNKNOWN_PARAMETER'
      _cecho__configure__unknown_option_="${1}"
      return 1
      ;;
    esac
  done
  opt_text="${*}"
  _cecho__configure__status_='DONE'
}

_cecho() {
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

  _cecho__configure "$@"

  case "${_cecho__configure__status_}" in
  HELP)
    _cout__usage
    return 0
    ;;
  VERSION)
    _cecho --text-effect reverse -- '0.1769981220'
    return 0
    ;;
  DONE) ;;

  UNKNOWN_PARAMETER)
    _cecho >&2 --foreground +red -- \
      "zx: Unknown options: ${_cecho__configure__unknown_option_};" \
      "with options ${_cecho__configure__options_}"
    return 1
    ;;
  *)
    _cecho >&2 --foreground +red --background +yellow -- \
      "zx: Unknown error" \
      "with options ${_cecho__configure__options_}"
    return 1
    ;;
  esac
  _cout__gc _cecho__configure__status_
  _cout__gc _cecho__configure__options_

  if test -n "${opt_pos_args_seq}"; then
    _cout__pos "${opt_pos_args_seq}" "${__cout__FMT_SEP}"
    opt_fg_name="${_cout__pos__fg_name_}"
    opt_bg_name="${_cout__pos__bg_name_}"
    opt_te_name_seq="${_cout__pos__te_name_seq_}"

    _cout__gc _cout__pos_
    _cout__gc _cout__pos__fg_name_
    _cout__gc _cout__pos__bg_name_
    _cout__gc _cout__pos__te_name_seq_
  fi

  # COREUTILS COMPATIBILITY
  output_type='FILE' && test -t '1' && output_type='STREAM'

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
  _cout_=''
  if "${use_colors}" && "${opt_use_head}"; then
    _cout__head "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
    _cout__out "${opt_esc_format}" "${_cout__head_}"
    _cout_="${_cout_}${_cout__out_}"
  fi
  _cout__out "${opt_txt_format}" "${opt_text}"
  _cout_="${_cout_}${_cout__out_}"
  if "${use_colors}" && "${opt_use_tail}"; then
    if ! "${opt_use_head}" || test -n "${_cout__head_}"; then
      # only if _cout__head_ exists
      _cout__tail "${opt_fg_name}" "${opt_bg_name}" "${opt_te_name_seq}"
      _cout__out "${opt_esc_format}" "${_cout__tail_}"
      _cout_="${_cout_}${_cout__out_}"
    fi
  fi
  # ECHO COMPATIBILITY
  if "${opt_use_newline}"; then
    _cout__out "${opt_nln_format}" '\n'
    _cout_="${_cout_}${_cout__out_}"
  fi

  _cout__gc opt_bg_name opt_fg_name opt_te_name_seq opt_text
  _cout__gc opt_esc_format opt_nln_format opt_txt_format
  _cout__gc opt_pos_args_seq
  _cout__gc opt_use_head opt_use_tail opt_use_newline
  _cout__gc opt_when_use_color
  _cout__gc use_colors output_type

  _cout__gc _cout__head_
  _cout__gc _cout__out_
  _cout__gc _cout__tail_

  _cout__unset_vars
}

_cout__gc() {
  if "${ZX_LAZY_UNSET}"; then
    _cout__gc_="${_cout__gc_} ${*}"
  else
    eval unset -v "${*}"
  fi
}

_cout__unset_vars() {
  if test -n "${_cout__gc_}"; then
    eval unset -v "${_cout__gc_}"
  fi
}

_cout__unset_functions() {
  unset -f _cout__usage
  unset -f _cout__punct_to_sep
  unset -f _cout__text_effect__code
  unset -f _cout__text_effect__code_seq
  unset -f _cout__color__code_case
  unset -f _cout__color__rename
  unset -f _cout__color__std_name
  unset -f _cout__color__code_pair
  unset -f _cout__color__fg_code
  unset -f _cout__color__bg_code
  unset -f _cout__join_code_seq
  unset -f _cout__code_str
  unset -f _cout__out
  unset -f _cout__head
  unset -f _cout__tail
  unset -f _cout__pos
  unset -f _cecho__getopt
  unset -f _cecho__configure
  unset -f _cout__gc_
}

_cout__unset_functions_all() {
  _cout__clean
  unset -f _cecho
  unset -f _cout__unset_functions
  unset -f _cout__unset_functions_all
}
