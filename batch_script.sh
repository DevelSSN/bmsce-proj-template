#!/bin/bash

BIBFILE="$(ls *.bib)"
CSLFILE="$(ls *.csl)"

# Find all markdown files in the directory
CONV_ARR=($(find "./markdown" -type f -name "*.md"))

# Check if any markdown files are found
if [ ${#CONV_ARR[@]} -eq 0 ]; then
    echo "No markdown files found in $directory/markdown."
fi

# Print the list of markdown files
echo "Markdown files to be converted:"
echo "${CONV_ARR[@]}"

# Check if the template.tex file exists
if [ ! -f "template.tex" ]; then
    echo "Error: template.tex not found!"
    exit 1
fi

LATEXFILE=tmp.tex

# Create or overwrite main.tex with the contents of template.tex
cp template.tex main.tex

# Run pandoc to convert markdown files to LaTeX
pandoc "${CONV_ARR[@]}" --from=markdown --to=latex --top-level-division=chapter --citeproc --bibliography="$BIBFILE" --csl="$CSLFILE" --biblatex >> "$LATEXFILE"

# Append the LaTeX content to the main.tex file
cat "$LATEXFILE" >> ./main.tex

# Append bibliography and end document to main.tex
echo '\printbibliography
\end{document}' >> main.tex

# Clean up temporary LaTeX file
rm "$LATEXFILE"

# Run pdflatex and biber to generate the PDF
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
