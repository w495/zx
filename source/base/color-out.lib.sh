#!/usr/bin/env sh
# WARN: Enable hashbang for checking as POSIX

# shellcheck shell=sh enable=all

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
test -z "${ZX_LAZY_UNSET}" && readonly ZX_LAZY_UNSET=false

# Internal constants
test -z "${__term_emph__FMT_SEP}" && readonly __term_emph__FMT_SEP=':'
test -z "${__term_emph__ESC_ANSI_SEP}" && readonly __term_emph__ESC_ANSI_SEP=';'

if test -z "${__term_emph_SPACE_PUNCT}"; then
  __term_emph_SPACE_PUNCT='[/: ]'
  # __term_emph_SPACE_PUNCT='[[:punct:]|[:space:]]'
  #   Do not works with posh
fi

_term_emph__punct_to_sep__native() {

  data="${1}"
  punct="${2}" # [[:punct:]] or [[:punct:]|[:space:]]
  sep="${3}"

  punct_suffix="${punct}*"
  punct_prefix="*${punct}"

  _term_emph__replace_=''

  # shellcheck disable=SC2295
  while test "${data#${punct_prefix}}" != "${data}"; do
    # shellcheck disable=SC2295
    item="${data%%${punct_suffix}}"
    #  Example: 'a/b:cd' --> 'a'
    #     'a/b:cd' but without longest suffix '/b:cd'
    if test -n "${item}"; then
      # Handle case with empty item. E.g.: '::x:y'
      if test -n "${_term_emph__replace_}"; then
        # If not empty — append separator.
        _term_emph__replace_="${_term_emph__replace_}${sep}"
      fi
      _term_emph__replace_="${_term_emph__replace_}${item}"
    fi
    # shellcheck disable=SC2295
    te_name_seq="${data#${punct_prefix}}"
  done
}

_term_emph__punct_to_sep() {
  data="${1}"
  punct="${2}" # [[:punct:]] or [[:punct:]|[:space:]]
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

  _term_emph__punct_to_sep_=$(
    echo "${data}${sep}" | sed "s/${punct}+/${sep}/g"
    # Append separator to the end to handle
    # the last value as the others.
  )

}

_term_emph__text_effect__code() {
  case $(awk -v "i=${1}" 'BEGIN{$0=X;print tolower(i)}') in
  0 | clear | reset)
    _term_emph__text_effect__code_=0
    ;;
  1 | b | bold)
    _term_emph__text_effect__code_=1
    ;;
  2 | d | f | dim | faint)
    _term_emph__text_effect__code_=2
    ;;
  3 | i | italic)
    _term_emph__text_effect__code_=3
    ;;
  4 | u | underline)
    _term_emph__text_effect__code_=4
    ;;
  5 | l | blink)
    _term_emph__text_effect__code_=5
    ;;
  7 | r | reverse)
    _term_emph__text_effect__code_=7
    ;;
  8 | c | conceal)
    _term_emph__text_effect__code_=8
    ;;
  9 | s | x | strike* | del)
    _term_emph__text_effect__code_=9
    ;;
  '' | e | empty)
    _term_emph__text_effect__code_=-1
    ;;
  *)
    _term_emph__text_effect__code_=-2
    ;;
  esac
}

_term_emph__text_effect__code_seq() {
  te_name_seq="${1}"
  #           Example: 'b:i:ru'.

  te_sep="${2:-${__term_emph__FMT_SEP}}"
  te_code_seq=''

  _term_emph__punct_to_sep "${te_name_seq}" "${te_sep}"
  #           Example: 'b/i/ru'.

  te_name_seq="${_term_emph__punct_to_sep_}"
  #           Example: 'b:i:ru:'.

  te_sep_suffix="${__term_emph_SPACE_PUNCT}*"
  te_sep_prefix="*${__term_emph_SPACE_PUNCT}"

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
      _term_emph__text_effect__code "${te_name}"
      # Get code.
      #       Example: 'b' --> '1'.
      if test "${_term_emph__text_effect__code_}" -gt 0; then
        if test -n "${te_code_seq}"; then
          # If not empty — append separator.
          te_code_seq="${te_code_seq}${te_sep}"
        fi
        te_code_seq="${te_code_seq}${_term_emph__text_effect__code_}"
      elif test "${_term_emph__text_effect__code_}" -eq -cout2; then
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
  _term_emph__text_effect__code_seq_="${te_code_seq}"

  _term_emph__gc _term_emph__text_effect__code_ _term_emph__punct_to_sep_
  _term_emph__gc te_sep te_sep_suffix te_sep_prefix
  _term_emph__gc te_code_seq te_name te_name_seq may_be_te_name_seq
}

