---
title: Advances and challenges in bovine pangenomics
author:
  - Alexander Leonard\inst{1,*}
  - Hubert Pausch\inst{1}
  - The BPC
institute:
  - \inst{1}Animal Genomics, ETH Zürich
  - \inst{*}\textcolor{ETH_Blau}{alleonard@ethz.ch}
date: \today
output:
  beamer_presentation:
    slide_level: 3
    keep_tex: true
fontsize: 11pt
aspectratio: 169
---

### Caveat emptor {.plain .noframenumbering}

Pangenomics is a *rapidly evolving* and *poorly defined* field.

This mostly focuses on "**sequence/variation graph**" pangenomics

. . .

\only<2>{\includesvg[width=0.9\textwidth]{figures/BPC_diagram.svg}}

### Overview {.plain .noframenumbering}

\nolink{\tableofcontents}

``` {=latex}
\end{frame}
\section[Pangenomics]{Transitioning to pangenomics}
```

## Reference limitations

### Conventional genomics

What is a genome?

> *The entire set of DNA instructions found in a cell.*

. . .

What is a *reference* genome?

> *An accepted representation that is used by researchers as a standard for comparison to DNA sequences generated in their studies.*

### The nearest neighbour

We typically use the *nearest* reference genome to our sample

. . .

 \includesvglayer{0.8}{figures/phylogeny}{1:1,2:1,2,3}{2:3:4}

\only<4>{What about admixture, hybridisation, introgression, etc?}

### The "species/breed" concept

Intrabreed diversity and interbreed similarity

. . .

\only<2-3>{\includegraphics[width=0.6\textwidth]{figures/breed_concept.png}}

. . .

