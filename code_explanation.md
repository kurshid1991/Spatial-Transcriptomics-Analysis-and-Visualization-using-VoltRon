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

```r
####
## Omic Profile Clustering ####
####

####
### Processing and Filtering ####
####

# features
head(vrFeatures(bc_visium))
length(vrFeatures(bc_visium))
```
Output:
> head(vrFeatures(bc_visium))
[1] "SAMD11"  "NOC2L"   "KLHL17"  "PLEKHN1" "PERM1"   "HES4"   
> length(vrFeatures(bc_visium))
[1] 18085

- vrFeatures(bc_visium)

This function retrieves the list of features (genes) present in the dataset bc_visium. The dataset contains gene expression data from spatial transcriptomics (Visium technology). The function returns a character vector with gene names.
- head(vrFeatures(bc_visium))

This shows the first 6 gene names from the dataset:

"SAMD11"  "NOC2L"   "KLHL17"  "PLEKHN1" "PERM1"   "HES4"

### normalizeData(bc_visium)
```r
# normalize and select the top 3000 highly variable features
bc_visium <- normalizeData(bc_visium)
bc_visium <- getFeatures(bc_visium, n = 3000)
```
*Purpose:* This function normalizes the gene expression data in bc_visium. Raw gene expression counts are affected by sequencing depth and technical variations, so normalization is necessary to compare gene expression levels across spots or cells.

next, top 3000 most variable genes from the dataset are selected.

```r
# selected features
head(vrFeatureData(bc_visium))
selected_features <- getVariableFeatures(bc_visium)
head(selected_features, 20)
```
Output:
This function extracts the most variable genes from bc_visium, which are important for downstream analysis like clustering.
The output lists the top 20 most variable genes in the dataset.
| Feature   | Mean        | Variance   | Adjusted Variance | Rank  |
|-----------|------------|------------|-------------------|-------|
| SAMD11   | 1.15464744 | 3.74606535 | 3.06886024       | 5466  |
| NOC2L    | 1.71454327 | 6.06215671 | 5.85190243       | 3543  |
| KLHL17   | 0.37039263 | 0.54140333 | 0.66165246       | 10248 |
| PLEKHN1  | 0.55068109 | 1.17274648 | 1.04369994       | 8865  |
| PERM1    | 0.05288462 | 0.05570797 | 0.05640066       | 14623 |
| HES4     | 1.84475160 | 8.06785864 | 6.68690983       | 3221  |

[1]   "IGKC"      "MT-CO3"    "MT-CO2"    "MT-ND4L"   "MT-ND4"    "MT-ND2"    "MT-CYB"    "COL1A1"    "MT-ND1"    "IGHG1"     "COL3A1"

[12]   "ERBB2"     "IGHA1"     "COL1A2"    "TMSB4X"    "DCAF7"     "VMP1"      "MIEN1"     "MT-ND3"    "ACTB"  

```r
####
### Dimensionality Reduction ####
####

# embedding
bc_visium <- getPCA(bc_visium, features = selected_features, dims = 30)
bc_visium <- getUMAP(bc_visium, dims = 1:30)
vrEmbeddingNames(bc_visium)
```
Output:

[1]   "pca"    "umap"

Embedding refers to the process of representing high-dimensional data in a lower-dimensional space while preserving essential biological structures and relationships. This is particularly useful in single-cell and spatial transcriptomics, where thousands of genes are measured for each cell/spot.

Raw gene expression data contains thousands of genes, many of which are correlated or noisy. PCA transforms this data into a lower-dimensional space that preserves meaningful variation. The reduced dimensions help in clustering, visualization, and denoising.

UMAP (Uniform Manifold Approximation and Projection) is a non-linear dimensionality reduction technique used for visualization. dims = 1:30 means we use the first 30 principal components from PCA as input for UMAP.

- PCA provides linear transformations, but UMAP captures more non-linear relationships between genes.
- UMAP maps high-dimensional clusters into 2D or 3D space for better visualization.
- This step helps in identifying distinct clusters or patterns in the gene expression data.

### Visualization of embeddings:
```r
# embedding visualization
vrEmbeddingPlot(bc_visium, embedding = "umap")
vrEmbeddingPlot(bc_visium, embedding = "pca")
```
Output:

Umap embedding plot: 

<img width="504" alt="b4a476b3-d4a3-47b9-a1f2-a3e1f0440930" src="https://github.com/user-attachments/assets/ab9ff205-73c6-4402-a3c2-c3a5b6fe13f5" />

pcs embedding plot:

<img width="504" alt="ebb82500-28f5-40e8-80df-f7c2d51aca96" src="https://github.com/user-attachments/assets/1c9b3a25-0d08-4020-b28e-ff7f1d5f78d1" />



