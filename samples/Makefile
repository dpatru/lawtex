export TEXINPUTS=.:..:
export INDEXSTYLE=..:

LAWREVIEW_SOURCES=alvarez.tex hosanna-tabor.tex postal-tro-motion.tex
NORMAL_OUTPUTS=$(LAWREVIEW_SOURCES:.tex=.pdf)
LAWREVIEW_OUTPUTS=$(LAWREVIEW_SOURCES:.tex=-lawreview.pdf)
ALL_OUTPUTS=$(NORMAL_OUTPUTS) $(LAWREVIEW_OUTPUTS) equatoriana.pdf penn-v-marcus.pdf

all: $(ALL_OUTPUTS)

%-lawreview.pdf: %.tex ../lawbrief.cls ../bluebook.sty ../lawcitations.ist
	rm -f Case.ind Statute.ind Other.ind
	pdflatex -jobname $(basename $@) "\\providecommand{\\documentclassflag}{lawreview}\\input{$<}"
	pdflatex -jobname $(basename $@) "\\providecommand{\\documentclassflag}{lawreview}\\input{$<}"

%.pdf: %.tex ../lawbrief.cls ../bluebook.sty ../lawcitations.ist
	rm -f Case.ind Statute.ind Other.ind
	pdflatex $<
	pdflatex $<

penn-v-marcus.pdf: penn-v-marcus.tex ../lawbrief.cls ../bluebook.sty ../lawcitations.ist
	rm -f Case.ind Statute.ind Other.ind
	pdflatex $<
	makeindex -r -s ../lawcitations.ist Case
	pdflatex $<
	pdflatex $<

equatoriana.pdf: equatoriana.tex ../lawbrief.cls ../bluebook.sty
	rm -f Case.ind Statute.ind Other.ind
	pdflatex $<
	pdflatex $<
	
clean:
	rm -f *.idx *.ilg *.ind *.toc *.aux *.log *.out *.tmp *.xref *.lg *.dvi *.idv *.4ct *.4tc

distclean: clean
	rm -f $(NORMAL_OUTPUTS) $(LAWREVIEW_OUTPUTS)
