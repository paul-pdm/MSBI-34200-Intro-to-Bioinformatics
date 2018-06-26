Lab 6
Author: Paul Maripadavil
Date Created: 7/26/2017
*4 GB of RAM was allocated to VM before lab

;Creating directories for the new lab
  cd ~ ;
  mkdir -p /data/lab6/data /data/lab6/doc /data/lab6/bin /data/lab6/results /data/lab6/src ;
  cd /data/lab6/doc ;
  mv ~/Downloads/MSBI\ 32400\ LAB\ 6\ 072617.pdf . ;
  cd /data/lab6/doc
  touch READMEpaul_lab6.md
  cd /data/lab6/data

  ;Using samtools to create our fastq file from the sample bam file
  samtools fastq -t /data/bds-files/chapter-11-alignment/NA12891_CEU_sample.bam  > NA12891_CEU_sample.fastq ;
  ; [M::bam2fq_mainloop] processed 636207 reads

  ;Download the reference chromosome from the reference genome hg19
  ;and then extracted using gunzip
  wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz ;
  gunzip chr1.fa.gz

  ;First we index our reference chromosome
  bwa index -a bwtsw chr1.fa
  ;output:
  [bwa_index] Pack FASTA... 2.41 sec
  [bwa_index] Construct BWT for the packed sequence...
  [BWTIncCreate] textLength=498501242, availableWord=47075968
  [BWTIncConstructFromPacked] 10 iterations done. 76384698 characters processed.
  [BWTIncConstructFromPacked] 20 iterations done. 142334426 characters processed.
  [BWTIncConstructFromPacked] 30 iterations done. 200946714 characters processed.
  [BWTIncConstructFromPacked] 40 iterations done. 253037450 characters processed.
  [BWTIncConstructFromPacked] 50 iterations done. 299331834 characters processed.
  [BWTIncConstructFromPacked] 60 iterations done. 340474362 characters processed.
  [BWTIncConstructFromPacked] 70 iterations done. 377037946 characters processed.
  [BWTIncConstructFromPacked] 80 iterations done. 409531690 characters processed.
  [BWTIncConstructFromPacked] 90 iterations done. 438408170 characters processed.
  [BWTIncConstructFromPacked] 100 iterations done. 464069642 characters processed.
  [BWTIncConstructFromPacked] 110 iterations done. 486873562 characters processed.
  [bwt_gen] Finished constructing BWT in 116 iterations.
  [bwa_index] 209.36 seconds elapse.
  [bwa_index] Update BWT... 1.72 sec
  [bwa_index] Pack forward-only FASTA... 1.40 sec
  [bwa_index] Construct SA from BWT and Occ... 65.18 sec
  [main] Version: 0.7.15-r1140
  [main] CMD: bwa index -a bwtsw chr1.fa
  [main] Real time: 282.977 sec; CPU: 280.083 sec

  ;Now we begin the aliment of our sample fastq file with our reference chromosome
  ;and output a sam file
  bwa mem -R '@RG\tID:MSBI32400_test\tSM:NA12891_CEU_sample' chr1.fa NA12891_CEU_sample.fastq > NA12891_CEU_sample.sam
  ;output:  
    [M::bwa_idx_load_from_disk] read 0 ALT contigs
    [M::process] read 220562 sequences (10000064 bp)...
    [M::process] read 220174 sequences (10000023 bp)...
    [M::mem_process_seqs] Processed 220562 reads in 15.376 CPU sec, 15.710 real sec
    [M::process] read 195471 sequences (8866380 bp)...
    [M::mem_process_seqs] Processed 220174 reads in 15.517 CPU sec, 15.701 real sec
    [M::mem_process_seqs] Processed 195471 reads in 9.833 CPU sec, 9.934 real sec
    [main] Version: 0.7.15-r1140
    [main] CMD: bwa mem -R @RG\tID:MSBI32400_test\tSM:NA12891_CEU_sample chr1.fa NA12891_CEU_sample.fastq
    [main] Real time: 42.238 sec; CPU: 41.615 sec

 ;Now we index chromosome 1 using samtools
  time samtools faidx chr1.fa
  ;Converting SAM to BAM
  samtools view -bt chr1.fa.fai NA12891_CEU_sample.sam > NA12891_CEU_sample.bam
  samtools sort -o NA12891_CEU_sample_sorted.bam NA12891_CEU_sample.bam
  samtools index NA12891_CEU_sample_sorted.bam

 ;View header of new sorted BAM
  samtools view -H NA12891_CEU_sample_sorted.bam

 ;Looking up bcftools syntax
  bcftools

 ;Generate mpileup & run bcftools
  samtools mpileup -uf chr1.fa NA12891_CEU_sample_sorted.bam | bcftools call -mv > NA12891_CEU_sample_sorted_var.raw.vcf
  output:
    Note: none of --samples-file, --ploidy or --ploidy-file given, assuming all sites are diploid
    [mpileup] 1 samples in 1 input files
    <mpileup> Set max per-file depth to 8000
  bcftools filter -s LowQual -e '%QUAL<20' NA12891_CEU_sample_sorted_var.raw.vcf > NA12891_CEU_sample_sorted_var.flt.vcf

  Find the variants in final
  grep -v '^#' NA12891_CEU_sample_sorted_var.flt.vcf | wc -l
  ;756
  ;Find the number of variants with PASS
  grep -v '^#' NA12891_CEU_sample_sorted_var.flt.vcf | grep 'PASS' | wc -l
  :699

  ;File were ran on IGV and coordinates for exon 64
  :chr1:215,844,373
  :Amino Acid # 4692
