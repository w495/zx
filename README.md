# ZX

## USAGE

```
   zx    [OPTIONS]    [TEXT]
```

## NAME

«Colourful Echo»: 
* --> «C. Echo»  
* --> «cecho».

It sounds like /see‑EK‑oh/ in English. 
But in Latin it is sounds like /tse‑kho/,
That[README.md](README.md) is similar to:
* German «Zeche» — /tseh‑uhn/ — colliery;
* Russian «Цех»  — /tsekh/    — workshop.
  
So we use «Z» to represent /ts/-_sound.

## EXAMPLES

	zx -p m!Y!u 'magenta underlined text on a yellow'
	magenta underlined text on a yellow

	zx -p magenta/YELLOW/underline 'magenta underlined text on a yellow'
	magenta underlined text on a yellow

	zx -pmYru 'magenta underlined text on a yellow field but all reversed'
	magenta underlined text on a yellow field but all reversed

	zx -anpgex 'ABC '; printf 'DEF '; zx -anpeB 'GHI '; printf 'JKL'; zx -z
	ABC DEF GHI JKL

## OPTIONS

|  ch | short |          word |                long | Description |
|----:|------:|--------------:|--------------------:|-------------|
| -f? | --fg= | --foreground= | --foreground-color= | see COLORS  |
| -b? | --bg= | --background= | --background-color= | see COLORS  |
| -t? | --te= |   --emphasis= |      --text-effect= | see EFFECTS |
| -t? | --em= |       --emph= |         --emphasis= |             |
| -p* | --ps= |        --pos= |       --positional= | see FORMS   |

## VIEW FLAGS

| Ch | Ch | shrt |   word |          long |                        |
|---:|----|------|-------:|--------------:|------------------------|
| -a | -H | --ho | --head |   --head-only | starts colourful text  |
| -z | -T | --to | --tail |   --tail-only | ends colourful text    |
| -w | -P | --pw | --wrap | --prompt-wrap | wraps for shell prompt |

## COLORS

|      |    |    |         |          |         |
|------|----|----|---------|----------|---------|
| █▓▒░ | -k | -0 | rgb-000 | -black   | black   |
| █▓▒░ | +k | +0 | rgb+000 | +black   | gray    |
| █▓▒░ | -r | -1 | rgb-100 | -red     | red     |
| █▓▒░ | +r | +1 | rgb+100 | +red     |         |
| █▓▒░ | -g | -2 | rgb-010 | -green   | green   |
| █▓▒░ | +g | +2 | rgb+010 | +green   |         |
| █▓▒░ | -y | -3 | rgb-110 | -yellow  | yellow  |
| █▓▒░ | +y | +3 | rgb+110 | +yellow  |         |
| █▓▒░ | -b | -4 | rgb-001 | -blue    | blue    |
| █▓▒░ | +b | +4 | rgb+001 | +blue    |         |
| █▓▒░ | -m | -5 | rgb-101 | -magenta | magenta |
| █▓▒░ | +m | +5 | rgb+101 | +magenta |         |
| █▓▒░ | -c | -6 | rgb-011 | -cyan    | cyan    |
| █▓▒░ | +c | +6 | rgb+011 | +cyan    |         |
| █▓▒░ | -w | -7 | rgb-111 | -white   | white   |
| █▓▒░ | +w | +7 | rgb+111 | +white   |         |

 
## EFFECTS 

|           |   |   |    |           |        |
|-----------|---|---|----|-----------|--------|
|     reset | 0 |   |    | clear     | reset  |
|      bold | 1 | b |    | bold      |        |
|     faint | 2 | f |    | faint     |        |
|       dim | 2 | d |    | dim       |        |
|    italic | 3 | i | it | italic    |        |
|  emphasis | 3 | e | em | emphasis  |        |
| underline | 4 | u | un | underline |        |
|     blink | 5 | l |    | blink     |        |
|   reverse | 7 | r | re | reverse   |        |
|   conceal | 8 | c | co | conceal   |        |
| strikeout | 9 | x | s  | strike    | del    |
