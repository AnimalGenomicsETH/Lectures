TEX= lualatex --shell-escape -interaction=nonstopmode -halt-on-error

all:

svg-inkscape/%.pdf: %.svg
	inkscape $< --export-area-page --export-filename $@

%.tex: %/slides.md slides.sty beamer.template blocks.lua svg-inkscape/SNSF.pdf svg-inkscape/eth_logo_kurz_pos.pdf svg-inkscape/BPC_logo.pdf
	pandoc -t beamer --template=$(word 3,$^) --pdf-engine=lualatex --pdf-engine-opt=--shell-escape --lua-filter=$(word 4,$^) -V colorlinks:true --syntax-highlighting=idiomatic -fmarkdown-implicit_figures -H $(word 2,$^) -s $< -o $@


%.pdf: %.tex bibliography.bib
	$(TEX) $*
	biber $*
	$(TEX) $*
	$(TEX) $*

.PHONY: clean
.PRECIOUS: svg-inkscape/%.pdf

clean:
	rm -f *.pdf
	rm -f *.tex
	rm -f *.{aux,bcf,log,run.xml,tex.bbl,toc,bbl,blg,nav,snm,tex.blg,vrb}
	rm -rf svg-inkscape

.PHONY: clean
