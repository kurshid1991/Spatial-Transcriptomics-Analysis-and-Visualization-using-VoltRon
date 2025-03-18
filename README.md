# spatial_omics_voltron
An overview of spatial omics analysis utilizing the VoltRon and Seurat R packages to explore Visium and Xenium breast cancer tumor microenvironment datasets. This topic is covered in the second module of CompGen2025, led by Artur Manukyan, focusing on advanced computational approaches for spatial transcriptomics.

For this workflow we will incorporate the VoltRon package which is an end-to-end omics analysis toolbox for spatially aware analysis and integration.

## Further Reading:
GitHub: https://github.com/BIMSBbioinfo/VoltRon

Website: https://bioinformatics.mdc-berlin.de/VoltRon/index.html

Tutorials: https://bioinformatics.mdc-berlin.de/VoltRon/tutorials.html

## Dependencies:
Below you will find a list of R package dependencies that you need to install alongside VoltRon :

#### IMPORTANT NOTE: Please install these packages first before installing VoltRon. If you either use the docker image or the rolv, you don't need to install these packages. 
- rhdf5: BiocManager::install(“rhdf5”)
- RBioFormats: BiocManager::install(“RBioFormats”) 
##### Note: RBioFormats might be hard to install due to java dependency. Check https://github.com/BIMSBbioinfo/VoltRon/tree/dev?tab=readme-ov-file#dependencies for more information.
- Seurat: install.packages("Seurat")
- spacexr: devtools::install_github("dmcable/spacexr")
- ComplexHeatmap: BiocManager::install("ComplexHeatmap")
- HDF5Array: BiocManager::install("HDF5Array")
- HDF5DataFrame: devtools::install_github("BIMSBbioinfo/HDF5DataFrame")
- ImageArray: devtools::install_github("BIMSBbioinfo/ImageArray")
- BPCells: devtools::install_github("bnprks/BPCells/r@v0.3.0")
##### Note: You may need to install BPCells before installing VoltRon
- vitessceR: devtools::install_github("vitessce/vitessceR")
- basilisk: BiocManager::install("basilisk")
- ggnewscale: install.packages("ggnewscale")
- presto: devtools::install_github('immunogenomics/presto')

## Dataset:
https://bimsbstatic.mdc-berlin.de/landthaler/VoltRon/workshop.zip


### check links below too , These will help you to understandthe data well.
- Visium (Anterior and Sagittal Brain Sections)
https://www.10xgenomics.com/datasets/mouse-brain-serial-section-1-sagittal-anterior-1-standard-1-1-0
https://www.10xgenomics.com/datasets/mouse-brain-serial-section-1-sagittal-posterior-1-standard-1-1-0

- scRNASeq (Allen Institute adult mouse brain cortical cells)
https://www.nature.com/articles/nn.4216
https://www.dropbox.com/s/cuowvm4vrf65pvq/allen_cortex.rds?dl=1

- Xenium In Situ Replicate 1 (Breast Cancer)
https://www.10xgenomics.com/products/xenium-in-situ/preview-dataset-human-breast

- Xenium Lung COVID19
https://bimsbstatic.mdc-berlin.de/landthaler/VoltRon/Multiomics/acutecase1_annotated.rds

- Visium Cytassist (Breast Cancer)
https://www.10xgenomics.com/products/xenium-in-situ/preview-dataset-human-breast

### Extra Reading:

Go through the documents provided in this repository

# contact me: 
https://www.linkedin.com/in/kurshid-basheer-85095b64/       
kurshid1991@gmail.com
