all: 2025_Cesky_pangenome_workshop.pdf

%.pdf: %/slides.md slides.sty beamer.template blocks.lua
	pandoc -t beamer --template=$(word 3,$^) --pdf-engine=lualatex --pdf-engine-opt=--shell-escape --lua-filter=$(word 4,$^) -V colorlinks:true --listings -fmarkdown-implicit_figures -H $(word 2,$^) -s $< -o $@

.PHONY: clean

clean:
	rm -f *.pdf
	rm -rf svg-inkscape

.PHONY: clean
