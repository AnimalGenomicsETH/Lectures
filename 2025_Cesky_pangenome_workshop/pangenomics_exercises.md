# Pangenomics exercises

Let's apply some of what we learned!  
This is just an introduction to the world of pangenomics, and there are many related tools and analyses we won't have time to cover here.

## Environment setup

There are several different tools we will want to use.  
We can mostly install them via `conda`, although in practice these versions can be fairly old for active research projects.  
Some of these can be used on MacOS, but are not available through bioconda.

```
conda create -f pangenomics.yaml
```

We also want to install `BandageNG` from [here](https://github.com/asl/BandageNG/releases/tag/continuous), depending on your operating system.  
Some features of `BandageNG` require `BLAST` or `minimap2` to be on your $PATH, so you may need to add `minimap2` (which is installed via `conda` here) to your $PATH manually.

## Tasks

All of these steps are possible to run even on a standard laptop, and generally only take a few mintutes for each command.  
In general, this is not true of pangenomics.  
Working with big graphs or more complex tools can easily requires hundreds of gigabytes of RAM and thousands of CPU hours and is only achievable for large computing clusters.

### Preparing the data

We will download some publicly available primate genomes (with similar karyotypes), and then specifically extract the chromosome corresponding to human chromosome 22.  
We'll also rename the chromosome names for the sequences using [PanSN-spec](https://github.com/pangenome/PanSN-spec), allowing us to examine the "same" chromosome across multiple samples in a pangenome.

The assemblies include:
  - Humans (*Homo sapiens*)
  - Chimpanzee  (*Pan troglodytes*)
  - Bonobo (*Pan paniscus*)
  - Western gorilla (*Gorilla gorilla*)
  - Bornean orangutan (*Pongo pygmaeus*)
  - Sumatran orangutan (*Pongo abelii*)
  
```
curl https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.hap1.cur.20231122.fasta.gz > mPanTro3.fa.gz
curl https://genomeark.s3.amazonaws.com/species/Pongo_pygmaeus/mPonPyg2/assembly_curated/mPonPyg2.hap1.cur.20231122.fasta.gz > mPonPyg2.fa.gz
curl https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.hap1.cur.20231205.fasta.gz > mPonAbe1.fa.gz
curl https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/mPanPan1.mat.cur.20231122.fasta.gz > mPanPan1.fa.gz
curl https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/mGorGor1.mat.cur.20231122.fasta.gz > mGorGor1.fa.gz

for i in mPanTro3 mPonPyg2 mPonAbe1 mPanPan1 mGorGor1
do
  samtools faidx ${i}.fa.gz
  samtools faidx -r <(grep -E "chr23_\w+_hsa22" ${i}.fa.gz.fai | cut -f 1) ${i}.fa.gz | awk -v N="${i}#1#chr22" '/>/ {$1=">"N}1' | bgzip -c > ${i}.hsa22.fa.gz
  samtools faidx ${i}.hsa22.fa.gz
done

curl https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/HG002/assemblies/hg002v1.1.fasta.gz > hg002v1.1.fa.gz
samtools faidx hg002v1.1.fa.gz
samtools faidx hg002v1.1.fa.gz chr22_MATERNAL | awk '/>/ {$1=">hg002#1#chr22"}1' | bgzip -c > hg002.hsa22.fa.gz
samtools faidx hg002.hsa22.fa.gz
```

### Building a pangenome

We'll use `minigraph` to build our chromosomal pangenome.  
Construction is fairly straightforward, we provide assemblies in the order we want them included (i.e. the first assembly is the "backbone" of the pangenome).  
Here, we use `-L 100` to include variation approximately 100 bases or larger, but you can experiment with other values to see how that affects the graph structure/statistics.  
Going below roughly `-L 20` leads to a rapid increase in warnings/errors and makes the graphs much larger and consequently harder to work with.

```
minigraph -cxggs -L 100 -o primate.gfa hg002.hsa22.fa.gz mPanTro3.hsa22.fa.gz mPanPan1.hsa22.fa.gz mGorGor1.hsa22.fa.gz
```

We can then validate the graph is roughly what we would expect with `gfatools`.  
Human chromosome 22 is approximately 53 Mb, so our pangenome should be slightly larger than that.  
We've also only included large structural variation in our graph, so would expect on the order of thousands of nodes/edges.

```
gfatools stat primate.gfa
```

### Visualising a pangenome

We can load our graph into `BandageNG` and visualise it.  
We can investigate regions that look interesting and broadly just get a feel for this graph.  
It is possible to zoom/pan/rotate the view with the ctrl key and mouse wheel scroll/left click/right click.

`BandageNG` also has added many incredibly useful features beyond just visualising the graph, allowing us to expand and simplify how we want to interact with the graph.  
For example, we can use the "Graph search" feature to create a `minimap2` mapping index (changing from the default `BLAST` mode) and then align sequences to the graph.  
We can do this for the *BCR* gene sequence taken from the CHM13 T2T human genome (not the HG002 human assembly we used in the graph).

We want to "Load from FASTA file", select the "BCR.hg002.fa" file provided here, add `-xasm20` to the "Command line parameters", and the click "Run Minimap2 search".  
Afterwards, we can return to the graph and 
> Change "Scope: Entire graph" to "Scope: Around query hits" in the top left
> Change "Distance: 0" to "Distance: 10" (this controls how many nodes around the feature you draw)
> Change "Random colours" to "Gray color" in the middle left
> Expand "Annotations" and then click "Minimap2 hits" and then select "Rainbow" in the bottom left

This will draw a subgraph around the *BCR* gene, and then highlight the nodes containing this gene.  
The rainbow colour goes red→green→blue→purple and can indicate the orientation of the gene.  
In this case, there appears to be a 1,511 bp deletion located within the gene present in some of the non-human primates, which could be the start of a more detailed research question.

There are also many ways to draw a subgraph around a set of nodes, around specific paths/walks, etc.  
There are also many ways to highlight/label/colour nodes by ID, from an external file, by path/walk, etc, again giving huge flexibility in how we interact with the graph.

### Prioritising regions of interest

We can identify regions of variation within the graph using `gfatools bubble primate.gfa`.  
However, there are thousands of such regions in the graph.  
We can prioritise regions to manually investigate with some basic filtering/sorting approaches.  
Here are some examples:

 - `gfatools bubble primate.gfa | sort -k4,4nr | head` prints the 10 most complex bubbles (sorting by number of nodes involved in the bubble)
 - `gfatools bubble primate.gfa | sort -k4,4n | awk '($7/$8)>0.9 | head` prints the 10 most simple bubbles where the two alleles are of a similar length (like a "multinucleotide polymorphism")
 - `gfatools bubble primate.gfa | sort -k8,8nr | head` prints the 10 longest alleles in bubbles 
 - `gfatools bubble primate.gfa | sort -k8,8nr | awk '$7==0' | head` prints the 10 longest alleles where one alternative allele is a deletion (i.e. length 0)

Further details on the meaining of each column of the output can be found [here](https://github.com/lh3/minigraph?tab=readme-ov-file#calling-structural-variations).  
Quickly querying the graph is a key step to finding interesting biology contained within an abstract graph structure.  
We can pick some regions from the above filtering/sorting steps, and the examine them in `BandageNG`, using the "Find nodes" search in the top right corner.

Two interesting examples I encountered were:
 - a 1,756 base inversion on node **s665**
 - a complex nested SV with a 100+ Kb insertion between nodes **s3925** and **s3929**

### More detailed investigations

Compared to other pangenome tools like `pggb` or `minigraph-cactus` (a much more complex pipeline that starts with `minigraph`), our graph does not contain any "path" information on which samples traversed which nodes.  
We can determine this post hoc with `minigraph --call`, by effectively realigning our samples to the pangenome and noting which nodes the sample mapped to.  
We can also do this for samples that were not actually used in building the graph, like the orangutan samples.

```
for i in hg002 mPanTro3 mGorGor1 mPanPan1 mPonPyg2 mPonAbe1
do
  minigraph -xasm --call primate.gfa ${i}.hsa22.fa.gz | tee ${i}.primate.bubble | grep -oE "(>|<)s\d+" | awk -v OFS='\t' '{N[substr($1,2)]} END {for (n in N) {print n}}'   > ${i}.primate.bed
done
```

Although both officially unsupported and known to problems, it can be increadibly useful to convert these "bubble traversals" into actual "P lines" in the gfa format.  
Different tools have different validation approaches, some of which will reject these paths because we know they are generally invalid due to missed alignments.  
However, *done is better than perfect*.

With the path infomation, we can then calculate path-based statistics from the graph, like openness, saturation, core/shell/cloud, etc.

```
curl https://raw.githubusercontent.com/lh3/minigraph/38f04593f9c9ef8b1085481d0b50040bec83de89/misc/mgutils.js > mgutils_P-line.js
{ cat primate.gfa ; paste {hg002,mPanTro3,mPanPan1,mGorGor1,mPonAbe1,mPonPyg2}.primate.bubble | k8 mgutils_P-line.js path <(echo -e "hg002#1#chr22\nmPanTro3#1#chr22\nmPanPan1#1#chr22\nmGorGor1#1#chr22\nmPonAbe1#1#chr22\nmPonPyg2#1#chr22") - ; } > primate_w_P.gfa
panacus histgrowth -o html -a -q 0.2,0.5,0.8 primate_w_P.gfa > report.html
```

## Further steps

These are several useful starting points for analysing pangenome graphs, but really is just the beginning.  
Here are several (slightly) more complex excercises to try if you have time.

### Alternative `minigraph` P-line

We added the path information into our `minigraph` pangenome using P-lines, which broadly captures the path information.  
However, that approach effectively "jumps" over unknown regions and connects two nodes which may not actually be connected in the graph.  
For some tools, this is okay, and for others it breaks (it technically **should** break).  
Instead, we can add "jump" lines (J-lines), which is part of a more recent *gfa* format version to handle these regions instead.

```
curl https://raw.githubusercontent.com/lh3/minigraph/b16d8cb129b0cc558a1b5c357d860f61e29192fe/misc/mgutils.js > mgutils_J-line.js
{ cat primate.gfa ; paste {hg002,mPanTro3,mPanPan1,mGorGor1,mPonAbe1,mPonPyg2}.primate.bubble | k8 mgutils_J-line.js path - ; } > primate_w_J.gfa
```

We can then visualise the same graph, but now with a slightly different format for the path information.

> Change "Random colours" to "Gray color" in the middle left
> Type "mGorGor" in the "Name:" box in the "Find paths" section on the top right
> Click "Find path"
> Click "Set colour" on the bottom right and select a colour

We can repeat this process for a different sample path, and then visually identify regions that are private/common between different samples.

If we identify a node representing a region of interest, we can also select that node and then click "Paths...", which will then pop up a list of all paths spanning that node.  
We can then identify which samples might carry the allele of interest, or which samples are missing from that region, etc.

`BandageNG` also plots the "J-line" itself as a dashed red line.  
You can find which nodes these might be (typically at the start and end regions) from the *.bubble files, corresponding to the "uncalled" alleles with a "." in the final column.

Unfortuantely, getting this approach to work for `BandageNG` now means this graph breaks the other tools like `panacus` and `odgi`.

### Other visualisations of the pangenome

`BandageNG` is a great interactive visualisation tool, but does not scale well to large graphs will tens or hundreds of thousands of nodes.  
`odgi` is a powerful command line tool that can let a computing cluster do the heavy workload to produce static representations of the graph.

We can do this in either "1 dimension" or "2 dimensions".  
Both allow additional layers of information to be added, including colouring by depth/orientation/consensus/etc, and be combined with other `odgi` commands to produce deeply informative figures.

```
odgi viz -i primate_w_P.gfa -o primate_w_P.odgi.1D.png
```

```
odgi layout -i primate_w_P.gfa -o primate_w_P.lay
odgi draw -i primate_w_P.gfa --coords-in primate_w_P.lay --png primate_w_P.odgi.2D.png
```

### Decomposing variants in the pangenome

If we have many samples of interest in the pangenome, we can directly assess variants contained *within* the pangenome using `vg`.  
This approach is extremely powerful to produce a *vcf* file that is commonly used downstream, but can frequently have issues with allele representation and duplicate variants.

```
vg deconstruct -P "hg002" -S -C primate_w_P.gfa | bcftools view -W -o  primate_w_P.hg002.vcf.gz
```

Typically this output would be run through postprocessing tools like `vcfbub` and `vcfwave` to handle any oddities arising from the gfa→vcf conversion.  
Even with careful curation, this is still not quite as reliable yet as linear-reference approaches and should be considered experimental.

### Aligning to the pangenome

We can download some more publicly available data, this time short read sequencing on HG002 from Element Biosciences sequencing.  
For simplicity, we'll take only the first million reads of each pair.

```
curl https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/scratch/HG002/sequencing/element/trio/HG002/ins1000/ASHG-C063_R1.fastq.gz | zcat | head -n 1000000 | bgzip -c > R1.fq.gz
curl https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/scratch/HG002/sequencing/element/trio/HG002/ins1000/ASHG-C063_R2.fastq.gz | zcat | head -n 1000000 | bgzip -c > R2.fq.gz
```

We'll create the necessary indexes for `vg` to do efficient short read alignment to a graph, and then map the reads.  
Since we only have a single chromosome pangenome, we expect many of the sequencing reads to not map to the pangenome.  
We can filter these out by exluding any alignment with "*" fields, indicating they are unmapped.

```
vg autoindex -w giraffe -g primate_w_P.gfa -r hg002.hsa22.fa.gz
vg giraffe -Z index.giraffe.gbz -d index.dist -m index.min -t 2 -f R1.fq.gz -f R2.fq.gz -o gaf | grep -v "*" > hg002.ElemBio.gaf
```

We could then investigate nodes covered in the pangenome alignments and check for consistency between the assembly and short reads (both from HG002).  
Some tools like `gafpack` exist to summarise coverage information from a pangenome, although some custom scripts are required to then visualise that coverage in `BandageNG`.