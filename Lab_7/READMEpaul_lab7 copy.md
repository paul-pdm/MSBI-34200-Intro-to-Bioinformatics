Lab 7
Author: Paul Maripadavil
Date Created: 8/2/2017

Preparing New Lab Directories 
$ cd ~
$ mkdir -p /data/lab7/data /data/lab7/doc /data/lab7/bin /data/lab7/results /data/lab7/src
$ cd /data/lab7/doc
$ mv ~/Downloads/course_files_export.zip .

Preparing Lab Documents
$ touch READMEpaul_lab7.md
$ unzip course_files_export.zip
 
  Archive:  course_files_export.zip
   creating: Lab 7/
  inflating: Lab 7/MSBI 32400 LAB 7.pdf
$ mv Lab\ 7/MSBI\ 32400\ LAB\ 7.pdf .
Just some cleaning up
$ rm course_files_export.zip
$ rmdir Lab\ 7/

Download Test Dataset
$ cd /data/lab7/data
$ wget https://raw.githubusercontent.com/personalis/hgvslib/master/example_test_set/hgvs_test_cases.vcf

--2017-08-02 18:58:21--  https://raw.githubusercontent.com/personalis/hgvslib/master/example_test_set/hgvs_test_cases.vcf
Resolving raw.githubusercontent.com... 151.101.44.133
Connecting to raw.githubusercontent.com|151.101.44.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 11005 (11K) [text/plain]
Saving to: “hgvs_test_cases.vcf”

100%[=========================================================>] 11,005      --.-K/s   in 0.004s  

2017-08-02 18:58:21 (2.37 MB/s) - “hgvs_test_cases.vcf” saved [11005/11005]

[student@MSBI32400Lab data]$ head hgvs_test_cases.vcf 
##fileformat=VCFv4.1									
##FILTER=<ID=PASS,Description="All filters passed">
##fileDate=20150126									
##reference=hs37d5									
##pipeline_version=DVDS_v1.4.7.2
##resource_version=v1.0.8
##phasing=partial									
##source=JenniferYen									
##source=SteveChervitz - replaced RefSeq accessions w/ Genbank seq names, sorted using 'bedtools sort -i file.vcf'
##source=DeannaChurch - updated some entries and adding more non-coding variation, added IDs for easier tracking


2017-08-02 18:39:49 (1.01 MB/s) - “hgvs_test_cases.vcf” saved [70418]


Analyze with snpEff + Clinvar
$ java -Xmx4G -jar /data/snpEff/snpEff.jar eff -canon -noLog hg19 hgvs_test_cases.vcf > /data/lab7/results/hgvs_test_cases_snpEff.vcf
$ java -Xmx4G -jar /data/snpEff/SnpSift.jar annotate -noLog /data/snpEff/data/hg19/clinvar/clinvar_20170705.vcf.gz /data/lab7/results/hgvs_test_cases_snpEff.vcf > /data/lab7/results/hgvs_test_cases_snpEff.clinvar.vcf

Extract data from VCF using SnpSift
$ java -Xmx4G -jar /data/snpEff/SnpSift.jar extractFields -s ',' -e '.' /data/lab7/results/hgvs_test_cases_snpEff.clinvar.vcf CHROM POS REF ALT ID "ANN[*].ALLELE" "ANN[*].EFFECT" "ANN[*].IMPACT" "ANN[*].GENE" "ANN[*].FEATURE" "ANN[*].FEATUREID" "ANN[*].BIOTYPE" "ANN[*].RANK" "ANN[*].HGVS_C" "ANN[*].HGVS_P" CLNHGVS CLNALLE CLNACC CLNSIG CLNREVSTAT CLNDBN > /data/lab7/results/hgvs_test_cases_snpEff.clinvar.Extracted


Annonation comparsions:
Chr 1, Position: 5935162
snpEff.clinvar.Extracted-  ANN[*].HGVS_P : c.2818-2T>A
wANNOVAR- GeneDetail.refgene: NM_001291594:exon17:c.1282-2T>A
VEP.ensembl-    HGVSc	HGVSp	cDNA_position: all NA
SeattleSeqAnnotation- proteinPosition: NA   cDNAPosition: NA
                      unknownHeader: T=10841/A=2017

Chr1 Position:169519049
snpEff.clinvar.Extracted- ANN[*].HGVS_P : 0 ANN[*].HGVS_C: 0
wANNOVAR- AAChange.refgene: F5:NM_000130:exon10:c.A1601A:p.Q534Q
VEP.ensembl- Not Found
SeattleSeqAnnotation- proteinPosition: 534/2225   cDNAPosition: 1601
		      unknownHeader: C=12728/T=278


Comments: 
Not all SNPs are represented in each of the databases.  Also, they do not
share the same annotation. It looks that only Clinvar and wANNOVAR gives 
annotation that follow the nomenclature advised by the Human Genome Variation 
Society. wANNOVAR also uses some identification from Clinvar. Ensembi has columns for HGVS, but only in position and not the change of the variant. Ensembi did not have the variants for the two examples that I choose.
