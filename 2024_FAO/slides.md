---
title: A screenshot of the pangenome
author:
  - Alexander Leonard\inst{1}
institute:
  - \inst{1}ETH Zürich
date: 2024/12/12
output:
  beamer_presentation:
    slide_level: 3
    keep_tex: true
fontsize: 11pt
aspectratio: 169
---

### Overview {.plain .noframenumbering}

\tableofcontents

``` {=latex}
\end{frame}
\section[Genome era]{Democratised genome assembly}
```

### What is a genome?

Encode *one* layer of information for an individual organism

Sequence of ~ 1,000,000,000 nucleotides \[ACTG\] split into chromosomes

### Reference genomes

Definition of a reference genome:

> *A reference sequence is an accepted representation that is used by researchers as a standard for comparison to DNA sequences generated in their studies.*

. . .

We can then align to **this** sequence and *call* variants.

. . .

\includesvg[width=0.75\textwidth]{2024_FAO/reference_alignment.svg}

### Routine genome assembly

Long read sequencing has *almost* solved genome assembly

> Jarvis, E.D., Formenti, G., Rhie, A. et al. Semi-automated assembly of high-quality diploid human reference genomes. *Nature* **611**, 519–531 (2022). [https://doi.org/10.1038/s41586-022-05325-5](https://doi.org/10.1038/s41586-022-05325-5)

. . .

Much faster **and** much cheaper **and** much easier today

. . .

Solving a puzzle is easier with larger pieces

 - fewer pieces
 - span complex regions
 - distinguish similar regions

### What is a **pan**genome?

How can we integrate many assemblies into one analysis?

. . .

\only<2>{\includesvg[width=0.9\textwidth]{2024_FAO/pangenome_graph_1.svg}}
\only<3>{\includesvg[width=0.9\textwidth]{2024_FAO/pangenome_graph_2.svg}}
\only<4>{\includesvg[width=0.9\textwidth]{2024_FAO/pangenome_graph_3.svg}}

``` {=latex}
\end{frame}
\section[Pangenome era]{Are pangenomes style over substance?}
```

### Graph resolution


Do pangenomes *have to* represent the input genomes?

. . .

:::incremental
 - `pangene` only considers annotated genes
 - `minigraph` focuses on structural variation
 - `pggb`/`cactus` allow base-level resolution
 - *k*-mers, minimizers, conserved sequence
:::
\addtocounter{beamerpauses}{-1}

. . .

[No one graph to rule them all]{.alert}

### Are pangenomes a reference or a resource?

Pangenomes as a reference:

> Can we exploit the diversity in the graph genome to improve analyses of other data?

. . .

Pangenomes as a resource:

> Can we exploit the diversity already present **within** the graph to address questions


### Nothing new under the sun

Pangenomes are sadly [overhyped]{.alert}

. . .

\

Input is lots of sequencing data...

\hfill ...output is genomic alignment/variation

\

. . .

Stop "pangenome" becoming the new "quantum"!

### ~~Nothing~~ Something new under the sun

Pangenomes *can* help mitigate "reference bias"

. . .

\includesvg[width=0.8\textwidth]{2024_FAO/reference_bias.svg}

. . .

How do we distinguish *bad alignment* from *biology*?

---

### Mitigating **major** breed bias

We can only assess variation *with respect to the reference*

. . .

What if a quantitative trait locus wasn't in the reference?

. . .

\only<3>{\includesvg[width=0.7\textwidth]{2024_FAO/reference_bias_hard_1.svg}}
\only<4>{\includesvg[width=0.7\textwidth]{2024_FAO/reference_bias_hard_2.svg}}

### "Personalised" pangenomes

Unnecessary variation may be detrimental, but we **need** to share coordinates

> Sirén, J., Eskandar, P., Ungaro, M.T. et al. Personalized pangenome references. *Nat Methods* **21**, 2017–2023 (2024). [https://doi.org/10.1038/s41592-024-02407-2](https://doi.org/10.1038/s41592-024-02407-2)

. . .

\only<2>{\includesvg[width=0.75\textwidth]{2024_FAO/personalised_pangenome_1.svg}}
\only<3>{\includesvg[width=0.75\textwidth]{2024_FAO/personalised_pangenome_2.svg}}

``` {=latex}
\end{frame}
\section[BPC]{The Bovine Pangenome Consortium}
```

### The Bovine Pangenome Consortium


Decentralised international collaboration across 13+ groups and 6 continents

Driving goal:

> Provide genome assemblies and a community-agreed pangenome representation to replace breed-specific reference assemblies for cattle genomics

. . .

Leverage specific resources without fragmenting the community

. . .

A "rare" variant in the Human graph might be a breed-specific variant in the Bovine graph

### White headed phenotype

"Resource" pangenomes reduce false positive mapping of reads

. . .

\includegraphics[width=0.75\textwidth]{2024_FAO/KIT_example.png}


\vfill\hfill[https://doi.org/10.1101/2024.02.02.578587](https://doi.org/10.1101/2024.02.02.578587)

### (Super)pangenomes

We can represent breeds of cattle, what about more?

Other economically relevant bovids (especially geographic)

 - bison
 - banteng
 - gayal
 - yak
 - buffalo

 . . .

 When will it not make sense to compare genomes?

### Evolution and gene loss

"Result" pangenomes contain variation, do they overlap genes?

. . .

*THRSP* -- Thyroid Hormone Responsive

\only<2>{\includesvg[width=0.9\textwidth]{2024_FAO/THRSP_1.svg}}
\only<3>{\includesvg[width=0.9\textwidth]{2024_FAO/THRSP_2.svg}}
\only<4>{\includesvg[width=0.9\textwidth]{2024_FAO/THRSP_3.svg}}

\vfill\hfill[https://doi.org/10.1038/s42003-024-07295-y](https://doi.org/10.1038/s42003-024-07295-y)

### Looking to the future

\setcounter{section}{0}

Pangenomes can

. . .

:::incremental
 - offer a (slightly) new angle to explore the flood of genomic data
 - mitigate bias and represent global diversity
 - prevent a reference genome apocalypse
:::
\addtocounter{beamerpauses}{-1}
. . .

FAO workshop:

> Genomic assessment of genetic variation and the future of the breed concept

. . .

What if we don't need a *strict definition* of breed with pangenomes?

### Acknowledgements {.plain .noframenumbering}

\begin{figure}[!htb]
   \begin{minipage}{0.58\textwidth}
     \centering
     \latexincludegraphics[width=.9\linewidth]{Animal_Genomics_ETH.jpg}
   \end{minipage}\hfill
   \begin{minipage}{0.4\textwidth}
     \centering
     \latexincludesvg[width=.7\linewidth]{BPC_logo.svg}
   \end{minipage}
\end{figure}

\latexincludesvg[width=.3\linewidth]{SNSF.svg}
