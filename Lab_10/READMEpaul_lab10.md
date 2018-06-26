Final Project
Author: Paul Maripadavil
Date Created: 8/23/17

Preparing New Lab Directories and Documentation
$ cd ~
$ mkdir -p /data/lab10/data /data/lab10/doc /data/lab10/bin /data/lab10/results /data/lab10/src
$ cd /data/lab10/doc/
$ touch READMEpaul_lab10.md

Copying the Buffalo Bash Script template.sh and preparing data files for project
$ cd /data/lab10/bin/
$ cp /data/bds-files/chapter-12-pipelines/template.sh .
$ cp /data/bds-files/chapter-11-alignment/NA12891_CEU_sample.bam .
$ wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz
$ gunzip chr1.fa.gz

Creating our Bash Script to covert bam files to fastq
and Index Reference Chromosome
$ touch fastq-create.sh
$ vi fastq-create.sh
~~~
#!/bin/bash
set -e
set -u
set -o pipefail

samtools fastq -t $1 > $1.fastq
bwa index -a bwtsw $2
~~~
$ bash fastq-create.sh NA12891_CEU_sample.bam chr1.fa &> paulbashProject.txt
[M::bam2fq_mainloop] processed 636207 reads
[bwa_index] Pack FASTA... 2.47 sec
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
[bwa_index] 222.23 seconds elapse.
[bwa_index] Update BWT... 1.79 sec
[bwa_index] Pack forward-only FASTA... 1.36 sec
[bwa_index] Construct SA from BWT and Occ... 79.08 sec
[main] Version: 0.7.15-r1140
[main] CMD: bwa index -a bwtsw chr1.fa
[main] Real time: 309.483 sec; CPU: 306.941 sec

Create Bash Script aliment tool
$ touch fastq-aliment.sh
$ vi fastq-aliment.sh

~~~
#!/bin/bash
set -e
set -u
set -o pipefail

bwa mem -R '@RG\tID:MSBI32400_test\tSM:NA12891_CEU_sample' $1 $2 > $2.sam
samtools faidx $2
samtools view -bt $3 $2.sam > $2.bam
~~~
$ bash fastq-aliment.sh chr1.fa NA12891_CEU_sample.bam.fastq chr1.fa.fai
[M::bwa_idx_load_from_disk] read 0 ALT contigs
[M::process] read 220562 sequences (10000064 bp)...
[M::process] read 220174 sequences (10000023 bp)...
[M::mem_process_seqs] Processed 220562 reads in 15.745 CPU sec, 15.810 real sec
[M::process] read 195471 sequences (8866380 bp)...
[M::mem_process_seqs] Processed 220174 reads in 16.976 CPU sec, 17.042 real sec
[M::mem_process_seqs] Processed 195471 reads in 12.622 CPU sec, 12.723 real sec
[main] Version: 0.7.15-r1140
[main] CMD: bwa mem -R @RG\tID:MSBI32400_test\tSM:NA12891_CEU_sample chr1.fa NA12891_CEU_sample.bam.fastq
[main] Real time: 46.454 sec; CPU: 45.936 sec
~~~


