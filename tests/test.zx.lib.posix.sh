#!/usr/bin/env sh
# shellcheck enable=all
#     shfmt -ci -i 2 -sr -s -bn -kp -ln posix -d

#__here_path="/$(lsof -p $$ | tail -n1 | cut -d '/' -f2-)"
#__here_dir=$(dirname "${__here_path}")

__zx_source="../source/zx.lib.posix.sh"

. "${__zx_source}"

N_CHECKS=0
N_OKS=0
N_FAILS=0

check() {
  pat="${1}"
  shift
  tval="$(__zx "${@}")"
  N_CHECKS=$((N_CHECKS + 1))
  if test "${tval}" = "$(printf '%b' "${pat}")"; then
    printf '\tOk\t%+40b %-80s\n'  "${pat}" "zx ${*}"
    N_OKS=$((N_OKS + 1))
  else
    printf '\tFail\t%s:\tzx%s\t%b\n'  "${pat}" "${*}" "${tval}"
    N_FAILS=$((N_FAILS + 1))
  fi
}

color_tests() {
  echo 'FOREGROUND FORMS'

  check '\0033[31m:r|g|b|w|c|m|y|k:\0033[0m' -fr ':r|g|b|w|c|m|y|k:'
  check '\0033[36m:r|g|b|w|c|m|y|k:\0033[0m' -fc ':r|g|b|w|c|m|y|k:'
  check '\0033[32m:red|blue|green|white|:\0033[0m' \
    --fg=green ':red|blue|green|white|:'
  check '\0033[35m:|cyan|magenta|yellow|black:\0033[0m' \
    --foreground=magenta ':|cyan|magenta|yellow|black:'

  echo 'BACKGROUND FORMS'

  check '\0033[42m:r|g|b|w|c|m|y|k:\0033[0m' -bg ':r|g|b|w|c|m|y|k:'
  check '\0033[43m:r|g|b|w|c|m|y|k:\0033[0m' -by ':r|g|b|w|c|m|y|k:'
  check '\0033[44m:red|blue|green|white|:\0033[0m' \
    --bg=blue ':red|blue|green|white|:'
  check '\0033[46m:|cyan|magenta|yellow|black:\0033[0m' \
    --background=cyan ':|cyan|magenta|yellow|black:'

  echo 'COLOR FORMS +/-'
  check '\0033[36m:dark color letter:\0033[0m' \
    -fc- ':dark color letter:'
  check '\0033[96m:bright color letter:\0033[0m' \
    -fc+ ':bright color letter:'
  check '\0033[36m:dark color letter:\0033[0m' \
    -f-c ':dark color letter:'
  check '\0033[96m:bright color letter:\0033[0m' \
    -f+c ':bright color letter:'
  check '\0033[32m:dark color letter:\0033[0m' \
    --fg g ':dark color letter:'
  check '\0033[32m:dark color minus:\0033[0m' \
    --fg -g ':dark color minus:'
  check '\0033[92m:bright color plus:\0033[0m' \
    --fg +g ':bright color plus:'
  check '\0033[31m:dark color minus:\0033[0m' \
    -f-red ':dark color minus:'
  check '\0033[91m:bright color plus:\0033[0m' \
    -f+red ':bright color plus:'


  echo 'COLOR SHORT FORMS'
  check '\0033[35m:dark color letters:\0033[0m' \
    --fg dm ':dark color letters:'
  check '\0033[35m:dark color letters:\0033[0m' \
    --fg md ':dark color letters:'
  check '\0033[95m:light color letters:\0033[0m' \
    --fg lm ':light color letters:'
  check '\0033[95m:light color letters:\0033[0m' \
    --fg ml ':light color letters:'
  check '\0033[90m:light color letters:\0033[0m' \
    --fg ik ':light color letters:'
  check '\0033[90m:light color letters:\0033[0m' \
    --fg ki ':light color letters:'

  check '\0033[31m:DARK COLOR LETTER:\0033[0m' \
    --fg R ':DARK COLOR LETTER:'
  check '\0033[31m:DARK COLOR LETTERS:\0033[0m' \
    --fg DR ':DARK COLOR LETTERS:'
  check '\0033[31m:DARK COLOR LETTERS:\0033[0m' \
    --fg RD ':DARK COLOR LETTERS:'
  check '\0033[31m:lowercase color:\0033[0m' \
    --fg red ':lowercase color:'
  check '\0033[31m:UPPERCASE COLOR:\0033[0m' \
    --fg RED ':UPPERCASE COLOR:'

  echo 'FOREGROUND DARK COLORS'
  check '\0033[30m:basic black fg:\0033[0m' \
    --fg ba-black ':basic black fg:'
  check '\0033[31m:basic red fg:\0033[0m' \
    --fg basic-red ':basic red fg:'
  check '\0033[32m:basic green fg:\0033[0m' \
    --fg green-basic ':basic green fg:'
  check '\0033[33m:basic yellow fg:\0033[0m' \
    --fg dark-yellow ':basic yellow fg:'
  check '\0033[34m:basic blue fg:\0033[0m' \
    --fg blue-dark ':basic blue fg:'
  check '\0033[35m:basic magenta fg:\0033[0m' \
    --fg d+magenta ':basic magenta fg:'
  check '\0033[36m:basic cyan fg:\0033[0m' \
    --fg cyan-d ':basic cyan fg:'
  check '\0033[37m:basic white fg:\0033[0m' \
    --fg bawhite ':basic white fg:'

  echo 'FOREGROUND BRIGHT COLORS'
  check '\0033[90m:bright black fg:\0033[0m' \
    --fg bright+black ':bright black fg:'
  check '\0033[91m:bright red fg:\0033[0m' \
    --fg brightred ':bright red fg:'
  check '\0033[92m:bright green fg:\0033[0m' \
    --fg LightGreen ':bright green fg:'
  check '\0033[93m:bright yellow fg:\0033[0m' \
    --fg yellow_bright ':bright yellow fg:'
  check '\0033[94m:bright blue fg:\0033[0m' \
    --fg brblue ':bright blue fg:'
  check '\0033[95m:bright magenta fg:\0033[0m' \
    --fg imagenta ':bright magenta fg:'
  check '\0033[96m:bright cyan fg:\0033[0m' \
    --fg lCyan ':bright cyan fg:'
  check '\0033[97m:bright white fg:\0033[0m' \
    --fg iwhite ':bright white fg:'

  echo 'BACKGROUND DARK COLORS'
  check '\0033[40m:basic black bg:\0033[0m' \
    --bg basic-black ':basic black bg:'
  check '\0033[41m:basic red bg:\0033[0m' \
    --bg basic-red ':basic red bg:'
  check '\0033[42m:basic green bg:\0033[0m' \
    --bg basic-green ':basic green bg:'
  check '\0033[43m:basic yellow bg:\0033[0m' \
    --bg basic-yellow ':basic yellow bg:'
  check '\0033[44m:basic blue bg:\0033[0m' \
    --bg basic-blue ':basic blue bg:'
  check '\0033[45m:basic magenta bg:\0033[0m' \
    --bg basic-magenta ':basic magenta bg:'
  check '\0033[46m:basic cyan bg:\0033[0m' \
    --bg basic-cyan ':basic cyan bg:'
  check '\0033[47m:basic white bg:\0033[0m' \
    --bg basic-white ':basic white bg:'

  echo 'BACKGROUND BRIGHT COLORS:'
  check '\0033[100m:bright black bg:\0033[0m' \
    --bg bright-black ':bright black bg:'
  check '\0033[101m:bright red bg:\0033[0m' \
    --bg bright-red ':bright red bg:'
  check '\0033[102m:bright green bg:\0033[0m' \
    --bg bright-green ':bright green bg:'
  check '\0033[103m:bright yellow bg:\0033[0m' \
    --bg bright-yellow ':bright yellow bg:'
  check '\0033[104m:bright blue bg:\0033[0m' \
    --bg bright-blue ':bright blue bg:'
  check '\0033[105m:bright magenta bg:\0033[0m' \
    --bg bright-magenta ':bright magenta bg:'
  check '\0033[106m:bright cyan bg:\0033[0m' \
    --bg bright-cyan ':bright cyan bg:'
  check '\0033[107m:bright white bg:\0033[0m' \
    --bg bright-white ':bright white bg:'

  echo 'RGB FORM COLORS'
  check '\0033[30m:-black fg:\0033[0m' \
    --fg rgb-000 ':-black fg:'
  check '\0033[90m:+black fg:\0033[0m' \
    --fg rgb+000 ':+black fg:'
  check '\0033[31m:-red fg:\0033[0m' \
    --fg rgb-100 ':-red fg:'
  check '\0033[91m:+red fg:\0033[0m' \
    --fg rgb+100 ':+red fg:'
  check '\0033[32m:-green fg:\0033[0m' \
    --fg rgb-010 ':-green fg:'
  check '\0033[92m:+green fg:\0033[0m' \
    --fg rgb+010 ':+green fg:'
  check '\0033[33m:-yellow fg:\0033[0m' \
    --fg rgb-110 ':-yellow fg:'
  check '\0033[93m:+yellow fg:\0033[0m' \
    --fg rgb+110 ':+yellow fg:'
  check '\0033[34m:-blue fg:\0033[0m' \
    --fg rgb-001 ':-blue fg:'
  check '\0033[94m:+blue fg:\0033[0m' \
    --fg rgb+001 ':+blue fg:'
  check '\0033[35m:-magenta fg:\0033[0m' \
    --fg rgb-101 ':-magenta fg:'
  check '\0033[95m:+magenta fg:\0033[0m' \
    --fg rgb+101 ':+magenta fg:'
  check '\0033[36m:-cyan fg:\0033[0m' \
    --fg rgb-011 ':-cyan fg:'
  check '\0033[96m:+cyan fg:\0033[0m' \
    --fg rgb+011 ':+cyan fg:'
  check '\0033[37m:-white fg:\0033[0m' \
    --fg rgb-111 ':-white fg:'
  check '\0033[97m:+white fg:\0033[0m' \
    --fg rgb+111 ':+white fg:'

    echo 'NUMBER FORM COLORS'
    check '\0033[30;100m:black -fg+bg:\0033[0m' \
      -f-0 -b+0 ':black -fg+bg:'
    check '\0033[90;40m:black +fg-bg:\0033[0m' \
      -f+0 -b-0 ':black +fg-bg:'
    check '\0033[31;101m:red -fg+bg:\0033[0m' \
      -f-1 -b+1 ':red -fg+bg:'
    check '\0033[91;41m:red +fg-bg:\0033[0m' \
      -f+1 -b-1 ':red +fg-bg:'
    check '\0033[32;102m:green -fg+bg:\0033[0m' \
      -f-2 -b+2 ':green -fg+bg:'
    check '\0033[92;42m:green -fg+bg:\0033[0m' \
      -f+2 -b-2 ':green -fg+bg:'
    check '\0033[33;103m:yellow -fg+bg:\0033[0m' \
      -f-3 -b+3 ':yellow -fg+bg:'
    check '\0033[93;43m:yellow +fg-bg:\0033[0m' \
      -f+3 -b-3 ':yellow +fg-bg:'
    check '\0033[34;104m:blue -fg+bg:\0033[0m' \
      -f-4 -b+4 ':blue -fg+bg:'
    check '\0033[94;44m:blue +fg-bg:\0033[0m' \
      -f+4 -b-4 ':blue +fg-bg:'
    check '\0033[35;105m:magenta -fg+bg:\0033[0m' \
      -f-5 -b+5 ':magenta -fg+bg:'
    check '\0033[95;45m:magenta +fg-bg:\0033[0m' \
      -f+5 -b-5 ':magenta +fg-bg:'
    check '\0033[36;106m:cyan -fg+bg:\0033[0m' \
      -f-6 -b+6 ':cyan -fg+bg:'
    check '\0033[96;46m:cyan +fg-bg:\0033[0m' \
      -f+6 -b-6 ':cyan +fg-bg:'
    check '\0033[37;107m:white -fg+bg:\0033[0m' \
      -f-7 -b+7 ':white -fg+bg:'
    check '\0033[97;47m:white +fg-bg:\0033[0m' \
      -f+7 -b-7 ':white +fg-bg:'


  echo 'TAB TEST'
  check '\0033[41m\tTAB TEST\t\0033[0m' \
    -br -e '\tTAB TEST\t'

  printf 'Checks %5s\n' "${N_CHECKS}"
  printf 'Passed %5s\n' "${N_OKS}"
  printf 'Failed %5s\n' "${N_FAILS}"
}


color_tests
