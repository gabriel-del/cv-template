#!/bin/bash


cd tmp
resume=`ls Resume-*.pdf`
mkdir -pv html tex
cd html
ln -v -s ../$resume resume.pdf
pdftohtml -s resume.pdf -nomerge
pandoc resume-html.html -o ../tex/resume.tex