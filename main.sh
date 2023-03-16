#!/bin/bash

tmp="$(pwd)/tmp"

generate_tex(){
cd "$tmp"
resume=`ls Resume-*.pdf`
mkdir -pv html tex
cd html
[[ -L resume.pdf ]] || ln -v -s "$tmp/$resume" resume.pdf
echo > resume-html.html
pdftohtml -s resume.pdf -nomerge
pandoc resume-html.html -o "$tmp/tex/resume.tex"
}


generate_info(){
cd "$tmp/tex"
sed '/ - page~\|\hypertarget{page\|\includegraphics\[\|^$/d' resume.tex > info.tex
sed -i ':x /~~ • ~/ { N; s/\n//g ; bx }' info.tex
sed -i  '/~~ • ~/ { s/^/\{/g ; s/[ ]\?$/}/g ; s/~~ •[ ]\?~[ ]\?/}{/g }' info.tex
sed -i 's/ (. months)$//g' info.tex
}


generate_files(){
cd "$tmp/tex"
csplit -z info.tex '/\textbf{Summary}\|\textbf{Experience}\|\textbf{Skills}/' '{*}'
sed -i ':a;N;/\n\\text/! s/\n/}{/;ta;P;D' xx02
sed -i 's/}}/}/' xx02
sed -i  '/}$/!  s/$/}/g ' xx02
mkdir -p "$tmp/translated"
mkdir -p "$tmp/translated/en"
sed -n '1p' xx00 > "$tmp/translated/name.tex"
sed -n '1!p' xx00 > "$tmp/translated/contact.tex"
sed -n '1!p' xx01 > "$tmp/translated/en/about.tex"
sed -n '1!p' xx03 > "$tmp/translated/en/skills.tex"
csplit -z xx02 '/\textbf{Experience}\|\textbf{Education}/' '{*}'
sed -i -n '1!p' xx00 
sed -i -n '1!p' xx01 
nl -w 3 -s == xx00 > "$tmp/translated/en/experience.tex"
nl -w 3 -v 3 -s == xx01 > "$tmp/translated/en/education.tex"
}


process_files(){
cd "$tmp/translated"


}

# generate_tex
# generate_info
generate_files
# process_files