---
keywords: ["Keyword1", "Keyword2", "Keyword3"]
language: "en"
fontsize: "12pt"
papersize: "a4"  # Or letter, depending on your requirement
geometry:
  - "left=1in"
  - "right=1in"
  - "top=1in"
  - "bottom=1in"
classoption:  # Specify class options here
  - "option1"
  - "option2"
beamerarticle: true  # Use the beamerarticle package if true
numbersections: true  # Enable section numbering if true
secnumdepth: 3  # Section depth (e.g., 3 for subsections)
font-settings:
  - "mainfont: Times New Roman"
  - "monofont: Courier New"
linestretch: 1.5
toc: true  # Include a table of contents
toc-title: "Table of Contents"
toc-depth: 2
lof: true  # Include List of Figures
lot: true  # Include List of Tables
has-frontmatter: true
has-chapters: true
biblio-title: "References"  # Change this if needed
nocite-ids: ["ref1", "ref2"]  # Cite specific references by ID
natbib: true  # If you're using natbib
biblatex: false  # If using biblatex instead of natbib
colorlinks: true
toccolor: "blue"  # Optional: link color for the TOC
after-header-includes: |
  \usepackage{amsmath}
  \usepackage{amssymb}
  \usepackage{xcolor}
  \hypersetup{colorlinks=true, linkcolor=blue, urlcolor=red}
  \setcounter{secnumdepth}{5}
output: pdf
---



#   GENERAL GUIDELINES:

-   For each figure, append it with a caption like "Fig 4.1: One-Line Description"
-   Again, include a caption for each table as "Table 1.1: Data of population"
-   Maximize the referencing of each image into the text of the report.
    - However, do this only if it is either necessary, or it enhances the clarity of the text.

#   Introduction{#sec:Intro}

##  Project Overview{#sec:IntroOverview}

-   In this introduction, please write relevant information about any technologies
    the project uses, or its features.

-   Also, mention the references/bibliographies required here.

##  Project Motivation{#sec:IntroMotive}

-   Here, mention the motivation behind the project.

1.  Why the project exists?
2.  What problem the project intends to solve?
3.  Any ideas on how the project goes about doing that?

#   Requirements{#sec:Requirements}

-   List all requirements of the project, like software required/tech stack/
    technology.
-   Also specify the hardware components and tools required.
-   Additional requirements are as per the project.

-   Each requirement category must have a section dedicated to it.

#   Description of the project{#sec:Project}

-   Explain the working of the project.
-   As per department/guide concerned, modify this to be several sections/chapters long.

#   Output(OR Outcome) of the project{#sec:Conclusion}

-   Describe the outcome of the project.
    -   This may include the output of the code, or the pictures of this project.
    -   This is flexible, as the content can be scattered throughout.
    -   Do this as per the direction of the guide.

**THIS CAN ALSO BE THE CONCLUSION OF THE PROJECT, HENCE MODIFY THE CHAPTER AND ITS SECTIONS ACCORDINGLY**

#   Bibliography{#sec:bib}

-   Append the bibliography, or the references here.
-   Style must be ascertained before insertion.


