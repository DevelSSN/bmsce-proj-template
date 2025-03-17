@echo off
setlocal enabledelayedexpansion

:: Set the directory paths
set BIBFILE=
set CSLFILE=

:: Find .bib and .csl files in the current directory
for %%f in (*.bib) do set BIBFILE=%%f
for %%f in (*.csl) do set CSLFILE=%%f

:: Find all markdown files in the "markdown" directory
set CONV_ARR=
for /r "./markdown" %%f in (*.md) do (
    set CONV_ARR=!CONV_ARR! "%%f"
)

:: Check if any markdown files were found
if "!CONV_ARR!"=="" (
    echo No markdown files found in .\markdown.
    exit /b
)

:: Print the list of markdown files to be converted
echo Markdown files to be converted:
echo !CONV_ARR!

:: Check if the template.tex file exists
if not exist "template.tex" (
    echo Error: template.tex not found!
    exit /b
)

:: Create or overwrite main.tex with the contents of template.tex
copy /y "template.tex" "main.tex"

:: Run pandoc to convert markdown files to LaTeX
pandoc "!CONV_ARR!" --from=markdown --to=latex --top-level-division=chapter --citeproc --bibliography="!BIBFILE!" --csl="!CSLFILE!" --biblatex >> tmp.tex

:: Append the LaTeX content to the main.tex file
type tmp.tex >> main.tex

:: Append bibliography and end document to main.tex
echo \printbibliography >> main.tex
echo \end{document} >> main.tex

:: Clean up temporary LaTeX file
del tmp.tex

:: Run pdflatex and biber to generate the PDF
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex

endlocal
