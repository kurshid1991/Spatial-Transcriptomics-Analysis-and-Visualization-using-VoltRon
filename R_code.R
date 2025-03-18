options(java.parameters = "-Xmx8g")
library(VoltRon)

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

# sample metadata
SampleMetadata(bc_visium)

# metadata
Metadata(bc_visium)
View(Metadata(bc_visium))


# features 
vrFeatures(bc_visium)

####
# Images ####
####

# images and channels
vrImageChannelNames(bc_visium)

# get images
vrImages(bc_visium)
vrImages(bc_visium, scale.perc = 20)
vrImages(bc_visium, channel = "H&E", scale.perc = 100)

####
## Omic Profile Clustering ####
####

####
### Processing and Filtering ####
####

# features
head(vrFeatures(bc_visium))
length(vrFeatures(bc_visium))

# normalize and select the top 3000 highly variable features
bc_visium <- normalizeData(bc_visium)
bc_visium <- getFeatures(bc_visium, n = 3000)

# selected features
head(vrFeatureData(bc_visium))
selected_features <- getVariableFeatures(bc_visium)
head(selected_features, 20)

####
### Dimensionality Reduction ####
####

# embedding
bc_visium <- getPCA(bc_visium, features = selected_features, dims = 30)
bc_visium <- getUMAP(bc_visium, dims = 1:30)
vrEmbeddingNames(bc_visium)

# embedding visualization
vrEmbeddingPlot(bc_visium, embedding = "umap")
vrEmbeddingPlot(bc_visium, embedding = "pca")

####
### Clustering ####
####

# Clustering of the Visium spots

# graph for neighbors
bc_visium <- getProfileNeighbors(bc_visium, dims = 1:30, k = 10, method = "SNN")
vrGraphNames(bc_visium)

# clustering
bc_visium <- getClusters(bc_visium, resolution = 0.5, label = "Clusters", graph = "SNN")

####
### Visualization ####
####

# embedding (UMAP)
vrEmbeddingPlot(bc_visium, embedding = "umap", group.by = "Clusters")
vrSpatialPlot(bc_visium, group.by = "Clusters", plot.segments = TRUE)
vrSpatialPlot(bc_visium, group.by = "Clusters", plot.segments = TRUE, alpha = 0.5)

# embedding (PCA)
vrEmbeddingPlot(bc_visium, embedding = "pca", group.by = "Clusters")
vrSpatialPlot(bc_visium, group.by = "Clusters", plot.segments = TRUE)
vrSpatialPlot(bc_visium, group.by = "Clusters", plot.segments = TRUE, alpha = 0.5)
