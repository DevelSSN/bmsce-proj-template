#   The Architecture of Quantum Computing

\begin{center}
\begin{tikzpicture}[shorten >=1pt, node distance=2cm, auto]
    \node (A) {A};
    \node (B) [right of=A] {B};
    \node (C) [right of=B] {C};
    \node (D) [below of=A] {D};

    \path[->] 
        (A) edge (B)
        (B) edge (C)
        (C) edge (B)
        (A) edge (D);
\end{tikzpicture}
\label{GraphRef}
\end{center}


| ID  | Name    | Age | Country   |
| --- | ------- | --- | --------- |
| 1   | Alice   | 24  | USA       |
| 2   | Bob     | 30  | Canada    |
| 3   | Charlie | 22  | UK        |
| 4   | David   | 28  | Australia |
| 5   | Emma    | 35  | Germany   |
| 6   | Frank   | 27  | France    |

:   Caption {#tbl:tabRef}

$$ x^2 + y^2 = c^2 $$

Above equation given by [@Einstein1905].

This is a citation to the work of Smith et al. [@smith2021].

![My Image](./resources/img.jpg){#fig:imgRef}


