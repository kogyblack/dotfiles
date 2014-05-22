Not a true markdown format... Must rewrite to fit HTML correctly
see: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

This is cheatsheet for kogyblack's vim
========================================

### Moving Around
in normal mode:
h: move left
l: move right
j: move up
k: mode down
  Obs: if preceding by a number, the command is repeated that number times
       (will be referenced as [count])

0: Move to the beginning of the line
^: Move to the first non-blank character of the line
$: Move to the last character of the line
  Obs: if preceding by g, the command will not wrap

(minus): [count] lines upward, on the first non-blank character
(plus): [count] line downward, on the first non-blank character

gg: Go to first line of the file
G:  Go to last line of the file

#### USE EASY MOTION!!!
w: [count] words forward
W: [count] WORDS forward (space-separated words)
e: Forward to the end of the word [count]
E: Forward to the end of the WORD [count]
b: [count] words backwards
B: [count] WORDS backwards
ge: Backward to the end of the word [count]
gE: Backward to the end of the WORD [count]

(: [count] sentences backward
): [count] sentences forward
[[: [count] sections backwards or to the previous '{' in the first column
[]: [count] sections backwards or th the previous '}' in the first column
][: same as [[, but forwards
]]: same as [] but forwards

### Marks
m{a-zA-Z}: Set mark {a-zA-Z} at the cursor position
'{a-z}: Move to the first non-blank character on the line with mark given (linewise)
'{A-Z0-9}: Same as above, but moves to other files too
`{a-z}: Move to the mark given   `  #MUST CHANGE THIS!!
`{A-Z0-9}: Move to the mark given in the correct file    `
:marks  List all marks

### Search and replace
:[range]s/{pattern}/{string}/[c][e][g][p][r][i][I] [count]
  For each line in [range] replace a match of {pattern} with {string}

[range] : if it is '%', replace in whole file
"arguments:
[c]: Confirm each substitution (responses: 'y'=yes, 'n'=no, 'a'=all, 'q'=quit, CTRL-E = scroll up, CTRL-Y = scroll down)
[e]: When search pattern fails, do not issue an error message and, in particular, continue in maps as if no error occured
[g]: Replace all occurrences in the line
[i]: Ignore case for the pattern (case sensitive)
[I]: Don't ignore case for the pattern (case insensitive)
[p]: Print the line containing the last substitute


Plugins "{{{
--------------

###Easy Motion

in normal mode:
<Tab>w:      easymotion on every word
<Tab>f[a-z]: easymotion on every character chosen

"See my bindings!


###Easy Align:

in virtual mode: " In order
<Enter>: Enters easy-align mode (obs: my binding)
Optional: Extra Enter keys to select alignment mode (left, right, center)
Optional: N-th delimiter
  [1]:  Around the first occurrence of delimiters
  [2]:  Around the second occurrence of deliliters
        Extend to n-th occurrence
  [*]:  Around all occurrences
  [**]: Left-right alternating alignment around all delimiters
  [-]:  Around the last occurrence
  [-2]: Around the second to last occurrence
        Extend to n=th occurrence
Delimiter key (a single: <Space>, [=:.|&,])

" To adjust margins around delimeters you can use (lm = left margin, rm = right margin, stl = stick_to_left)
<Left>:  {stl=1, lm=0}
<Right>: {stl=0, lm=1}
<Down>:  {lm=0, rm=0}
<Ctrl>l: left-margin (input: [0-9])
<Ctrl>r: right-margin (input: [0-9])
<Ctrl>i: indentation (values: keep, shallow, deep, none)

" Since delimiter keys are limited, one can use regular expressions
<Ctrl-X> or <Ctrl-/>: to insert a regex delimiter


###Surround

cs{old_surround}{new_surround} : Change {old_surround} to {dew_surround}
  Obs: to change HTML or XML tags, the {old_surround} is 't'
       ), }, ] and > can be used as b, B, r, a (easier to right)
  Examples:
    cs'":   Change 'hello' to "hello"
    ch'<q>: Change 'hello' to <q>hello</q>

ys{text_object}{surround} : Inserts {surround} around {text_object}
  Obs: delimiters [, {, ( adds spaces, while ], }, ) don't add
       READ _OBS_
  Examples:
    ysiw] : Change hello to [hello]
    yssb : Add parentesis to the whole line (sentence)

ds{surround} : Delete {surround}

in visual mode:
S{surround} : Adds surround on selected text

_OBS_: w, W, s and p correspond to a word, a WORD, a sentence and a paragraph


###File line

On terminal, open vim file as
$ vim filename:linenumber

The file with filename opens, if exists, in the linenumber given

"}}}

My Bindings "{{{
------------------

###My bindings

,rs : sources $MYVIMRC
,rc : edit $MYVIMRC

<Tab>h : previous tab
<Tab>l : next tab

<Tab>- : unloads buffer
<Tab>-- : unloads buffer (if changes were made, they will be lost)

<Shift><Enter> : Creates an empty line below

,E : Enters explorer (horizontal split)
,EE : Enters explorer (vertical split)

,p : Paste clipboard (or whatever in the register "+) after cursor
,P : Paste clipboard (or whatever in the register "+) before cursor

<Ctrl>[hjkl] : Moves to window on [left,down,up,right]

,v : New window (vertical split)
,s : New window (horizontal split)

,n : erases highlights

<F12> : toggle shown special characters (tab, trailing whitespaces, etc)

###Plugin bindings "{{{{
" Gundo
<F5> : Enters Gundo
  What's Gundo?
    An undo tree

" Easy Align
in visual:
<Enter> : Enters easy align
,<Enter> : Enters easy align interactively

" Easy motion
<Tab>[hjkl] : easy motion to motion direction

"}}}

"}}}
