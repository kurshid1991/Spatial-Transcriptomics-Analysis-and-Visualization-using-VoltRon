# Explanation of code
Here is an attempt to explain what is going on, and why we do what we do 😊

```r
options(java.parameters = "-Xmx8g")
library(VoltRon)
```
Voltron is JAVA dependent.

- options(java.parameters = "-Xmx8g") increases Java's maximum memory allocation to 8GB for better performance.

- library(VoltRon) loads the VoltRon package, which likely depends on Java for its functionality.

```r
####
# Visium Analysis ####
####

####
## Import Data in VoltRon ####
####

# Dependencies
if(!requireNamespace("rhdf5"))
  BiocManager::install("rhdf5")
library(rhdf5)

# import Breast Cancer Visium data
bc_visium <- importVisium("D:/Compgen2025/module2/workshop/data/BreastCancer/Visium",
                          sample_name = "bc_visium") # path to your visium folder under data
```

Now we use SampleMetadata(bc_visium), which retrieves and displays metadata associated with the bc_visium object, likely a Spatial Transcriptomics dataset analyzed using the VoltRon package.
```r
# sample metadata
SampleMetadata(bc_visium)
```
##### Breakdown of the output:
               Assay    Layer    Sample
      Assay1 Visium Section1 bc_visium1
- Assay1 → Refers to the specific assay type used (e.g., Visium, 10x Genomics).
- Visium → Indicates the spatial transcriptomics platform (10x Genomics Visium).
- Section1 → Represents the tissue section being analyzed.
- bc_visium → The sample name or object storing the dataset.

This metadata helps in organizing and processing spatial transcriptomics data for downstream analysis.

```r
View(Metadata(bc_visium))
```
Output:

| id                                  | Count | assay_id                         | Assay  | Layer  | Sample    |
|-------------------------------------|-------|----------------------------------|--------|--------|-----------|
| AACACCTACTATCGAA-1_Assay1           | 12675 | Assay1                          | Assay1 | Visium | Section1  |
| AACACGTGCATCGCAC-1_Assay1           | 7886  | Assay1                          | Assay1 | Visium | Section1  |
| AACACTTGGCAAGGAA-1_Assay1           | 32614 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGAAGAGCATAG-1_Assay1           | 7484  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGATTCATAGTT-1_Assay1           | 6694  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGCCAACGATTA-1_Assay1           | 4864  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGTTATTGCACC-1_Assay1           | 25598 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGTTCACCGAAG-1_Assay1           | 24967 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGTCAGGCTCCGC-1_Assay1           | 44387 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGTCCACGCGGTG-1_Assay1           | 27580 | Assay1                          | Assay1 | Visium | Section1  |
.
.
.
.
.
.

View(Metadata(bc_visium)) allows you to inspect the metadata in an interactive window within RStudio.

 ```r
 # features 
vrFeatures(bc_visium)
```
Output:

   [1] "SAMD11"     "NOC2L"      "KLHL17"     "PLEKHN1"    "PERM1"      "HES4"      
   [7] "ISG15"      "AGRN"       "RNF223"     "C1orf159"   "TTLL10"     "TNFRSF18"  
  [13] "TNFRSF4"    "SDF4"       "B3GALT6"    "C1QTNF12"   "UBE2J2"     "SCNN1D"    
  [19] "ACAP3"      "PUSL1"      "INTS11"     "CPTP"       "TAS1R3"     "DVL1"      
 .
 .
 .
 
  [979] "VTCN1"      "MAN1A2"     "TENT5C"     "GDAP2"      "WDR3"       "SPAG17"    
 [985] "TBX15"      "WARS2"      "HAO2"       "HSD3B2"     "HSD3B1"     "ZNF697"    
 [991] "PHGDH"      "HMGCS2"     "REG4"       "ADAM30"     "NOTCH2"     "SEC22B"    
 [997] "PPIAL4A"    "FCGR1B"     "NBPF20"     "PDZK1"     
 [ reached getOption("max.print") -- omitted 17085 entries ]

 - This command retrieves the variable (or detected) features in the bc_visium dataset.
 - The listed genes (e.g., SAMD11, NOC2L, KLHL17, etc.) represent the most variable genes in your dataset, which are often used for downstream analyses such as clustering, differential expression analysis, and visualization.
 - The large number of genes suggests that vrFeatures() has returned a selection of highly expressed or highly variable genes.
  ```r
   ####
# Images ####
####

# images and channels
vrImageChannelNames(bc_visium)
```
Output:

| Assay  | Layer  | Sample  | Spatial  | Channels |
|--------|--------|---------|----------|----------|
| Assay1 | Visium | Section1 | bc_visium | H&E |

This output tells us that:

1. The dataset is from a 10x Genomics Visium assay.
2. It is analyzing Section1 of the sample.
3. The sample is stored in bc_visium.
4. The H&E (Hematoxylin & Eosin) stained image channel is available.

```r
# get images
vrImages(bc_visium)
vrImages(bc_visium, scale.perc = 20)
vrImages(bc_visium, channel = "H&E", scale.perc = 100)
```
Output:

![visium_H E](https://github.com/user-attachments/assets/bd3fd83f-a5de-4953-b2c9-140375c76352)
