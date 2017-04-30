#! /bin/sed -f

/\.cpp/bis_cpp
/\.c/bis_c
/\.tex/bis_tex

# ----------------------------------------------------------------------------
								       :is_tex
# ----------------------------------------------------------------------------

h

s/.*/SRC           = &/

p;g

i\
\
find_img      = $(wildcard $(dir)/*.jpg)\
dirs         := img\
local_img    := $(foreach dir,$(dirs),$(find_img))\
\
LATEX         = latex\
DVIPS         = dvips\
PS2PDF        = ps2pdf\
ECHO          = @echo\
\
CONVERTE      = convert\
CONVERTEFLAGS = -density 90x90\
\
PDF           = $(SRC:.tex=.pdf)\
PS            = $(SRC:.tex=.ps)\
DVI           = $(SRC:.tex=.dvi)\
PNG           = $(SRC:.tex=.png)\
EPS           = $(local_img:.jpg=.eps)\
\
TARGETS       = $(EPS) $(DVI) $(PS) $(PDF)\
\
all: $(TARGETS)\
# jpg -> eps\
%.eps:  %.jpg\
\t$(CONVERTE) -format eps $(@:.eps=).jpg $@\
\
# tex -> dvi\
%.dvi:  %.tex\
\t$(LATEX) $(@:.dvi=)\
\
# dvi -> ps\
%.ps:   %.dvi\
\t$(DVIPS) $(@:.ps=)\
\
# ps -> pdf\
%.pdf:  %.ps\
\t$(PS2PDF) $^\
\t$(ECHO) usage: evince $@\
\
# ps -> png\
%.png:  %.ps\
\t$(CONVERTE) $(CONVERTEFLAGS) $^ $@\
\
clean:\
\t/bin/rm -rf *.aux *.dvi *.log *.nav *.out *.ps *.snm *.toc *.vrb $(PS) $(DVI) $(PNG) $(PDF) $(EPS)

bis_eof

# ----------------------------------------------------------------------------
								       :is_cpp
# ----------------------------------------------------------------------------

h

s/.*/# Makefile: A standard Makefile for &/

p;g

s/\([^ ]\+\)\.cpp\s*.*/\nall  : \1/

p;g

i\
clean:
s/\([^ ]\.cpp\)\s*/\1: /
s/\.cpp//
s/\(.*\):\([^:]*\)/\t\/bin\/rm -rf \1 \1.o\2/
s/\.cpp/.o/

p;g

bis_eof

# ----------------------------------------------------------------------------
									 :is_c
# ----------------------------------------------------------------------------

h

s/.*/# Makefile: A standard Makefile for &/

p;g

s/\([^ ]\+\)\.c\s*.*/\nall  : \1/

p;g

i\
clean:
s/\([^ ]\.c\)\s*/\1: /
s/\.c//
s/\(.*\):\([^:]*\)/\t\/bin\/rm -rf \1 \1.o\2/
s/\.c/.o/

p;g

##############################################################################
:is_eof
g
s/^.*/# END OF FILE/