_term_emph__color__code_case() {
  case ${1} in
  [[:lower:]]*)
    _term_emph__color__code_case_="-${1}"
    ;;
  [[:upper:]]*)
    _term_emph__color__code_case_="+${1}"
    ;;
  *)
    _term_emph__color__code_case_="${1}"
    ;;
  esac
}

_term_emph__color__code() {
  case "${1}" in
  -k | k | -black | black | basic-black)
    _term_emph__color__fg_code_=30
    _term_emph__color__bg_code_=40
    ;;
  -r | r | -red | red | basic-red)
    _term_emph__color__fg_code_=31
    _term_emph__color__bg_code_=41
    ;;
  -g | g | -green | green | basic-green)
    _term_emph__color__fg_code_=32
    _term_emph__color__bg_code_=42
    ;;
  -y | y | -yellow | yellow | basic-yellow)
    _term_emph__color__fg_code_=33
    _term_emph__color__bg_code_=43
    ;;
  -b | b | -blue | blue | basic-blue)
    _term_emph__color__fg_code_=34
    _term_emph__color__bg_code_=44
    ;;
  -m | m | -magenta | magenta | basic-magenta)
    _term_emph__color__fg_code_=35
    _term_emph__color__bg_code_=45
    ;;
  -c | c | -cyan | cyan | basic-cyan)
    _term_emph__color__fg_code_=36
    _term_emph__color__bg_code_=46
    ;;
  -w | w | -white | white | basic-white)
    _term_emph__color__fg_code_=37
    _term_emph__color__bg_code_=47
    ;;
  ## bright colors
  +k | K | +black | Black | BLACK | bright-black)
    _term_emph__color__fg_code_=90
    _term_emph__color__bg_code_=100
    ;;
  +r | R | +red | Red | RED | bright-red)
    _term_emph__color__fg_code_=91
    _term_emph__color__bg_code_=101
    ;;
  +g | G | +green | Green | GREEN | bright-green)
    _term_emph__color__fg_code_=92
    _term_emph__color__bg_code_=102
    ;;
  +y | Y | +yellow | Yellow | YELLOW | bright-yellow)
    _term_emph__color__fg_code_=93
    _term_emph__color__bg_code_=103
    ;;
  +b | B | +blue | Blue | BLUE | bright-blue)
    _term_emph__color__fg_code_=94
    _term_emph__color__bg_code_=104
    ;;
  +m | M | +magenta | Magenta | MAGENTA | bright-magenta )
    _term_emph__color__fg_code_=95
    _term_emph__color__bg_code_=105
    ;;
  +c | C | +cyan | Cyan | CYAN | bright-cyan )
    _term_emph__color__fg_code_=96
    _term_emph__color__bg_code_=106
    ;;
  +w | W | +white | White | WHITE | bright-white )
    _term_emph__color__fg_code_=97
    _term_emph__color__bg_code_=107
    ;;
  '' | [[:punct:]]* | e | empty)
    _term_emph__color__code_='empty color'
    ;;
  *)
    ( # use subshell
      _term_emph -n -fr -by -cauto "Error:"
      _term_emph -n -fr -cauto " unknown color ${1}"
      _term_emph
    ) >&2
    _term_emph__color__code_='unknown color'
    ;;
  esac
  _term_emph__gc _term_emph__color__rename_
}

_term_emph__join_code_seq() {
  code_seq="${1}"
  fmt_sep="${2:-${__term_emph__FMT_SEP}}"
  ansi_sep="${3:-${__term_emph__ESC_ANSI_SEP}}"

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
  _term_emph__join_code_seq_="${code_str}"
  _term_emph__gc code_seq fmt_sep ansi_sep code_str code
}

_term_emph__code_str() {
  fg_name="${1}"
  bg_name="${2}"
  te_name_seq="${3}"
  fmt_sep="${4:-${__term_emph__FMT_SEP}}"
  ansi_sep="${5:-${__term_emph__ESC_ANSI_SEP}}"

  if test -n "${te_name_seq}"; then
    _term_emph__text_effect__code_seq "${te_name_seq}" "${fmt_sep}"
    code_seq="${_term_emph__text_effect__code_seq_}"
  fi

  if test -n "${fg_name}"; then
    _term_emph__color__code "${fg_name}"
    code_seq="${code_seq}${fmt_sep}${_term_emph__color__fg_code_}"
  fi
  if test -n "${bg_name}"; then
    _term_emph__color__code "${bg_name}"
    code_seq="${code_seq}${fmt_sep}${_term_emph__color__bg_code_}"
  fi

  _term_emph__join_code_seq "${code_seq}" "${fmt_sep}" "${ansi_sep}"
  _term_emph__code_str_="${_term_emph__join_code_seq_}"

  _term_emph__gc fg_name bg_name te_name_seq fmt_sep ansi_sep

  _term_emph__gc _term_emph__color__code_
  _term_emph__gc _term_emph__color__fg_code_
  _term_emph__gc _term_emph__color__bg_code_
  _term_emph__gc _term_emph__text_effect__code_seq_
  _term_emph__gc _term_emph__join_code_seq_
}

