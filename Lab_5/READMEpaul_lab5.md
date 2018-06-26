 Lab 5
 Author: Paul Maripadavil

 cd ~
 mkdir -p /data/lab5/data /data/lab5/doc /data/lab5/bin /data/lab5/result /data/lab5/src
 cd /data/lab5/doc
 history >> READMEpaul_lab5.md
 cd /home/student/Downloads
 mv 6216.23andme.4721 /data/lab5/data/
 mv course_files_export.zip /data/lab5/data
 cd /data/lab5/data
 unzipo course_files_export.zip
 ; Archive:  course_files_export.zip
 ;    creating: Lab 5/
 ;  inflating: Lab 5/MSBI 32400 LAB 5.pdf
 mv MSBI\ 32400\ LAB\ 5.pdf /data/lab5/doc
 cd /data/lab5/data/
 unzip 6216.23andme.4721
 grep -v '^#' genome_L_V_v4_Full_20170711075636.txt | wc -l
 ;610526
 less genome_L_V_v4_Full_20170711075636.txt
 ;columns of information:
 ;# rsid  chromosome      position        genotype

 cd /data/lab5/bin
 git clone git://github.com/arrogantrobot/23andme2vcf.git
 cd 23andme2vcf

 perl 23andme2vcf.pl
 perl 23andme2vcf.pl /data/lab5/data/genome_L_V_v4_Full_20170711075636.txt /data/lab5/result/genome.vcf 4 
 ;8069 sites were not included; these unmatched references can be found in sites_not_in_reference.txt.Try running again, but specify the other reference version:
./23andme2vcf.pl /data/lab5/data/genome_L_V_v4_Full_20170711075636.txt /data/lab5/result/genome.vcf 3
 cd /data/lab5/result/
 grep -v '^##' genome.vcf |grep -v '^#' | wc -l
 ;580343 
 java -Xmx2G -jar /data/snpEff/snpEff.jar
 java -Xmx2G -jar /data/snpEff/snpEff.jar eff -canon -noLog hg19 genome.vcf > genome.snpEff.vcf
 grep 'stop' genome.snpEff.vcf
 chr1	1550992	i6055051	C	A	.	.	ANN=A|stop_gained|HIGH|MIB2|MIB2|transcript|NM_080875.2|protein_coding|1/20|c.153C>A|p.Cys51*|198/3338|153/3213|51/1070||;LOF=(MIB2|MIB2|1|1.00);NMD=(MIB2|MIB2|1|1.00)	GT	0/1