"Breed-specific" reference genomes are a type of [XY problem](https://en.wikipedia.org/wiki/XY_problem)\only<3>{\footnote{Not related to sex chromosomes}}

### Routine genome assembly

Long read sequencing has *almost* solved genome assembly ^[Sorry if you work on plants]

> Jarvis, E.D., Formenti, G., Rhie, A. et al. Semi-automated assembly of high-quality diploid human reference genomes. *Nature* **611**, 519–531 (2022). [https://doi.org/10.1038/s41586-022-05325-5](https://doi.org/10.1038/s41586-022-05325-5)

. . .

Much faster **and** much cheaper **and** much easier today

We can generate many genomes for similar individuals

### Reference bias

Sequence alignment confuses **\textcolor{ETH_Grun}{divergence}** with **\textcolor{ETH_Rot}{mismapping}**

. . .

\includesvglayer{0.9}{figures/mapping_bias}{1:1,2:1,2,3:1,2,3,4}{2:3:4:5-6}

\only<6>{Pangenomes mitigate reference bias}

## Pangenomic challenges

### *Good* graphs?

Building (or even *defining*) a good graph is **\textcolor{ETH_Rot}{\underline{hard}}**

. . .

\includesvglayer{0.8}{figures/suboptimal_graph}{1:1,2}{2:3-4}

. . .

\only<4>{Does \emph{good} depend on the question \emph{context}?}

### *Better* graphs?

Whole-genome alignments can contain unintentional mappings

 - transposable elements
 - centromeres

. . .

\includesvglayer{0.85}{figures/windowed_building}{1:1,2:1,2,3:1,2,3,4}{2:3:4:5-6}

\only<6>{Subgraphs can handle QTLs, chromosome communities, but not translocations}

### Pangenomic read alignment

`vg giraffe` aligns to DAGs (**D**irected **A**cyclic **G**raphs)

. . .

`pggb` and `minigraph-cactus` have different DAGness

. . .

\includesvglayer{0.8}{figures/DAG}{1:1,2:1,2,3:1,2,4}{3:4:5:6-7}

\only<7>{Does the S/L lines define the graph, or do we \textbf{need}  the P/W?}

### *Personalised* pangenomic read alignment

Big graphs are

 - slow
 - often too complex to use downstream
 - necessary to maintain a common coordinate system

. . .

How can we handle this (**rapidly growing**) problem?

### *Personalised* pangenomic read alignment

Use *k*-mers from the sequencing reads to identify *relevant* variation

. . .

 \includesvglayer{0.9}{figures/personalised_pangenome}{1:1,2,3:1,2,4}{2:3:4-5}

\only<5>{Now it's a near-linear alignment problem}

### Pangenomic smash and grab

Pangenomes are not very *accessible* to many collaborators, can we blackbox it?

. . .

```bash
cat reference.fa assembly_*.fa > panSN.fa # start with linear reference 
pggb/minigraph/cactus panSN.fa # convert to pangenome
...
vg giraffe # operate on pangenome
vg surject # convert back to linear
deepvariant # operate on linear reference
```

. . .

How much of the improvement survives the roundtrip?

``` {=latex}
\end{frame}
\section[The BPC]{The Bovine Pangenome Consortium}
```

## Contributed data

### The Bovine Pangenome Consortium

Driving goal:

> *Provide genome assemblies and a community-agreed pangenome representation to replace breed-specific reference assemblies for bovine genomics*

. . .

My goal:

> *Quantify the downstream benefits, if any, of building large (50+ haplotypes) and diverse (>5% divergence) pangenomes*

### Assembly diversity

Phase 1: 167 assemblies covering 67 breeds and 9 non-cattle (sub)species

. . .

\includesvg[width=0.85\textwidth]{2025_Pangenomes/BPC_diversity.svg}

### Assembly quality

Ground-up collaboration leads to *heterogeneous* quality

- DNA sequencing
- Haplotype-resolution
- Scaffolding 

. . .

Some assemblies failing QC represented novel breeds

### Assembly contiguity

Heterogeneous methods lead to biases in N50 and genome size

. . .

\includesvglayer{0.8}{2025_Pangenomes/BPC_N50}{1:1,2:1,2,3}{2:3:4}

### Human comparison

Using 67 cattle assemblies versus 94 human haplotypes

. . .


\begin{table}[]
\rowcolors{3}{ETH_Grau!20}{white}
\begin{tabular}{lccccc}
\toprule
 & \textbf{Reference size} & \textbf{Nodes} & \textbf{Edges} & \textbf{1 bp nodes} & \textbf{Singletons} \\
\midrule
BTA1 & 158.5 & 11.34 & 15.84 & 7.37 & 1.21 \\
HPRC7 & 160.6 & 5.17 & 7.25 & 3.31 & 0.75 \\
BTA13 & 83.5 & 6.40 & 9.11 & 4.13 & 0.81 \\
HPRC17 & 84.3 & 2.76 & 3.93 & 1.78 & 0.41 \\
BTA28 & 45.9 & 3.93 & 5.57 & 2.56 & 0.45 \\
HPRC21 & 45.1 & 2.76 & 3.88 & 1.73 & 0.57 \\
\bottomrule
\end{tabular}
\end{table}

## Interesting examples

### *KIT* CNV

White-headness in Simmental/Hereford associated with a 14.3 Kb repetitive segment

. . .

\only<2->{\latexincludegraphics[width=0.4\textwidth]{2025_Pangenomes/KIT_jaccard.pdf}}\only<3>{\latexincludegraphics[width=0.5\textwidth]{2025_Pangenomes/KIT_example.png}}

### *THRSP* deletion

Different graphs have different strengths

`minigraph` is easier for an SV-only analysis

. . .

\includesvglayer{0.8}{2025_Pangenomes/Bison_THRSP}{1:1,2:1,2,3}{2:3:4}

### *PAG* polymorphism

We can also focus only on gene PAV with `miniprot` and `pangene`

. . .

Extreme variation around *PAG* (Pregnancy-Associated Glycoproteins)

\includesvg[width=0.55\textwidth]{2025_Pangenomes/pangene_PAG.svg}

. . .

Is this **\textcolor{ETH_Grun}{biological}** or **\textcolor{ETH_Rot}{technical}**?

### Looking forward

\setcounter{section}{0}

 - Pangenomes can handle "mixed" genomes
   - Tradeoff of including diverse samples and maintaining pangenome quality
\pause\vfill
 - Pangenomes are still challenging to work with
\pause\vfill
 - Pangenomes do offer a new approach/perspective over linear references
   - *Contextualise* which regions will benefit, pangenomes are not a silver bullet

### Acknowledgements

Hubert Pausch \& Animal Genomics group

\begin{tikzpicture}[remember picture,overlay]
  \node[xshift=11.7cm,yshift=6cm,inner sep=0] at (current page.south west){\latexincludegraphics[width=0.5\textwidth]{Animal_Genomics_ETH.jpg}};
  \node[xshift=9.8cm,yshift=3cm,inner sep=0] at (current page.south west){\latexincludegraphics[width=0.3\textwidth]{svg-inkscape/SNSF.pdf}};
   \node[xshift=13.5cm,yshift=3cm,inner sep=0] at (current page.south west){\latexincludegraphics[width=0.15\textwidth]{svg-inkscape/BPC_logo.pdf}};
\end{tikzpicture}

Also thanks to BPC

 - Sample contributors 
 - Steering committee
 - Many other collaborators

\vfill

\vfill

Interest in a "Pangenom**ETH**" mailing list?
