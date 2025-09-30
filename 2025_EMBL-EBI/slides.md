---
title: Introduction to Pangenomics 
subtitle: and *why* they are worth exploring
author:
  - Alexander Leonard\inst{1,*}
institute:
  - \inst{1}Animal Genomics, ETH Zürich
  - \inst{*}\textcolor{ETH_Blau}{alleonard@ethz.ch}
date: 2025-10-01
logo: svg-inkscape/SNSF
logo_size: 0.8
output:
  beamer_presentation:
    slide_level: 3
    keep_tex: true
fontsize: 11pt
aspectratio: 169
---

### Caveat emptor {.plain .noframenumbering}

\vspace{0.75cm}
:::incremental
1. This is my version of pangenomics, but many other species/systems will be similar \vspace{0.75cm}
2. Genomics (without the pan!) has been and will continue to be successful \vspace{0.75cm}
3. Pangenomics is a wildly growing but wildly undefined field \vspace{0.75cm}
4. I am also confused by these topics
:::

### Learning outcomes {.plain .noframenumbering}

\vspace{0.75cm}
1. **Define** what a pangenome *is*  \vspace{0.75cm}
2. **Distinguish** it from *linear* reference genomes  \vspace{0.75cm}
3. **Understand** biological and computational motivations  \vspace{0.75cm}
4. **Discuss** opportunities and challenges in future research

### Overview {.plain .noframenumbering}

\nolink{\tableofcontents}

``` {=latex}
\end{frame}
\section[Motivation]{Why do we need pangenomes?}
``` 


## Genome explosion

### Conventional genomics

