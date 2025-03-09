#!/bin/bash
pwd
CONV_ARR=($(ls ./markdown/*.md))
echo "${CONV_ARR[@]}"
LATEXFILE=tmp.tex
cp template.tex main.tex
pandoc "${CONV_ARR[@]}" --from=markdown --to=latex --top-level-division=chapter --citeproc --bibliography=./references.bib --csl=./style.csl --biblatex >> $LATEXFILE
cat "$LATEXFILE" >> ./main.tex
echo '\printbibliography
\end{document}' >> main.tex
rm $LATEXFILE
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
