SRC = $(wildcard *.tex)

PDFS = $(SRC:.tex=.pdf)

XELATEX := $(shell command -v xelatex 2>/dev/null || { test -x /Library/TeX/texbin/xelatex && echo /Library/TeX/texbin/xelatex; } || echo xelatex)

all: clean pdf

en: clean
	mkdir -p build
	$(XELATEX) -output-directory=build resume.tex 

zh_CN: clean
	mkdir -p build
	$(XELATEX) -output-directory=build resume-zh_CN.tex 

	# UNCOMMENT the 2 lines below if you want to use bibliographic references
	# bibtex build/resume-zh_CN
	# $(XELATEX) -output-directory=build resume-zh_CN.tex 

	$(XELATEX) -output-directory=build resume-zh_CN.tex 
	mv build/resume-zh_CN.pdf build/xxx-xxx.pdf

pdf: clean $(PDFS)

%.pdf:  %.tex
	$(XELATEX) $<

ifeq ($(OS),Windows_NT)
# on Windows
RM = cmd //C del
else
# on Unix/Linux
RM = rm -rf
endif

clean:
	# $(RM) *.log *.aux *.bbl *.blg *.synctex.gz *.out *.toc *.lof *.idx *.ilg *.ind *.pdf
	$(RM) build/*
