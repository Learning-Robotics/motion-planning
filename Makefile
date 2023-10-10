BIBTEX=biber
LATEX=xelatex -interaction nonstopmode -halt-on-error -file-line-error -shell-escape
READER=zathura
SHELL=/bin/zsh

SRC=slides.tex
PDF=$(SRC:.tex=.pdf)
TMP=$(wildcard *.aux *.bbl *.bcf *.blg *.dvi *.log *.nav *.out *.ps *.fls *.listing *.glo *.idx *.run.xml *.snm *.tns *.toc *.vrb)

all: $(SRC)
	$(LATEX) $(SRC)
	$(BIBTEX) $(SRC:.tex=)

clean:
	-@rm -f $(PDF) $(TMP)

open:
	$(READER) $(PDF) &

install-ubuntu:
	sudo apt install texlive-xetex texlive-fonts-extra texlive-bibtex-extra biber
	sudo apt install texlive-latex-extra  # has metropolis beamer theme

watch:
	while [ 1 ]; do; inotifywait $(SRC) && make; done
