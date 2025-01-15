#!/bin/bash

#curl https://genomeark.s3.amazonaws.com/species/Symphalangus_syndactylus/mSymSyn1/assembly_curated/mSymSyn1.hap1.cur.20240514.fasta.gz > mSymSyn.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Pan_troglodytes/mPanTro3/assembly_curated/mPanTro3.hap1.cur.20231122.fasta.gz > mPanTro3.fa.gz
#curl https://genomeark.s3.amazonaws.com/species/Pongo_pygmaeus/mPonPyg2/assembly_curated/mPonPyg2.hap1.cur.20231122.fasta.gz > mPonPyg.fa.gz
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

#minigraph --ggen -c -o primate.gfa hg002.hsa22.fa.gz mPanTro3.hsa22.fa.gz mGorGor1.hsa22.fa.gz mPonPyg2.hsa22.fa.gz mPonAbe1.hsa22.fa.gz mPanPan1.hsa22.fa.gz 
