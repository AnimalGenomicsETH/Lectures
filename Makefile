all: 2025_Pangenomes.pdf

svg-inkscape/%.pdf: %.svg
	inkscape $< --export-area-page --export-filename $@

%.pdf: %/slides.md slides.sty beamer.template blocks.lua svg-inkscape/SNSF.pdf svg-inkscape/eth_logo_kurz_pos.pdf svg-inkscape/BPC_logo.pdf
	pandoc -t beamer --template=$(word 3,$^) --pdf-engine=lualatex --pdf-engine-opt=--shell-escape --lua-filter=$(word 4,$^) -V colorlinks:true --listings -fmarkdown-implicit_figures -H $(word 2,$^) -s $< -o $@

.PHONY: clean
.PRECIOUS: svg-inkscape/%.pdf

clean:
	rm -f *.pdf
	rm -rf svg-inkscape

.PHONY: clean
