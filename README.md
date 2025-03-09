##  LaTeX template for BMSCE
This is a unofficial template for BMSCE Projects.
Based on 2024-2025 CSE Department Template.

### Installation
-   For the latest release, grab the latest tagged version from the git tree.
-   To use the latest branch, either run in your destination folder 
```bash
git clone https://github.com/DevelSSN/bmsce-proj-template.git
```
or extract the ZIP associated with the repository.

### Usage
-   Offline use
    -   To use the LaTeX template, install [texLive](https://www.tug.org/texlive/), and any favourite editor like [VS Code](https://code.visualstudio.com/), [vim](https://www.vim.org/), [nvim](https://neovim.io/) etc.
    -  To use Markdown, install [Pandoc](https://pandoc.org/installing.html).
    -  To convert LaTeX into pdf, use
    ```bash
    pdflatex myfile.latex
    ```
    This will output `myfile.pdf`.

-   Online use
    -   Only LaTeX is currently supported. One can head over to [Overleaf](https://overleaf.com), and create a blank project inside, then import the local copy.


Alternatively, scripts for \*nix have been added to assist in the creation of the pdf. Just be sure 
```bash
./batch_script.sh
```

### HowTo

This HowTo is for offline users only.

First, Install all required software. Then clone this repository and run `init_script.sh`. This will install required LaTeX packages in your texLive distribution.

Convention is that the folder containing template.tex is the ROOT_DIR. Create a markdown SubDir in your ROOT_DIR and create your markdown content there.

After completion of editing your raw files, go back into ROOT_DIR and run the required script. It will output a PDF main.pdf.

-   Learn Markdown using this [Guide.txt](./Guide.txt) file. A [PDF](./DOCS/Pandoc+Markdown.pdf) has been attached as a reference book.

### Features:

- [x] LaTeX Template for the starting pages.
- [ ] Wiki to explain the workings.
- [ ] Markdown for the actual document.
- [x] Guide to using Pandoc to generate the content.
- [ ] Adding Bibliographies using Pandoc.

### Guides
[Guide to LaTeX](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes#Writing_your_first_piece_of_LaTeX)

[Guide to Pandoc](https://pandoc.org/MANUAL.html)
