for chr in {1..22} X Y MT
do
  esearch -db gene -query "Homo sapiens [ORGN]
AND $chr [CHR]" |
  efilter -query "alive [PROP] AND genetype
protein coding [PROP]" |
  efetch -format docsum |
  xtract -pattern DocumentSummary -NAME Name \
  -block GenomicInfoType -match "ChrLoc:$chr" \
  -tab "\n" -element ChrLoc,"&NAME" |
  grep '.' | sort | uniq | cut -f 1 |
  sort-uniq-count-rank
done
