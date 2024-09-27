# The Construction of Reference Gene and Genome Catalogs of Chinese Liquor

The pipeline for constructing the Moutai Microbiome Catalog is provided in the following figure:

![image](https://github.com/user-attachments/assets/87fd53c9-c70f-4fb0-8039-84fdd4ade6c7)
**Schematic for constructing the Moutai microbiome catalog and the key results.** (A) Taxonomic structure analysis of the fermented grain microbiome. This module includes biomarker analysis, network analysis, community assembly process, and Mantel test analysis. (B) Functional and taxonomic annotation for the gene catalog. The number and percentage of genes were calculated by annotations analyses against the mainstream functional databases (Swiss-Prot, UniRef50, TrEMBL, eggNOG, KEGG, COG, GO, EC, CAZy, and CARD). (C) Genome profile and biosynthetic gene clusters (BGCs) as examined by the analytical pipeline. This module includes BGC prediction and annotation, the species-level clustering of MAGs, and the taxonomical and functional annotation for MAGs. In the whole figure, the green rectangles show the main results, the blue parallelograms represent the analytic procedures, and the software applied for each analytic procedure is shown in purple text. Yellow cylinders represent the databases used for MTFGC analysis.

## Software 
The name, version, and availability of the software for constructing the Moutai Microbiome Catalog are provided as below:

| **reagent or resources**    | **version**                | **identifier**                                        | **source**                                         |
|:-----------------------:|:----------------------:|:-------------------------------------------------:|:----------------------------------------------:|
| **software and algorithms** |                        |                                                   |                                                |
| Trimmomatic             | v0.38                  | https://github.com/usadellab/trimmomatic          | https://doi.org/10.1093/bioinformatics/btu170  |
| MetaPhlAn2              | v2.6.0                 | https://github.com/biobakery/metaphlan2           | https://doi.org/10.1038/nmeth.3589             |
| MEGAHIT                 | v1.1.2                 | https://github.com/voutcn/megahit                 | https://doi.org/10.1093/bioinformatics/btv033  |
| FastNC2                 | v2                     | https://github.com/wqssf102/fastnc2               | https://doi.org/10.1073/pnas.202532111         |
| QUAST                   | v5.0.2                 | https://github.com/ablab/quast                    | https://doi.org/10.1093/bioinformatics/btt086  |
| MetaWRAP                | v1.2.2                 | https://github.com/bxlab/metawrap                 | https://doi.org/10.1186/s40168-018-0541-1      |
| CheckM                  | v1.0.18                | https://github.com/tribe29/checkmk                | https://doi.org/10.1101/gr.186072.114          |
| Prodigal                | v2.6.3                 | https://github.com/hyattpd/prodigal               | https://doi.org/10.1186/1471-2105-11-119       |
| Prokka                  | v1.14.5                | https://github.com/tseemann/prokka                | https://doi.org/10.1093/bioinformatics/btu153  |
| MMseqs2                 | v4.8.1                 | https://github.com/soedinglab/mmseqs2             | https://doi.org/10.1093/bioinformatics/btq003  |
| KofamScan               | v1.3.0                 | https://github.com/rotheconrad/keggdecoder-binder | https://doi.org/10.1093/bioinformatics/btz859  |
| DIAMOND                 | v2.0.14.152            | https://github.com/python-diamond/diamond         | https://doi.org/10.1038/nmeth.3176             |
| DeepARG                 | v1.0.2                 | https://github.com/deeparg/deeparg                | https://doi.org/10.1186/s40168-018-0401-z      |
| eggNOG-mapper           | v2.1.6                 | https://github.com/eggnogdb/eggnog-mapper         | https://doi.org/10.1093/molbev/msab293         |
| antiSMASH               | v6.0.0                 | https://github.com/antismash/antismash            | https://doi.org/10.1093/nar/gkab335            |
| BiG-SCAPE              | v1.1.5                 | https://github.com/medema-group/big-scape         | https://doi.org/10.1038/s41589-019-0400-9      |
| dRep                    | v3.4.0                 | https://github.com/mrolm/drep                     | https://doi.org/10.1038/ismej.2017.126         |
| GTDB-tk                 | v2.1.1                 | https://gtdb.ecogenomic.org/downloads             | https://doi.org/10.1093/bioinformatics/btac672 |
| Rosetta2                | v2.0                   | https://github.com/h33p/docker-rosetta2           | https://doi.org/10.1006/jmbi.1997.0959         |


## Database

The name, description, and availability of the databases for constructing the Moutai Microbiome Catalog are provided as below:

| **Databases**           | **Identifier**                                    | **Source**                                     |
|:-----------------------:|:-------------------------------------------------:|:----------------------------------------------:|
| eggNOG                  | http://eggnog5.embl.de/#/app/downloads            | https://doi.org/10.1093/nar/gky1085            |
| KEGG                    | http://kobas.cbi.pku.edu.cn/kobas3/download/      | https://doi.org/10.1093/nar/gkaa970            |
| COG                     | http://www.ncbi.nlm.nih.gov/cog/                  | http://oi.org/10.1093/nar/gkaa1018             |
| GO                      | http://geneontology.org/                          | http://oi.org/10.1093/nar/gky1055              |
| CAZyDB                  | http://www.cazy.org/                              | https://doi.org/10.1093/nar/gkn663             |
| EC                      | https://enzyme.expasy.org/index.html              | http://oi.org/10.1093/nar/28.1.304             |
| CARD                    | https://card.mcmaster.ca/download                 | https://doi.org/10.1093/nar/gkz935             |
| GTDB                    | https://gtdb.ecogenomic.org/downloads             | https://doi.org/10.1093/bioinformatics/btac672 |
| Swiss-Prot              | https://www.uniprot.org/                          | https://doi.org/10.1093/nar/gkac1052           |
| TrEMBL                  | https://www.uniprot.org/                          | https://doi.org/10.1093/nar/gkac1052           |
| UniRef50                | https://www.uniprot.org/                          | https://doi.org/10.1093/bioinformatics/btm098  |
| Pfam                    | http://pfam-legacy.xfam.org/                      | https://doi.org/10.1093/nar/gkaa913            |


## Data availability

The raw metagenomic data could be assessed at the GSA database (https://ngdc.cncb.ac.cn/gsub/) with ProjectID: [PRJCA018633](https://ngdc.cncb.ac.cn/gsub/submit/bioproject/subPRO027666/overview) for fermented grain samples and [PRJCA018634](https://ngdc.cncb.ac.cn/gsub/submit/bioproject/subPRO027667/overview) for starter samples.
The data used for constructing MTFGC could be assessed in the National Genomics Data Center (NGDC) database (https://ngdc.cncb.ac.cn/) with BioProject ID: PRJCA018633. The raw data of MTFGC could be assessed with accession ID: [CRA014449](https://ngdc.cncb.ac.cn/gsa/browse/CRA014449) and [CRA012433](https://ngdc.cncb.ac.cn/gsa/s/78i4CpbH) for raw data, [GWHERCQ00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/MwurLYcaCyNIidtFQxFPbtNyEBlylGBAcufNmWKwaeBxbQClRdkByKQWAyelhHUQ) and [GWHERDV00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/FdCXkApAOxjuxPsBbDDaPOuuPzEXoqtLuTNkvNoZgSfXLjnKTMEfLJzcNfataCRm) for MAGs (MTFGC-Genome), as well as [GWHERDA00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/CftXilRTWqtgESQUjHMUXRJhwWSOivnSoADqxYZSZCsfOCVtKIfUOjGoLIEVQPDR) and [GWHERDZ00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/fzBWcHAevOONaiNaHyyNdHHqiETUKGjGNTrmAcgFqPxxxZMDdfjrACyufeKRLCLq) for nonredundant genes (MTFGC-Gene). The data used for constructing MTC could be assessed in the NGDC database with BioProject ID: PRJCA018633 and PRJCA018634. The raw data of MTC could be assessed with accession ID: [CRA012433](https://ngdc.cncb.ac.cn/gsa/s/78i4CpbH) and [CRA012434](https://ngdc.cncb.ac.cn/gsa/s/78i4CpbH) for raw data, [GWHERDW00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/XIdizhitcQKZlMYMFoFMlhkLGcHRECGHlNriMMHLsHRbUWZsUxUNJCtMZhoIYUDD) for MAGs (MTC-Genome), and [GWHERDX00000000](https://ngdc.cncb.ac.cn/gwh/Assembly/reviewer/veJRgCnYJQxnzPpzOJrLveBleaxQEGocwUKyuAIeWFptJtcRXckrknJIklLXfWjk) for nonredundant genes (MTC-Gene). 

For more details, please refer to https://github.com/zhuxue1002/Moutai-Catalog/tree/main
