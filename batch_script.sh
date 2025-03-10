#!/bin/bash

# Function to check if the file exists and has the correct extension
check_file() {
    local file=$1
    local ext=$2

    # Check if the file exists and has the correct extension
    if [[ -f "$file" && "${file: -${#ext}}" == "$ext" ]]; then
        echo "You selected $file"
        echo "$file"
    else
        echo "Invalid $ext file. Please enter a valid $ext file:"
        read file
        check_file "$file" "$ext"  # Recursively call to validate the new input
    fi
}

# Ask user for the directory to search (default is current directory)
echo "Enter the directory to search for files (press Enter to use the current directory):"
read directory
directory=${directory:-$(pwd)}  # Default to current directory if no input

# Ask user for the bibliography file (.bib)
echo "Enter the path to your .bib file (press Enter to search in $directory):"
read BIBFILE
BIBFILE=${BIBFILE:-"$(ls $directory/*.bib)"}  # Default to current directory if empty

echo "$BIBFILE"
# Check if the provided .bib file exists and is valid
BIBFILE=$(check_file "$BIBFILE" ".bib")

# Ask user for the CSL style file (.csl)
echo "Enter the path to your .csl file (press Enter to search in $directory):"
read CSLFILE
CSLFILE=${CSLFILE:-"$(ls $directory/*.csl)"}  # Default to current directory if empty

# Check if the provided .csl file exists and is valid
CSLFILE=$(check_file "$CSLFILE" ".csl")

# Find all markdown files in the directory
CONV_ARR=($(find "$directory/markdown" -type f -name "*.md"))

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