_term_emph__out() {
  format_name="${1}"
  data="${2}"

  _term_emph__out_="${data}"

  case "${1}" in
  *WRAPPED*)
    _term_emph__out_="\0001${_term_emph__out_}\0002"
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
    printf '%s' "${_term_emph__out_}"
    ;;
  *ESCAPED*)
    printf '%b' "${_term_emph__out_}"
    ;;
  *PRINTABLE*)
    printf '%s' "${_term_emph__out_}"
    ;;
  *)
    # do nothing
    ;;
  esac

  _term_emph__gc format_name data
}

_term_emph__head() {
  _term_emph__code_str "${@}"

  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #  bash/zsh:
  #     ESC = \x1b = \e = \E
  #  ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------
  _term_emph__head_=''
  if test -n "${_term_emph__code_str_}"; then
    _term_emph__head_="\0033[${_term_emph__code_str_}m"
  fi
  _term_emph__gc _term_emph__code_str_
}

_term_emph__tail() {
  _term_emph__text_effect__code reset
  # COMPATIBILITY NOTE:
  # ---------------------------------------------------------------
  #  bash/zsh:
  #     ESC = \x1b = \e = \E
  #  ksh93:
  #     ESC = \0033
  # ---------------------------------------------------------------

  _term_emph__tail_=''
  if test -n "${_term_emph__text_effect__code_}"; then
    _term_emph__tail_="\0033[${_term_emph__text_effect__code_}m"
  fi
  _term_emph__gc _term_emph__text_effect__code_
}

_term_emph__pos() {
  arg="${1}"
  te_sep="${2:-${__term_emph__FMT_SEP}}"
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
    # POSIX: use BRE (\+ for one-or-more); -E is not in POSIX sed
    arg=$(
      echo "${arg}${local_sep}" | sed "s/${LONG_POS_MARKER}\+/${local_sep}/g"
    )

    local_sep_suffix="[${local_sep}]*"
    local_sep_prefix="*[${local_sep}]"

    # shellcheck disable=SC2295
    if test "${arg#${local_sep_prefix}}" != "${arg}"; then
      fg_name="${arg%%${local_sep_suffix}}"
      arg="${arg#${local_sep_prefix}}"
    fi

    # shellcheck disable=SC2295
    if test "${arg#${local_sep_prefix}}" != "${arg}"; then
      bg_name="${arg%%${local_sep_suffix}}"
      arg="${arg#${local_sep_prefix}}"
    fi

    # shellcheck disable=SC2295
    if test "${arg#${local_sep_prefix}}" != "${arg}"; then
      te_name_seq="${arg}"
    fi
    _term_emph__gc local_sep
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
  _term_emph__gc arg te_sep LONG_POS_MARKER

  _term_emph__pos__fg_name_="${fg_name}"
  _term_emph__pos__bg_name_="${bg_name}"
  _term_emph__pos__te_name_seq_="${te_name_seq}"

  if test -n "${pos_sep}"; then
    _term_emph__pos_="${fg_name}${pos_sep}${bg_name}${pos_sep}${te_name_seq}"
  fi
  _term_emph__gc fg_name bg_name te_name_seq pos_sep
}

_term_emph__gc() {
  if "${ZX_LAZY_UNSET}"; then
    _term_emph__gc_="${_term_emph__gc_} ${*}"
  else
    eval unset -v "${*}"
  fi
}

_term_emph__unset_vars() {
  if test -n "${_term_emph__gc_}"; then
    eval unset -v "${_term_emph__gc_}"
  fi
}

_term_emph__unset_functions() {
  unset -f _term_emph__usage
  unset -f _term_emph__punct_to_sep
  unset -f _term_emph__text_effect__code
  unset -f _term_emph__text_effect__code_seq
  unset -f _term_emph__color__code_case
  unset -f _term_emph__color__rename
  unset -f _term_emph__color__code
  unset -f _term_emph__color__code_pair
  unset -f _term_emph__color__fg_code_
  unset -f _term_emph__color__bg_code_
  unset -f _term_emph__join_code_seq
  unset -f _term_emph__code_str
  unset -f _term_emph__out
  unset -f _term_emph__head
  unset -f _term_emph__tail
  unset -f _term_emph__pos
  unset -f _term_emph__getopt
  unset -f _term_emph__configure
  unset -f _term_emph__gc_
}

_term_emph__unset_functions_all() {
  _term_emph__clean
  unset -f _term_emph
  unset -f _term_emph__unset_functions
  unset -f _term_emph__unset_functions_all
}
