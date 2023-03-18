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
sed -n '1p' xx00 > "$tmp/translated/en/title.tex"
sed -n '1!p' xx00 > "$tmp/translated/contact.tex"
sed -n '1!p' xx01 > "$tmp/translated/en/about.tex"
sed -n '1!p' xx03 > "$tmp/translated/en/skills.tex"
csplit -z xx02 '/\textbf{Experience}\|\textbf{Education}/' '{*}'
N=$(wc -l < xx00)
sed -i -n '1!p' xx00 
sed -i -n '1!p' xx01 
nl -s == xx00 > "$tmp/translated/en/experience.tex"
nl -s == -v $N xx01 > "$tmp/translated/en/education.tex"
}


process_files(){
cd "$tmp/translated"
sed -i -e 's/[ ]*\(.*\)==\\textbf/\\mysection{resume-\1\.jpg}/' en/education.tex
sed -i -e 's/[ ]*\(.*\)==\\textbf/\\mysection{resume-\1\.jpg}/' en/experience.tex
sed -i -e 's/{/\n\\skill{/g ' en/skills.tex
sed -i -e '/^$/d' en/skills.tex
sed -i 's/^+55\(..\)\(.....\)\(....\)/{+55 (\1) \2-\3}/' contact.tex
sed -i 's/^\\href{\(.*\)}{linkedin.com\/in\/\(.*\)}$/{\1}{\2}/' contact.tex
sed -i 's/^\\url{https:\/\/github.com\/\(.*\)}$/{https:\/\/github.com\/\1}{\1}/' contact.tex
sed -i '/^{/! s/\(.*\)/{\1}/' contact.tex
sed -i '1s/{/\\contact{/' contact.tex
sed -i ':x { N; s/\n//g ; bx }' contact.tex
sed -i 's/\(.*\) \(.*\)/\\title{\1}{\2}/' en/title.tex
awk -F '}{' '{print $2}' en/experience.tex | sed -n '1s/\(.*\)/{\1}/ p' >> en/title.tex 
sed -i ':x { N; s/\n//g ; bx }' en/title.tex
}

fix_image_names(){
cd "$tmp/html"
for i in *.jpg ;do
mv -v "$i" "$(echo $i | sed 's/^resume-[0-9]*_\([0-9]*\).jpg$/resume-\1\.jpg/')"
done
}

# generate_tex
# generate_info
# generate_files
# process_files
# fix_image_names