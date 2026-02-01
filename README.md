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
That is similar to:
* German «Zeche» — /tseh‑uhn/ — colliery;
* Russian «Цех»  — /tsekh/    — workshop.
  
So we use «Z» to represent /ts/-_sound.

## EXAMPLES

         zx --fg red --bg yellow --te strikeout  some waring

## OPTIONS

|       |       |               |                     | Descr              |
|------:|------:|--------------:|--------------------:|:-------------------|
|   -f? | --fg= | --foreground= | --foreground-color= | see COLORS section |
|   -b? | --bg= | --background= | --background-color= | see COLORS section |
|   -t? | --te= |   --emphasis= |      --text-effect= |
|   -t? | --em= |       --emph= |         --emphasis= |
| -p??? | --ps= |        --pos= |       --positional= |

## VIEW FLAGS

|    |    |       |        |               |
|----|----|-------|--------|---------------|
| -a | -H | --ho  | --head |   --head-only |
| -z | -T | --to  | --tail |   --tail-only |
| -w | -P | --pw  | --wrap | --prompt-wrap |

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


## TEXT EFFECTS 

|           |   |   |    |           |        |
|-----------|---|---|----|-----------|--------|
|     reset | 0 | n |    | clear     | reset  |
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
