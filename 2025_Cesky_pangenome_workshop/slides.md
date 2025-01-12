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
This will be a taster to help apply pangenomics to your own research.

. . .

This also focuses on "**sequence graph**" pangenomics, there are many other types out there!
. . .

Get involved and discuss any questions or ideas of your own!

### Overview {.plain .noframenumbering}

\nolink{\tableofcontents}

``` {=latex}
\end{frame}
\section[Pangenome basics]{Introduction to pangenomics}
```

## Terminology

### What is a genome?

Encode *one* layer of information for an individual organism

Sequence of ~ 1,000,000,000 nucleotides \[ACTG\] split into chromosomes

### Reference genomes

Definition of a reference genome:

> *A reference sequence is an accepted representation that is used by researchers as a standard for comparison to DNA sequences generated in their studies.*

### Reference bias

Why do we even **want** pangenomes?

. . .

\only<2>{\includesvg[width=0.7\textwidth]{2025_Cesky_pangenome_workshop/reference_bias_1.svg}}
\only<3>{\includesvg[width=0.7\textwidth]{2025_Cesky_pangenome_workshop/reference_bias_2.svg}}
\only<4>{\includesvg[width=0.7\textwidth]{2025_Cesky_pangenome_workshop/reference_bias_3.svg}}
\only<5>{\includesvg[width=0.7\textwidth]{2025_Cesky_pangenome_workshop/reference_bias_4.svg}}

### Routine genome assembly

Long read sequencing has *almost* solved genome assembly

Solving a puzzle is easier with larger pieces

> Jarvis, E.D., Formenti, G., Rhie, A. et al. Semi-automated assembly of high-quality diploid human reference genomes. *Nature* **611**, 519–531 (2022). [https://doi.org/10.1038/s41586-022-05325-5](https://doi.org/10.1038/s41586-022-05325-5)

. . .

Much faster **and** much cheaper **and** much easier today

### What is a **pan**genome?

How can we integrate many assemblies into one analysis?

. . .

\only<2>{\includesvg[width=0.9\textwidth]{2025_Cesky_pangenome_workshop/pangenome_graph_1.svg}}
\only<3>{\includesvg[width=0.9\textwidth]{2025_Cesky_pangenome_workshop/pangenome_graph_2.svg}}
\only<4>{\includesvg[width=0.9\textwidth]{2025_Cesky_pangenome_workshop/pangenome_graph_3.svg}}

### Genome file formats

Most sequencing data (or anything representing genomes) are in *fasta*/*q*.

Sequence alignments are generally in *SAM*/*BAM*.

Other miscellaneous files like *BED*, *GFF*, etc.

### Pangenome terminology

How do we describe a graph-based sequence/variation pangenome?

. . .

\only<2>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/example_gfa_1.svg}}
\only<3>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/example_gfa_2.svg}}
\only<4>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/example_gfa_3.svg}}
\only<5>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/example_gfa_4.svg}}

### Pangenome file formats

New file formats! \
**GFA**: Graphical Fragment assembly.

. . .

Three main components:

 - S-lines: the sequence of the nodes
 - L-lines: how the graph is connected with edges
 - P-lines: how a "sample" traverses the graph (*optional*)

### Pangenome file formats

```ruby
H       VN:Z:1.0
S       s1      AATTTACC
S       s2      GGTAT
S       s3      T
S       s4      CCCGATA
S       s5      GGACTA
S       s6      TTAC
L       s1      +       s2      +       0M
L       s1      +       s3      +       0M
L       s2      +       s4      +       0M
L       s3      +       s4      +       0M
L       s4      +       s5      +       0M
L       s5      +       s6      +       0M
L       s4      +       s6      +       0M
P       Alice   s1+,s2+,s4+,s5+,s6+ *
P       Bob     s1+,s3+,s4+,s6+ *
```

### Pangenome file formats

Most downstream tools have their own "efficient" representation:

 - `.og`
 - `.vg`
 - `.xg`
 - `.gbz`

These graphs contain a lot of information. \
GFA is human-readable and can be stored better for computer operations.

### Pangenome file formats

GAF: **G**raph **A**lignment **F**ormat \
A graph "superset" of PAF (**P**airwise **m**Apping **F**ormat).

. . .

Similar to SAM/BAM, broadly capturing:

 - which read
 - aligns to where
 - and how good it was

. . .

Likewise, this is human-readable, and so some tools prefer the binary version `.gam`.

## Graph building

### Graph building

TODO: fill this in with tools

### Different approaches

