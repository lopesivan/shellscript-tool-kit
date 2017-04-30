#!/bin/bash

FILES=(
	$( cat - )
)

cat << EOF

SRC           = ${FILES[*]}
find_img      = \$(wildcard \$(dir)/*.jpg)
dirs         := img
local_img    := \$(foreach dir,\$(dirs),\$(find_img))

LATEX         = latex
DVIPS         = dvips
PS2PDF        = ps2pdf
ECHO          = @echo

CONVERTE      = convert
CONVERTEFLAGS = -density 90x90

PDF           = \$(SRC:.tex=.pdf)
PS            = \$(SRC:.tex=.ps)
DVI           = \$(SRC:.tex=.dvi)
PNG           = \$(SRC:.tex=.png)
EPS           = \$(local_img:.jpg=.eps)

TARGETS       = \$(EPS) \$(DVI) \$(PS) \$(PDF)

all: \$(TARGETS)
# jpg -> eps
%.eps:  %.jpg
	\$(CONVERTE) -format eps \$(@:.eps=).jpg \$@

# tex -> dvi
%.dvi:  %.tex
	\$(LATEX) \$(@:.dvi=)

# dvi -> ps
%.ps:   %.dvi
	\$(DVIPS) \$(@:.ps=)

# ps -> pdf
%.pdf:  %.ps
	\$(PS2PDF) \$^
	\$(ECHO) evince \$@

# ps -> png
%.png:  %.ps
	\$(CONVERTE) \$(CONVERTEFLAGS) \$^ \$@

clean:
	/bin/rm -rf *.aux *.dvi *.log *.nav *.out *.ps *.snm *.toc *.vrb \$(PS) \$(DVI) \$(PNG) \$(PDF) \$(EPS)

# END OF FILE
EOF
