LATEX=xelatex
LATEXOPT=--shell-escape #--output-directory=tmp
# NONSTOP=--interaction=nonstopmode
NONSTOP=--interaction=batchmode

LATEXMK=latexmk
LATEXMKOPT=-pdf -auxdir=tmp/log -outdir=tmp/log -pdfxe 
CONTINUOUS=-pvc

PT=-jobname=cv_pt -usepretex="\newif\ifen\newif\ifpt\pttrue"
EN=-jobname=cv_en -usepretex="\newif\ifen\newif\ifpt\entrue"

MAIN=main
SOURCES=$(MAIN).tex Makefile 

all:  pt en

pt:
	$(LATEXMK) $(LATEXMKOPT) $(PT) $(MAIN) 

en:
	$(LATEXMK) $(LATEXMKOPT) $(EN) $(MAIN) 

config:
	main.sh -c

translate: 
	main.sh -t

move: 
	main.sh -m

watch_pt:
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) $(NONSTOP) $(PT) $(MAIN) 

watch_en:
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) $(NONSTOP) $(EN) $(MAIN) 

force:
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
	-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
	rm -rf tmp/*

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all
