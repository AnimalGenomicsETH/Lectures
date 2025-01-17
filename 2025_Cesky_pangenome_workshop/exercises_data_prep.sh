#!/bin/bash

#curl https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.hap1.cur.20231122.fasta.gz > mPanTro3.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Pongo_pygmaeus/mPonPyg2/assembly_curated/mPonPyg2.hap1.cur.20231122.fasta.gz > mPonPyg2.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Pongo_abelii/mPonAbe1/assembly_curated/mPonAbe1.hap1.cur.20231205.fasta.gz > mPonAbe1.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Pan_paniscus/mPanPan1/assembly_curated/mPanPan1.mat.cur.20231122.fasta.gz > mPanPan1.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Gorilla_gorilla/mGorGor1/assembly_curated/mGorGor1.mat.cur.20231122.fasta.gz > mGorGor1.fa.gz

#for i in mPanTro3 mGorGor1 mPonPyg2 mPonAbe1 mPanPan1
#do
#  samtools faidx ${i}.fa.gz
#  samtools faidx -r <(grep -E "chr23_\w+_hsa22" ${i}.fa.gz.fai | cut -f 1) $i | awk -v N="${i}#1#chr22" '/>/ {$1=">"N}1' | bgzip -c > ${i}.hsa22.fa.gz
#  samtools faidx ${i}.hsa22.fa.gz
#done

#curl https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/HG002/assemblies/hg002v1.1.fasta.gz > hg002v1.1.fa.gz
#samtools faidx hg002v1.1.fa.gz
#samtools faidx hg002v1.1.fa.gz chr22_MATERNAL | awk '/>/ {$1=">hg002#1#chr22"}1' | bgzip -c > hg002.hsa22.fa.gz
#samtools faidx hg002.hsa22.fa.gz

#minigraph -cxggs -L 100 -o primate.gfa hg002.hsa22.fa.gz mPanTro3.hsa22.fa.gz mPanPan1.hsa22.fa.gz mGorGor1.hsa22.fa.gz


gfatools stat primate.gfa

gfatools bubble primate.gfa 

#bubble 4,4 gives some complex repeat tangles
gfatools bubble primate.gfa | sort -k4,4nr

#gives simple bubble where the two alleles are similar length (i.e. MNP)
gfatools bubble primate.gfa| sort -k4,4n | awk '($7/$8)>0.9'

#finds very long alleles
gfatools bubble primate.gfa | sort -k8,8nr 

#finds long alleles but where the shortest is a deletion
gfatools bubble primate.gfa | sort -k8,8nr | awk '$7==0' | less

# interesting inversion on s665





## now look at paths

for i in hg002 mPanTro3 mGorGor1 mPanPan1 mPonPyg2 mPonAbe1
do
  minigraph -xasm --call primate.gfa ${i}.hsa22.fa.gz > ${i}.primate.bubble
  #do this for manual loading unless we can J-switch the mg utils algo
  grep -oE "(>|<)s\d+" ${i}.primate.bubble | awk -v OFS='\t' '{N[substr($1,2)]} END {for (n in N) {print n}}'   > ${i}.primate.bed
done

# this only works for some tools, technically it is an invalid path as we jump over "unknown" regions
{ cat primate.gfa ; paste *.bubble | k8 mgutils path <(echo -e "hg002\nmPanTro3\nmGorGor1\nmPanPan1\nmPonPyg2\nmPonAbe1") - ; } > primate_w_P.gfa


panacus histgrowth -o html -a -q 0.2,0.5,0.8 primate_w_P.gfa > report.html



# map BCR gene
# GorGor have insertion


#s3929 interesting bubble +10 radius

#vg deconstruct