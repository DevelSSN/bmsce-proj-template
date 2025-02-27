#!/bin/bash
pwd
cp "$(pwd)/header.yaml" "$(pwd)/markdown/tmp.yaml"
echo "Going into the markdown directory"
cd "$(pwd)/markdown/" > /dev/null
echo "MD files found: $(ls *.md)"
CONV_ARR=($(ls *.md))
LATEXFILE=tmp.tex
for file in "${CONV_ARR[@]}"; do
	echo "Converting $file"
	pandoc --to=latex --from=markdown $file --top-level-division=chapter --citeproc >> $LATEXFILE
done
cd ../
cp template.tex main.tex
LATEXFILE="./markdown/tmp.tex"
cat "$LATEXFILE" >> ./main.tex
echo '\backmatter
\end{document}' >> main.tex
rm $LATEXFILE
rm ./markdown/tmp.yaml
pandoc main.tex -o output.pdf
