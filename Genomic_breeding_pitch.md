# Genomic Animal Breeding part 2 -- Current Challenges in Animal Genomics

Three broad sections covering "modern" genomic analyses:

 - Genomic sequencing
 - Large-scale genomic data
 - Transition to pangenomics

followed by some other topics rapidly gaining attraction like CRISPR.

Intended as an introduction to techniques currently employed in many fields of agricultural research.

Would cover 11 2-hour lectures and 2 2-hour practical sessions (~2 credit points).
PhD students can participate as teaching assistants during the practicals.

## Developed competencies

 - **Describe** recent advances in genomic sequencing and **interpret** their impact on the type and scale of genomic studies now possible.
 - **Integrate** different sources of genomic sequencing to **produce** variant sets or genome assemblies.
 -**Judge** which sequencing technologies would be useful for answering questions.
 - Assess pangenome graphs and **estimate** possible associations between variation and phenotypes. 

## Examination

Integrated performance assessment

> Given a pangenome, produce

 - whole-graph visualisation
 - identify a region of interest (complex variation, gene-SV, etc)
 - examine the region of interest in detail
   - visualise the subgraph
   - identify which alleles correspond to which samples
   - support the hypothesis using an independent methodology or source of data 

Option for assessed student presentations

Written examination covering

 - sequencing project design?
 - approaches for determining whole-genome variation within a population
 - advantages of pangenomes over linear reference genomes
 - potential applications and challenges of gene editing within agricultural uses

## Section 1 -- Genomic sequencing

### Lecture 1 -- Background and "legacy" sequencing

 - overview of reference genome, SNPs, etc
 - overview of DNA/RNA/epigenome/proteome
 - theory of genome coverage depth
 - progression of sequencing
   - first gen/sanger
   - second gen/NGS
   - third gen/long reads
   - "fourth gen"/ultalong/HQ/methylation
 - genotyping arrays

### Lecture 2 -- Long read sequencing
 
 - hint at limitations of short reads
 - progression of noisy to accurate long reads
 - PacBio & Nanopore
 - methylation
 

### Lecture 3 -- Multiomic sequencing

 - RNA sequencing
   - cDNA
   - native 
- conformation sequencing
  - HiC/microC/omniC
  - PoreC/CiFi
- ATAC/chip/DIP/
- RAD & panel target enrichment

## Section 2 -- Applying genomic data

### Lecture 4 -- Working with sequencing data

 - background on file formats
 - QC filtering
 - Sequencing alignment
   - trivial theory
   - types of algorithms used
   - short versus long read alignment

### Lecture 5 -- Variant calling and imputation

 - basics of variant calling
 - current variant callers
 - Sporadic imputation
 - Low pass imputation (could move to section 4)
   - alternative to arrays, similar cost but no explicit reference bias

### Practical 1 -- Analysing whole-genome sequencing data

Starting from aligned short and long read sequencing data

 - primer on unix/command line interface
 - calculate statistics of aligned BAMs
 - visualise alignments and variant calls in IGV
 - compare differences in short and long read data

### Lecture 6 -- Genome assembly

 - approaches to genome assembly
 - consequences of long reads
 - assessing genome quality
 - advantages of genomes over reads

## Section 3 -- Transition to pangenomics

### Lecture 7 -- Introduction to pangenomes

 - rapid increase in genome availability
 - mitigating reference-bias
 - building/visualising pangenomes
 - pangenome openess/core

### Lecture 8 -- Using agricultural pangenomes

 - pangenome deconstruction
 - overlap with coding regions
 - pangenome alignment/analysis
 - Implication on breed concept

### Practical 2 -- Building and visualising pangenomes

Starting from a curated set of several assemblies

 - build a small minigraph pangenome
 - use BandageNG to visualise/explore the pangenome
 - identify regions of interest in the pangenome for subsequent analysis

### Lecture 9 -- "Next generation" pangenomics

 - "super"pangenomes
 - personalised pangenomes
 - implicit pangenomes

## Section 4 -- Emerging topics

### Lecture 10 -- Gene editing

 - CRISPR
 - induced TE mutations

### Lecture 11 -- Student presentation
 
 - group presentation on topic addressed in lectures
 - address outstanding questions
 - practice exam 