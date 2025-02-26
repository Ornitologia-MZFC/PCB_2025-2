https://www.cd-genomics.com/factsheet-of-reduced-representation-sequencing-methods-advantages-applications-and-strategies.html

What is Reduced-Representation Sequencing, RRS?

Reduced-representation sequencing (RRS), is an approach to generate genome-wide high-throughput sequencing data and obtain a large number of genetic polymorphism tag sequences to fully represent the whole genome information of the species. RRS not only simplifies the sequencing method, given only the digested fragments are sequenced, it also simplifies the sequenced genome. Therefore, it is widely used in molecular marker development, population genetic analysis, genetic map construction, QTL mapping, genome-wide association analysis and other population research and molecular breeding fields.
Introduction of methods used for RRS

There are several different methods of RRS, including GBS, ddGBS, RAD, 2bRAD, ddRAD, SALF, etc. The principles of these methods are basically the same, differences lie in whether single or double restriction enzymes used, random breaks needed, barcode required, special kit required, design of adaptor and other details. The detailed introduction of these methods is as follows:
RAD: This method performs single digestion of the whole genome DNA, then randomly interrupts the digested fragments. Therefore, read1 obtained by sequencing is aligned in position, while read2 is uneven, so longer Contig can be clustered and spliced by de novo, which is beneficial to the development of SSR molecular markers.
GBS: This method performs single digestion of genomic DNA without ultrasonic random interruption. Instead, PCR is used for fragment size selection, and different samples are added with different barcodes, which can pool up to 96 samples. It simplifies the steps of building a library, so the cost is lower than RAD.
2bRAD: This method uses type IIB restriction enzyme for digestion. Type IIB restriction enzyme can cut segments of genomic DNA upstream and downstream of the restriction site to obtain fixed-length fragments with smaller size of only 33-36bp.
ddGBS: This method is an improvement of GBS. The genomic DNA is digested with two restriction enzyme, which can obtain more evenly distributed digested fragments in the genome.
ddRAD: This method is basically the same method as ddGBS, the difference lies the pooling number selected when library construction. The process of ddRAD is more similar to the classic GBS. This method uses two restriction enzyme for genomic DNA cut off to obtain more uniform fragments in the whole genome, and use electrophoresis to select fragment size.
SLAF: This method is an optimized version of ddRAD, the enzymes and the sizes of the restriction fragments are optimized with training data to ensure even distribution and avoid repeats. The fragments are also selected over a tight range, to optimize the PCR reaction. The protocol is similar to ddRAD, for example with a first digestion with MseI, heat inactivation and a second digestion with AluI. The resulting fragments are PCR amplified, adaptors added and the fragments purified.

Advantages of RRS

    Only the digested fragments are sequenced, which greatly reduces the complexity of the genome
    Not limited by the reference genome, also applicable to species without reference
    Cost effective, high stability, especially suitable for the analysis of a large number of samples
    Wide range of applications: population genetics, genetic mapping, QTL mapping, genome-wide association analysis, molecular breeding, etc.

Comparison of different methods used by RRS

The detail differences in methods used by RRS determine their differences in application. In the following table, different RRS methods are compared: (see table 1)
Application of RRS

    Development of molecular markers: identification of individual SNPs/InDel markers, integration of population SNPs markers; calculation of genetic linkage distance of polymorphic markers, constructing high-density genetic maps, and performing association analysis for particular traits, performing fine mapping of downstream genes.
    Genetic map construction and QTL mapping: differentiation of linkage groups, ranking of massive markers, screening of biased segregation sites; QTL mapping based on phenotypic data.
    Population genetic evolution: population genetic level analysis based on SNPs data, including population evolution analysis, population structure analysis, gene flow, pedigree testing, PCA analysis, etc.
    Assist in the assembly of de novo detailed genome map: assembly of draft genome, gene annotation, etc.
    Genome-wide association analysis (GWAS): Sequencing and whole-genome association analysis for a certain species population, and screening of genome-related regulatory sites for specific traits.

Strategy of selection in RRS methods

    Purpose of the study:

    Based on different experimental purposes, the number of markers required is completely different. For study which is necessary to carry out research on functional interval scanning and functional gene mining in the whole genome, such as GWAS and selection pressure analysis requires tens of thousands of high-density molecules. However, the density of molecular markers for studies on phylogenetic relationships, linkage analysis, geographic population structure, gene flow, and pedigree testing does not need to be so high, generally only a few hundred to a few thousand molecular markers are enough to complete. For gene mapping studies, different research materials and mapping populations will also affect the number of markers needed. For example, the number of markers required for genome-wide association analysis using natural populations is related to the LD decay distance of the species, the faster, the more marks are required.

    The number of markers ranked by: RAD≥GBS/SLAF>2b-RAD, so the number of markers required for the study can be evaluated first, and then the appropriate simplified genome sequencing technology can be selected.
    With or without reference genome:

    If the research species has no reference genome or the assembly quality of the reference genome is poor, RAD technology may be used more, because RAD technology can obtain fragments up to 400~500bp through partial assembly, which is conducive to the development of SSR molecular markers and subsequent primer design; GBS/SLAF can also use clustering methods to construct consensus sequences to detect SNPs; 2b-RAD is susceptible to interference by repetitive sequences due to its short fragments, and it is not conducive to design primers to verify the SNPs obtained by sequencing. Therefore, 2b-RAD usually requires a reference genome.
    Selection of restriction enzymes:

    The choice of enzyme is determined by the requirement of marker density. The selected enzyme should be suitable for the species being studied (for example, consider the number enzyme in the repetitive regions of the species); some enzymes are suitable for certain species, but not necessarily suitable for other species; enzyme digestion fragments usually have sticky ends, and different sticky ends may require different adaptor designs.
    DNA sample preparation:

    Considering the digestion efficiency of enzymes, high-quality DNA samples are critical to the entire process; in addition, different methods also require DNA sample volume.
