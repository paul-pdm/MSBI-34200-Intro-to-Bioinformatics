###Installing bioinformatics software for Virtual Machine
####December 22, 2016

As ***student***:

- Installed IGV_2.3.88 in /home/student directory, and added a Launcher on /home/student/Desktop pointing to igv.sh

As ***root***:

- Installed samtools 1.3.1   
   - yum install ncurses-devel
   - yum install zlib-devel
   ./configure
   make
   make install
   
- Installed htslib 1.3.2
   - bunzip2 htslib-1.3.2.tar.bz2 
   - tar -xvf htslib-1.3.2.tar 
   - cd htslib-1.3.2
   - ./configure
   - make
   - make install
   
- Installing bcftools 1.3.1
   - tar -xvf bcftools-1.3.1.tar 
   - cd bcftools-1.3.1
   - less INSTALL (no configure needed)
   - make install
   
- Installing bwa 0.7.15
   - bunzip2 bwa-0.7.15.tar.bz2 
   - tar -xvf bwa-0.7.15.tar 
   - cd bwa-0.7.15
   - less README.md
   - make
   - cp bwa /usr/local/bin

- Installing Pandoc
   - wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
   - rpm -ivh epel-release-6-8.noarch.rpm
   - yum install pandoc
   - vi README.md
   - `pandoc -r markdown -w html README.md > README.html`
   - firefox README.html

- Installing R 3.3.2
   - yum install R --nogpgcheck (from epel)
  
####Documenting everything

   - history > README_install_notes.md

---

####Installing Bioinformatics Data Skills files

- As ***root***, created /data folder and grant rights to student user

- As ***student***, `cd /data`

- Download all files for each chapter from GitHub:  `git clone https://github.com/vsbuffalo/bds-files.git`

   - Noticed the sample BAM file was missing an index file, so `samtools index bds-files/chapter-11-alignment/NA12891_CEU_sample.bam`

- Opened sample BAM and VCF file in IGV and save as XML file as /home/student/igv_session.xml

   - Launch IGV from Desktop, then Open Session and choose igv_session.xml to view preselected area

---

####Installing custom annotation tools

As ***student***

- Download snpEff_v4_3i_core.zip from https://sourceforge.net/projects/snpeff/

- Install in /data/snpEff by running `unzip ~/Downloads/snpEff_latest_core.zip`

- Use `java -jar snpEff.jar download hg19` to download RefSeq annotation.

   - Stack heap error, so download v4_3 hg19 database directly from SourceForge and unpack into /data/snpEff/data/hg19

- Install BLAST+ from NCBI via `ftp ftp.ncbi.nlm.nih.gov` and following instructions at https://www.ncbi.nlm.nih.gov/books/NBK52640/#_chapter1_Installation_

   - From /data `tar -zxvf ~/Downloads/ncbi-blast-2.5.0+-x64-linux.tar.gz`

####Installing Python 3.3 in /usr/local/bin

As ***root***

- Followed instructions from http://toomuchdata.com/2014/02/16/how-to-install-python-on-centos/

   - wget https://bootstrap.pypa.io/ez_setup.py

- Install as ***root*** in /data/BioPython virtualenv

- Installed ez_setup.py, then installed pip.  Used pip to install biopython, numpy, matplot lib etc. as ***root***:

~~~
biopython (1.68)
cycler (0.10.0)
matplotlib (1.5.3)
numpy (1.11.3)
pip (9.0.1)
pyparsing (2.1.10)
python-dateutil (2.6.0)
pytz (2016.10)
setuptools (32.2.0)
six (1.10.0)
~~~

---

__Larry Helseth, December 22, 2016__

