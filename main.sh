#!/bin/bash

tmp="$(pwd)/tmp"
cd "$tmp"

generate_tex(){
resume=`ls Resume-*.pdf`
mkdir -pv html tex
cd html
ln -v -s ../$resume resume.pdf
pdftohtml -s resume.pdf -nomerge
pandoc resume-html.html -o ../tex/resume.tex
cd ..
}

# generate_tex


cd "$tmp/tex"

sed '/ - page~/d' resume.tex > a.tex
sed -i '/\hypertarget{page/d' a.tex
sed -i '/\includegraphics\[/d' a.tex
sed -i  '/^/N;s/\n//' a.tex
sed -i  '/~~ • ~/N;s/\n/ /' a.tex
sed -i  '/~~ • ~/N;s/\n/ /' a.tex
sed -i  '/^$/N;s/\n//' a.tex
sed -i  '/~~ • ~/ s/^/{/g' a.tex
sed -i  '/~~ • ~/ s/[ ]\?$/}/g' a.tex
sed -i 's/~~ •[ ]\?~[ ]\?/}{/g' a.tex
sed -i 's/ (. months)$//g' a.tex

