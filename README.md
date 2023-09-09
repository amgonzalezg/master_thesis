# Final Master Thesis - Studying the smallest predator in the ocean using single-cell genomics 
This project delves into the genomic analysis of Minorisa minuta, a tiny bacterium with a global planktonic presence and unique status as the only heterotrophic member within Chlorarachniophytes. These are photosynthetic organisms within Rhizaria, which acquired their chloroplasts through secondary endosymbiosis with green algae. By leveraging bioinformatics tools, we extracted the genome from Single Amplified Genomes (SAGs), achieving a 74.89% genome completeness through co-assembly. This provides a solid foundation for future research, particularly in exploring nuclear genes linked to photosynthesis post-endosymbiosis.

## Structure

All the code is available in Wiki, where we found two pages: 
* [Phylogeny-18S](https://github.com/amgonzalezg/master_thesis/wiki/Phylogeny%E2%80%9018S) *
* [Minorisa‐minuta‐SAGs](https://github.com/amgonzalezg/master_thesis/wiki/Minorisa%E2%80%90minuta%E2%80%90SAGs).

All the files from Phylogeny 18S pipeline can be found at [phylogeny18S](https://github.com/amgonzalezg/master_thesis/tree/main/phylogeny18S) and scripts for SAGs pipeline can be found at [scripts](https://github.com/amgonzalezg/master_thesis/tree/main/scripts)

## Installation

### Software needed

**Phylogeny 18S pipeline**

Tools necessary to install to run the pipeline are listed below. You should install each of these programs on your computer.

* [VSEARCH](https://github.com/torognes/vsearch)
* [MAFFT](https://mafft.cbrc.jp/alignment/software/)
* [AliView](http://www.ormbunkar.se/aliview/)
* [trimAL](https://vicfero.github.io/trimal/)
* [FastTree](http://meta.microbesonline.org/fasttree/)
* [RAxML](https://cme.h-its.org/exelixis/web/software/raxml/index.html)
* [FigTree](http://tree.bio.ed.ac.uk/software/figtree/)

**SAGs pipeline**

We used a cluster called [MARBITS](https://marbits.icm.csic.es/), which is the marine bioinformatics platform of the Department of Marine Biology and Oceanography at the Institut de Ciències del Mar (Marine Sciences Institute; ICM-CSIC), Barcelona. It has a total of 396 computing cores (CPUs; 792 with hyperthreading), 4.6 T of RAM and 464 T of shared storage. To connect to MARBITS, the use of a gateway server called Salamandra was needed. All programs used were available on it, except RStudio. 