chr1	12776218	rs3000860	A	C	.	.	ANN=C|stop_lost|HIGH|AADACL3|AADACL3|transcript|NM_001103170.2|protein_coding|1/4|c.39A>C|p.Ter13Cysext*?|101/4049|39/1224|13/407||	GT	0/1
chr1	21053559	i6019527	G	A	.	.	ANN=A|stop_gained|HIGH|SH2D5|SH2D5|transcript|NM_001103161.1|protein_coding|4/10|c.178C>T|p.Arg60*|680/3834|178/1272|60/423||;LOF=(SH2D5|SH2D5|1|1.00);NMD=(SH2D5|SH2D5|1|1.00)	GT	1/1
chr1	26517832	i6019571	C	T	.	.	ANN=T|stop_gained|HIGH|CATSPER4|CATSPER4|transcript|NM_198137.1|protein_coding|2/10|c.268C>T|p.Arg90*|268/1419|268/1419|90/472||,T|downstream_gene_variant|MODIFIER|CNKSR1|CNKSR1|transcript|NM_001297647.1|protein_coding||c.*1793C>T|||||1456|;LOF=(CATSPER4|CATSPER4|1|1.00);NMD=(CATSPER4
 firefox snpEff_summary.html
 ;stop_gained = 46
 ;stop_lost = 16
 ; you downloaded those two files from Clinvar and moved them to a new directory 
 cd /data/snpEff/data/hg19/
 mkdir clinvar
 cd clinvar 
 mv ~/Downloads/clinvar_20170705.vcf.gz .
 mv ~/Downloads/clinvar_20170705.vcf.gz.tbi .
 cd /data/lab5/result/ 
 java -Xmx2G -jar /data/snpEff/SnpSift.jar annotate -noLog /data/snpEff/data/hg19/clinvar/clinvar_20170705.vcf.gz genome.snpEff.vcf > genome.clinvar.snpEff.vcf

chr1    98348885        rs1801265       G       A       .       .       ANN=A|missense_variant|MODERATE|DPYD|DPYD|transcript|NM_000110.3|protein_coding|2/23|c.85C>T|p.Arg29Cys|222/4447|85/3078|29/1025||;ASP;CAF=0.2602,0.7398;CLNACC=RCV000000464.2,RCV000086506.1;CLNALLE=0,1;CLNDBN=Dihydropyrimidine_dehydrogenase_deficiency,not_provided;CLNDSDB=MedGen:OMIM,MedGen;CLNDSDBID=C2720286:274270,CN221809;CLNHGVS=NC_000001.10:g.98348885G\x3d,NC_000001.10:g.98348885G>A;CLNORIGIN=1,0;CLNREVSTAT=no_criteria,no_assertion;CLNSIG=5,1;CLNSRC=OMIM_Allelic_Variant|UniProtKB_(protein),.;CLNSRCID=612779.0004|Q12882#VAR_005173,.;COMMON=1;G5;GENEINFO=DPYD:1806;GNO;HD;INT;KGPhase1;KGPhase3;LSD;NSM;OM;PM;PMC;REF;RS=1801265;RSPOS=98348885;RV;SAO=1;SLO;SSR=0;TPA;VC=SNV;VLD;VP=0x050178080a0515053f110100;WGT=1;dbSNPBuildID=89        GT      1/1

chr1    100672060       rs12021720      T       C       .       .       ANN=C|missense_variant|MODERATE|DBT|DBT|transcript|NM_001918.3|protein_coding|9/11|c.1150A>G|p.Ser384Gly|1183/10815|1150/1449|384/482||;ASP;CAF=0.1082,0.8918;CLNACC=RCV000012727.23,RCV000116865.5;CLNALLE=0,1;CLNDBN=Intermediate_maple_syrup_urine_disease_type_2,not_specified;CLNDSDB=MedGen,MedGen;CLNDSDBID=CN069615,CN169374;CLNHGVS=NC_000001.10:g.100672060T\x3d,NC_000001.10:g.100672060T>C;CLNORIGIN=1,1;CLNREVSTAT=no_criteria,no_criteria;CLNSIG=5,255;CLNSRC=OMIM_Allelic_Variant,.;CLNSRCID=248610.0008,.;COMMON=1;G5;GENEINFO=DBT:1629;GNO;HD;KGPhase1;KGPhase3;LSD;NSM;OM;PM;PMC;REF;RS=12021720;RSPOS=100672060;SAO=1;SLO;SSR=0;VC=SNV;VLD;VP=0x050168000a0515053f110100;WGT=1;dbSNPBuildID=120      GT      1/1

chr1    156146640       rs41265017      G       A       .       .       ANN=A|missense_variant|MODERATE|SEMA4A|SEMA4A|transcript|NM_001193300.1|protein_coding|15/15|c.2138G>A|p.Arg713Gln|2392/3294|2138/2286|713/761||;ASP;CAF=0.9782,0.02177;CLNACC=RCV000003528.4|RCV000174949.2|RCV000283665.1|RCV000338889.1;CLNALLE=1;CLNDBN=Retinitis_pigmentosa_35|not_specified|Cone-Rod_Dystrophy\x2c_Recessive|Retinitis_Pigmentosa\x2c_Recessive;CLNDSDB=MedGen:OMIM|MedGen|MedGen|MedGen;CLNDSDBID=C1853214:610282|CN169374|CN239309|CN239466;CLNHGVS=NC_000001.10:g.156146640G>A;CLNORIGIN=1;CLNREVSTAT=no_criteria|mult|single|single;CLNSIG=5|2|3|3;CLNSRC=OMIM_Allelic_Variant|UniProtKB_(protein);CLNSRCID=607292.0003|Q9H3S1#VAR_028325;COMMON=1;G5;GENEINFO=SEMA4A:64218;GNO;HD;KGPhase1;KGPhase3;LSD;NSM;OM;PM;PMC;REF;RS=41265017;RSPOS=156146640;SAO=1;SLO;SSR=0;VC=SNV;VLD;VP=0x050168000a05150536110100;WGT=1;dbSNPBuildID=127        GT      0/1
 cd /data/lab5/result/
chr6    18143955        rs1800462       C       .       .       .       .       GT      0/0
 ;rs1800462 - C  *1
chr6    18130918        rs1142345       T       .       .       .       .       GT      0/0
 ;rs1142345 - T  *1
chr6    18139228        rs1800460       C       .       .       .       .       GT      0/0
 ;rs1800460 - C  *1 
chr6    18131012        rs1800584       C       .       .       .       .       GT      0/0
 ;rs1800584 - C  *1
 pandoc -r markdown -w html READMEpaul_lab5.md > READMEpaul_lab5.html
