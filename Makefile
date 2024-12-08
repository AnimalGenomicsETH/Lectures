all: 2024_FAO.pdf

%.pdf: %/slides.md slides.sty beamer.template
	pandoc --template=beamer.template -t beamer --pdf-engine=lualatex --pdf-engine-opt=-shell-escape -V colorlinks:true --listings -fmarkdown-implicit_figures -H $(word 2,$^) -s $< -o $@

.PHONY: clean

clean:
	rm -f *.pdf

.PHONY: clean
