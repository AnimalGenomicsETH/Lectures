TEX= lualatex --shell-escape -interaction=nonstopmode -halt-on-error

all:

svg-inkscape/%.pdf: %.svg
	inkscape $< --export-area-page --export-filename $@

%.tex: %/slides.md slides.sty beamer.template blocks.lua
	pandoc -t beamer --template=$(word 3,$^) --lua-filter=$(word 4,$^) -V colorlinks:true --syntax-highlighting=idiomatic -fmarkdown-implicit_figures -H $(word 2,$^) -s $< -o $@


%.pdf: %.tex bibliography.bib svg-inkscape/SNSF.pdf svg-inkscape/eth_logo_kurz_pos.pdf svg-inkscape/BPC_logo.pdf
	latexmk -pdflua -shell-escape $*

.PHONY: clean
.PRECIOUS: svg-inkscape/%.pdf %.tex

clean:
	rm -f *.pdf
	for f in *.tex; do [ -f "$$f" ] && latexmk -C "$$f"; done
	rm -f *.tex
	rm -f *.{aux,bcf,log,run.xml,tex.bbl,toc,bbl,blg,nav,snm,tex.blg,vrb}
	rm -rf svg-inkscape

.PHONY: clean
