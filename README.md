##  LaTeX template for BMSCE
This is a unofficial template for BMSCE Projects.
Based on 2024-2025 CSE Department Template.

### Installation
-   For the latest release, grab the latest tagged version from the git tree.
-   To use the latest branch, either run in your destination folder 
```bash
git clone https://github.com/DevelSSN/bmsce-proj-template.git
```
or extract the ZIP associated with the repository by clicking on the code button at the top right side of the repo.

-   For Windows, run `Installer.exe` to install required package.
-   For Ubuntu/WSL, run `init.sh` to install software required by the template.
-   For other OS, please consult the respective package repositories online.

### Usage

-   Users can either use the markdown version or the LaTeX version.
-   For LaTeX, grab the files `template.tex`, `frontpage.tex`, `references.bib` and `*.png`, and import them into your LaTeX editor (offline or online).
-   For Markdown, use the extracted ZIP folder as it is.
-   Offline use
    -   To use the LaTeX template, install [texLive](https://www.tug.org/texlive/), [biber](https://sourceforge.net/projects/biblatex-biber/) and any favourite editor like [VS Code](https://code.visualstudio.com/), [vim](https://www.vim.org/), [nvim](https://neovim.io/) etc.
    -  To use Markdown, install [Pandoc](https://pandoc.org/installing.html)

    -  To convert LaTeX into pdf, use
    ```bash
    pdflatex myfile.latex
    ```
    This will output `myfile.pdf`.

-   Online use
    -   Only LaTeX is currently supported. One can head over to [Overleaf](https://overleaf.com), and create a blank project inside, then import the local copy.


Alternatively, scripts for \*nix have been added to assist in the creation of the pdf. Just be sure to have installed required software previously.
```bash
./batch_script.sh
```

### HowTo

This HowTo is for offline users only.

First, Install all required software. Then clone this repository and run `init_script.sh`. This will install required LaTeX packages in your texLive distribution.

Convention is that the folder containing template.tex is the ROOT_DIR. Create a markdown SubDir in your ROOT_DIR and create your markdown content there.

After completion of editing your raw files, go back into ROOT_DIR and run the required script. It will output a PDF main.pdf.

-   Learn Markdown using this [Guide.txt](./Guide.txt) file. An older [PDF](./DOCS/Pandoc+Markdown.pdf) has been attached as a reference book.

### Features:

- [x] LaTeX Template for the starting pages.
- [x] Wiki to explain the workings.
- [x] Markdown for the actual document (Partial, Non-Graph qualified).
- [x] Guide to using Pandoc to generate the content.
- [x] Adding Bibliographies using Pandoc.

### Guides
[Guide to LaTeX](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes#Writing_your_first_piece_of_LaTeX)

[Guide to Pandoc](https://pandoc.org/MANUAL.html)