Some definitions from [genome.gov](https://www.genome.gov/genetics-glossary)

. . .

[The entire set of DNA instructions found in a cell]{.definitionblock title="Genome:"}

. . .

Generally refers to a single linear sequence

. . .

[An accepted representation that is used by researchers as a standard for comparison to DNA sequences generated in their studies]{.definitionblock title="Reference genome:"}


### Routine genome assembly

Long read sequencing has *almost* solved genome assembly\footnote<1-3>{Sorry if you work on plants}

. . .

Recent assembling is *faster* and *cheaper* and *easier*\footfullcite<2-3>{jarvis2022semi}


. . .

We can generate many genomes for similar individuals

### Publicly available assemblies

Consider mammalian genomes (>1 Gbp) on NCBI

. . .

\includesvg[width=0.6\textwidth]{figures/NCBI_genomes}

. . .

Likely a [large]{.alert} underestimate


### The "species" concept

Reference genomes tend to represent genus/species-level

. . .

what about

:::incremental
 - subspecies?
 - populations?
 - strains?
 - clones?
:::
\addtocounter{beamerpauses}{-1}

. . .

"-specific" reference genomes are a type of [XY problem](https://en.wikipedia.org/wiki/XY_problem)\footnote<6-7>{Not related to sex chromosomes}

. . .

Similar to a metagenomics problem?

## Linear limitations

### The nearest neighbour

We typically use the *nearest* reference genome to our sample

. . .

\includesvglayer{0.7}{figures/phylogeny}{1:1,2:1,2,3}{2:3:4-5}

\only<5>{What about admixture, hybridisation, introgression, etc?}


### Reference alignment

Sequence alignment confuses *divergence* with *mismapping*

. . .

\includesvglayer{0.75}{figures/mapping_bias}{1:1,2:1,2,3:1,2,3,4}{2:3:4:5-6}


\only<6>{Where does non-reference sequence get placed?}


### Reference bias

Almost all downstream steps assume good alignment

. . .

[The systematic distortion that occurs when sequencing reads are aligned to a linear reference genome, causing sequences that are *sufficiently* diverged from the reference to be mis- or unaligned]{.definitionblock title="Reference bias:"}

. . .

Pangenomes *can* mititgate reference bias


### Nested variation

VCF (**V**ariant **C**all **F**ormat) is great for recording differences *to* the reference

. . .

\includesvglayer{0.6}{figures/nested_vcf}{1:1,2:1,3}{2:3:4-5}

\only<5>{Pangenomes \emph{can} represent variation more generally}


### Terminal variation

Better assemblies often include new sequence on chromosome ends

. . .

Can we even represent variation before the reference starts?

. . .

From the VCFv4.2 specification

> Telomeres are indicated by using positions 0 or N+1, where N is the length of the corresponding
chromosome or contig.

. . .

Pangenomes *can* handle multiple genome termini


``` {=latex}
\end{frame}
\section[Terminology]{Getting started with pangenomes}
``` 

## More definitions 

### What is a pangenome

[A collection of genome sequences from many individuals of the same species]{.definitionblock title="Pangenome:"}

. . .

Currently 17 articles with "super-pangenome" titles

. . .

Avoid "prefix inflation" and just describe *any* collection\footfullcite<3>{chikhi2024logan}


### Adoption of pangenomes

"Pangenome" is becoming a ubiquitous term

. . .

\includesvg[width=0.6\textwidth]{figures/pangenome_publications}

. . .

Recent shift from bacterial pangenomes to larger genomes


### Levels of shared sequence

[Sequence shared by all individuals]{.definitionblock title="Core genome:"}

. . .

[Sequence present in some but not all individuals]{.definitionblock title="Accessory/Shell genome:"}

. . .

[Sequence found in only one individual]{.definitionblock title="Dispensable/Cloud genome:"}

. . .

Subtle dependence on the flavour (and [quality]{.alert}) of pangenome...

### Pangenome variation

How do we define variation without using a reference?

. . .

Variant loci are pangenome "bubbles"\footfullcite<2-3>{paten2018superbubbles}

. . .

More complex definitions\footfullcite<3>{salehi2025defining}

> We propose to define pangenome variants against a reference tree... alleles are paths on the reference tree, and variants are pairs of alleles with a shared ‘branch point’.



### Pangenome flavours

Many different ways to collate genomes into a "pangenome"

. . .

:::incremental
 - variation graphs
 - de Bruijn graphs
 - multiple sequence alignments
 - BLAST databases?
 - VCF?
:::
\addtocounter{beamerpauses}{-1}

. . .

Different structures for different questions


## Pangenomic tools

### Files and formats


|                       | Linear            | Pangenomic       |
|-----------------------|:-----------------:|:----------------:|
| Reference genome  | `.fa`             | `.gfa`           |
| Indexing          | `.bwt`            | `.gbwt`          |
| Alignment format  | `.bam`/`.paf`    | `.gam`/`.gaf`   |


. . .

Not always as straightforward as adding "g"


### Pangenome building

|             | $\geq 50$ bp | $< 50$ bp | Reference-free | Lossless | N+1      | Compute     |
|-------------|:------:|:------:|:---------------:|:--------:|:--------:|:-----------:|
| `minigraph` | Yes    | No     | No             | No       | Easy     | Laptop      |
| `cactus`    | Yes    | Yes    | Yes-ish          | Yes-ish      | Easy-ish | Cluster     |
| `pggb`      | Yes    | Yes    | Yes              | Yes      | Rebuild  | Big cluster |

. . .

Progressive `cactus` versus `mg-cactus`

`impg`/`seqrush`/`allwave`


### Pangenome statistics

 - `gretl`
 - `panacus`

. . .

Pangenomes currently(?) lack good quality metrics \footnote<2-3>{Besides avoiding garbage in garbage out}

. . .

What might we want?

 - completeness
 - correctness
 - representativeness


### Pangenome visualising 
 
:::incremental
 - `odgi` \includesvg[width=0.5\textwidth]{2025_Cesky_pangenome_workshop/odgi_2D}
- `BandageNG` \includegraphics[width=0.4\textwidth]{2025_Cesky_pangenome_workshop/bandageNG}
:::

### Pangenome alignment
 
 For variation graphs

 - `minigraph`
 - `graphaligner`
 - `vg map`
 - `vg giraffe`

. . .

For dBGs

 - `ropebwt3 mem`
 - `moni align`
 - `pufferfish align`


``` {=latex}
\end{frame}
\section[Using pangenomes]{Why pangenomes are worth it}
``` 

## Opportunities

### Nonuniform karyotypes


Even "similar" species can undergo complex chromosomal evolution

. . .

Consider muntjacs\footfullcite<2-3>{kalbfleisch2024ruminant}

\includegraphics[width=0.23\textwidth]{figures/rT2T.png}

. . .

How do we handle this diversity?


### Pangenome communities

Consider interchromosomal hits between assemblies

. . .

\includegraphics[width=0.3\textwidth]{figures/communities}

. . .

Helped uncover recombination across *some* human chromosomes \footfullcite<3>{guarracino2023recombination}


### *Personalised* pangenomic read alignment

Large pangenomes contain *irrelevant* variation

. . .

Use sequencing read *k*-mers to retain *relevant* variation

. . .

\includesvglayer{0.625}{figures/personalised_pangenome}{1:1,2,3:1,2,4}{3:4:5-6}

\only<6>{Now it's a \emph{near}-linear alignment problem\footfullcite{siren2024personalized}}

### Pangenomic QTLs 

Identify pangenomic regions where some groups are (dis)similar\footfullcite<2-3>{milia2025taurine}

. . .

\includegraphics[width=0.6\textwidth]{2025_Pangenomes/KIT_jaccard}

. . .

Can we adopt other pop-gen methods to pangenomics?


### Pangenomics behind the curtain

Pangenomes are not very *accessible* to many collaborators, can we blackbox it?

. . .

```bash
#Linear approach, outputting SAM
bwa mem reference.fa ...

#Pangenome approach, outputting SAM
vg giraffe -o SAM reference.gfa ...

```

. . .

How much of the improvement survives the pangenome roundtrip?


## Challenges

### Here be dragons

There is almost no consensus on anything in pangenomics

. . .

Many tools struggle outside of their own ecosystem and change rapidly

. . .

Public services are generally tuned to linear genomes


### N+1 assembly problem

Pangenomes are generally expensive to construct and validate

. . .

Adding an extra assembly is often nontrivial \footnote<2>{if you want to limit new reference bias}


### Optimal representation

Building (or even *defining*) a good graph is [hard]{.alert}

. . .

\includesvglayer{0.55}{figures/suboptimal_graph}{1:1,2}{2:3-4}

. . .

\only<4>{Does \emph{good} depend on the question \emph{context}?}


### Unintentional complexity

Whole-genome alignments can contain spurious mappings

. . .

\includesvglayer{0.85}{figures/windowed_building}{1:1,2:1,2,3:1,2,3,4}{2:3:4:5-6}

\only<6>{Subgraphs can handle QTLs, chromosome communities, but not translocations}


### Pangenomic read alignment

`vg giraffe` aligns to DAGs (**D**irected **A**cyclic **G**raphs)

. . .

`pggb` and `minigraph-cactus` have different DAGness

. . .

\includesvglayer{0.8}{figures/DAG}{1:1,2:1,2,3:1,2,4}{3:4:5:6}

### Key takeaways

\setcounter{section}{0}

Pangenomes

. . .

:::incremental
 - are a collection of genome sequences \vspace{0.75cm}
 - can mitigate reference bias and better represent variation \vspace{0.75cm}
 - are [not]{.alert} needed for every question (neither are **T2T** genomes...)
:::