|             | $\geq 50$ bp | $< 50$ bp | Reference-based | Lossless | N+1      | Compute     |
|-------------|:------:|:------:|:---------------:|:--------:|:--------:|:-----------:|
| `minigraph` | Yes    | No     | Yes             | No       | Easy     | Laptop      |
| `cactus`    | Yes    | Yes    | No-ish          | Yes      | Easy-ish | Cluster     |
| `pggb`      | Yes    | Yes    | No              | Yes      | Rebuild  | Big cluster |

. . .

We can perfectly reconstruct any assembly from a lossless graph.

###

###

###

## Pangenome visualisation

### Pangenome visualisation

IGV (**I**ntegrative **G**enomics **V**iewer, [https://igv.org/doc/desktop/](https://igv.org/doc/desktop/)) is a useful tool for visualising different formats of genomic data:

 - read alignments
 - bed files
 - gene annotations

. . .

Is there a pangenomic equivalent?

### Visualising **pan**genomic data

**Sadly, not really...** \
Everything is more complicated in the pangenomic world.

. . .

But it depends what are we interested in:

 - viewing relationship between many assemblies?
 - viewing alignments/annotations on pangenome graphs?

### Interactive visualisation

How do we visualise the *GFA* output of pangenome construction?

. . .

One of the most common tools is `Bandage` ([https://github.com/asl/BandageNG](https://github.com/asl/BandageNG)). \
It has several advantages:

 - easy to install
 - quick to load small-moderate graphs
 - lots of extra functionality

### Interactive visualisation

\includegraphics[width=0.9\textwidth]{2025_Cesky_pangenome_workshop/bandageNG.png}


### Static visualisation

Large graphs (many nodes and/or edges) are complex to render.

. . .

Let the computer do the hard work and render a static representation!

### Static visualisation

Break pangenome down into multiple linear blocks

. . .

\only<2>{\includegraphics[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/odgi_1D.png}}

### Static visualisation

"Optimally" lay out nodes/edges in 2D with *Hogwild!* algorithm.

. . .

\only<2>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/odgi_2D.svg}}


``` {=latex}
\end{frame}
\section[Working with pangenomes]{Working with pangenomes}
```

## Pangenome communities

### Pangenome communities

Building pangenomes per chromosome is much easier than genome-wide

. . .

What if

 - we care about interchromosomal events
 - we don't know how to define "per chromosome"
 - we don't have assigned chromosomes

### Nonuniform karyotypes

Even "similar" species can undergo complex chromosomal evolution

. . .

\only<2>{\includegraphics[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/rT2T_karyotypes.png}}  

### Community detection

Build a network from mapped segments across genomes

. . .

\only<2>{\includegraphics[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/communities.pdf}}  

Graph theory has community-detection algorithms!

### Community sensitivity

Translocations or complex rearrangements are also *identified*

. . .

Distinguishing signal from noise is hard for small/infrequent mappings

## Pangenome validation

### Pangenome validation

How do we know if the pangenome we built is any good?

TODO:

### Some basic order of operations

1. Check length
2. Check average node size
3. Check node depth/frequency

. . .

We could use `gfatools stat` or `odgi stats` for example to get such information.

### Pangenome graph statistics

Graphs can be described by the number of nodes and edges they contain.

Different graphs (e.g., `pggb` versus `minigraph`) may have similar length, but very different node/edge counts.

. . .

Consider the average node size (pangenome length / number of nodes) or average edge degree (number of nodes / number of edges).

Should be *reasonable* (how many bases do you expect before a SNP?).

### Pangenome graph statistics

```ruby
Number of segments: 10140559
Number of links: 14371940
Number of arcs: 28743880
Total segment length: 200985993
Average segment length: 19.820
Max degree: 106924
Average degree: 1.417
```

. . .

The total pangenome size should *approximately* be equal to the reference plus all variation.

### Pangenome openness

What happens when we add more samples an analysis?

. . .

Asymptotic limit for population variant.

### Pangenome openness

Consider something like Heap's law:

> describes the number of distinct words in a document as a function of the document length

. . .

$$N \propto n^{-\alpha}$$

where:

 - N is approximately the number of gene families
 - n is the number of input genomes
 - $\alpha$ is the important constant

. . .

If $\alpha > 1$, the pangenome is **closed**, otherwise if $\alpha \leq 1$, the pangenome is **open**.

### Pangenome openness

We want enough samples to confidently *estimate* open/closedness.

. . .

Agriculture pangenomes may behave differently:

 - small effective population sizes per breed/line
 - many distinct breeds/lines per species
 - many closely related species

. . .

We might get "bumps" in the distribution when adding distinct samples.

### Pangenome layers

Pangenome openness effectively addresses the total unique sequence. \
What about different levels of intersection?

. . .

We can characterise pangenome *nodes* as:

 - **core**: present in all/most samples
 - **shell**: present in at least two samples
 - **cloud**: present in only one sample
 - **flexible**/**dispensable**: varies, but something like shell/cloud

### Pangenome layers

As we add many samples, the core component decreases. \
Eventually, this will just be ultraconserved elements.

. . .

Misassemblies might erroneously "demote" core segments to shell, or introduce cloud segments.


We can use this as a sanity check:

. . .

 - critical genes should be core
 - similar samples should not have too much private variation


### Pangenome layers

**HOWEVER** \
It is hard to distinguish assembly issues from bad pangenome building.

. . .

An uncollapsed homology could appear as a cloud segment or disrupt a core gene.

A rarely assembled region might appear as a cloud segment in a T2T genome.

. . .

But all of these cases can highlight areas worth exploring.


### Pangenome layers

There are several software available for pangenome openness:

 - `panacus` ([https://github.com/marschall-lab/panacus](https://github.com/marschall-lab/panacus))
 - `odgi heaps`
 - `gretl` ([https://github.com/MoinSebi/gretl](https://github.com/MoinSebi/gretl))

## Downstream pangenomics

### Downstream pangenomics

Once we have a "good" pangenome, what can we actually do with it?

### Calling pangenome variants

We can also call variants *within* the pangenome with `vg deconstruct`

. . .

"Project" back into linear space (losing *some* pangenomic benefits)

. . .

\only<3>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/example_gfa_5.svg}}

### Aligning to pangenomes

Linear-reference alignment is "simple"

. . .

 - check if next base is a match
 - genomic distance matches insert size
 - opposite strand is the reverse complement

. . .

\only<3>{\includegraphics[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/seed_extend.png}}  

### Aligning to pangenomes

`vg giraffe` was a huge step forward for read-to-graph alignment

. . .

Many algorithms silently assume "DAGs" (**D**irected **A**cyclic **G**raph)

non-DAGs allow revisiting a node (maybe infinitely times)

. . .

\only<3>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/DAG.svg}}

### Long read alignment

Long reads span more bubbles in graphs, complicating alignment

. . .

Currently fewer "production" tools, but there are

 - `GraphAligner`
 - `vg giraffe-lr` soon!

``` {=latex}
\end{frame}
\section[Pangenomics 2.0]{Pangenomics of the future}
```

## Personalised pangenomes

### Personalised pangenomes

Pangenomes are critical to give coordinates to all sequence

. . .

We need to **maintain** those coordinates across all analyses

. . .

Can we "filter" out graph complexity not useful for a given sample?

### Irrelevant variation

We can easily get *k*-mers for a sequenced sample

Keep nodes/edges which span those *k*-mers

. . .

\only<2>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/personalised_pangenome_1.svg}}
\only<3>{\includesvg[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/personalised_pangenome_2.svg}}

### Downstream blackbox

A user could provide a complete reference pangenome and (short) reads.

. . .
Inside a black box, we can then run

 - `vg haplotype`
 - `vg giraffe`
 - `vg surject`
 - `DeepVariant`

. . .

Improved variant calls without *direct* exposure to the pangenome

## Targeted pangenomes

### Targeted pangenomes

A *reference* pangenome should cover the entire genome

. . .

Most pangenome papers focus on one/several *QTL*

. . .

\only<3>{\includegraphics[width=0.8\textwidth]{2025_Cesky_pangenome_workshop/impg.png}}

### Manual QTL pangenome

For a given reference-annotated region, we can:

. . .

 1. lift over equivalent coordinates into other assemblies
 2. extract relevant section of those assemblies
 3. build a pangenome from these sequences

### A better approach

`impg` outlines a different approach

. . .

 1. conduct the hard all-to-all mapping once
 2. extract *transitive* regions based on reference coordinates
 3. build a pangenome from those sequences

### A new whole-genome approach?

Building many small pangenomes is easier than one big pangenome

. . .

Recombine pieces into chromosome-scale graphs with `gfalace`

. . .

Some unresolved concerns:

 - boundary conditions are poorly defined
 - events spanning the "split length" might be lost

### Summary -- starting with pangenomes

\setcounter{section}{0}

We can make pangenomes from a relatively small set of assemblies

. . .

Building *good* pangenomes is still hard, but quickly getting easier

. . .

We can use the pangenome as a *resource* or as a *reference*

### Summary --  shifting to pangenomes

Pangenomes are a powerful approach to

 - collate growing collections of assemblies
 - fight reference bias
 - analyse many samples/breeds/species at once

### Hands on pangenomics

During the activity we'll look at

 - building a small `minigraph` pangenome
 - visualising that pangenome in `BandageNG`
 - using `gfatools` to find regions of interest
