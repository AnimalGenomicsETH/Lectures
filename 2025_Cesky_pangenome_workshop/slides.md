---
title: An introduction to pangenomics
author:
  - Alexander Leonard\inst{1}
institute:
  - \inst{1}ETH Zürich
date: 2025/01/23
output:
  beamer_presentation:
    slide_level: 3
    keep_tex: true
fontsize: 11pt
aspectratio: 169
---

### Caveat emptor {.plain .noframenumbering}

There are not any pangenome "curriculums". \
These are ideas *we think* are useful to help apply pangenomics to your own research.

. . .

Get involved and discuss any questions or ideas of your own!

### Overview {.plain .noframenumbering}

\nolink{\tableofcontents}

``` {=latex}
\end{frame}
\section[Pangenome basics]{Introduction to pangenomics}
```
## Test 1

### What is a genome?

### What is a **pan**genome?

### Why pangenome?

Never going to have less sequencing

### Pangenome terminology

**Pangenome**: a collection of assemblies

**Graph**: a type of pangenome representation with nodes and edges

**Nodes**: some contiguous sequence

**Edges**: connection between contiguous sequences

**Bubbles**: regions of variation

### Genome file formats

Most sequencing data (or anything representing genomes) are in *fasta*/*q*.

Sequence alignments are generally in *SAM*/*BAM*.

Other miscellaneous files like *BED*, *GFF*, etc.

### Pangenome file formats

New file formats! \
**GFA**: Graphical Fragment assembly.

. . .

Three main components:

 - S-lines: the sequence of the nodes
 - L-lines: how the graph is connected with edges
 - P-lines: how a "sample" traverses the graph (*optional*)

. . .

```ruby
S s1  AATTTACC
S s2  GGTAT
S s3  T
L s1  + s2  + 0M
L s1  + s3  + 0M
L s2  + s3  - 0M
P Alice  s1+,s2+,s3
P Bob s1+,s3+
```
. . .

There are other, less used lines (**W**alk/**J**ump).

### Pangenome file formats

Most downstream tools have their own "efficient" representation:

 - `.og`
 - `.vg`
 - `.xg`
 - `.gbz`

These graphs contain a lot of information. \
GFA is human-readable and can be stored better for computer operations.

---

### Pangenome file formats

GAF: **G**raph **A**lignment **F**ormat \
A graph "superset" of PAF (**P**airwise **m**Apping **F**ormat).

Similar to SAM/BAM, broadly capturing:

 - which read
 - aligns to where
 - and how good it was

 Likewise, this is human-readable, and so some tools prefer the binary version `.gam`.

## Visualisation

### Visualising genomic data

What types of genomic data do we normally try and visualise?

[//]: # (Interactive question)

---

### Visualising genomic data

IGV (**I**ntegrative **G**enomics **V**iewer, [https://igv.org/doc/desktop/](https://igv.org/doc/desktop/)) is a useful tool for visualising different formats of genomic data:

 - read alignments
 - bed files
 - gene annotations

. . .

*Seeing* the data can often influence later analyses:

 - too many/few reads where we expect them
 - overlap of variants and complex annotations

---

### Visualising genomic data

![IGV example](img/igv_snapshot.png){ width=100% }
\only<2>{\includesvg[width=0.9\textwidth]{2024_FAO/pangenome_graph_1.svg}}

. . .

Is there a pangenomic equivalent?

### Visualising **pan**genomic data

**Sadly, not really...** \
Everything is more complicated in the pangenomic world.

. . .

But it depends what are we interested in:

 - viewing relationship between many assemblies?
 - viewing alignments/annotations on pangenome graphs?

---

### Visualising **pan**genomic data

How do we visualise the *GFA* output of pangenome construction?

One of the most common tools is `Bandage` ([https://github.com/asl/BandageNG](https://github.com/asl/BandageNG)). \
It has several advantages:

 - easy to install
 - quick to load small-moderate graphs
 - lots of extra functionality


``` {=latex}
\end{frame}
\section[Working with pangenomes]{Working with pangenomes}
```

## Test 2

### Bandage

### Panacus

### Odgi

## Read mapping

### `vg deconstruct`.

### `vg giraffe`

aligning to non-DAG graphs

infinite cycle going around -> need to make "harsh" assumptions to say possible

``` {=latex}
\end{frame}
\section[Pangenomics 2.0]{Pangenomics of the future}
```

### `impg`

## Personalised pangenomes

### `vg haplotype`

### Variation overdose

Figure on relevant variation



### Summary 1

\setcounter{section}{0}

### Summary 2

### Activity


### Acknowledgements {.plain .noframenumbering}

