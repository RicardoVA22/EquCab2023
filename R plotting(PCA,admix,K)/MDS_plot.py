import allel
import numpy as np
from sklearn.manifold import MDS
from scipy.spatial.distance import pdist, squareform
from scipy.stats import pearsonr
import matplotlib.pyplot as plt

# Set a random seed for reproducibility

np.random.seed(0)  # You can use any integer value as the seed

# Load VCF file using scikit-allel
vcf_path = "C:/Users/rackb/Desktop/data/new data 15th/ref_chr2_filt_15.vcf"
vcf_reader = allel.read_vcf(vcf_path)

# Extract genotype data (assuming diploid, bi-allelic SNPs)
genotypes = vcf_reader['calldata/GT'][:, :, 0]  # Extract the first allele from each genotype

# Take a subset of samples for analysis
subset_size = 1000  # Change this to your desired subset size
subset_indices = np.random.choice(len(genotypes), size=subset_size, replace=False)
subset_genotypes = genotypes[subset_indices]

# Calculate allele frequencies
allele_frequencies = subset_genotypes.mean(axis=1) / 2  # Calculate mean allele frequency

# Reshape allele_frequencies to a 2D array
allele_frequencies = allele_frequencies.reshape(-1, 1)

# Calculate pairwise genetic distances using pdist with a memory-efficient metric
genetic_distances = pdist(allele_frequencies, metric='euclidean')

# Convert the condensed distance matrix to a squareform matrix
genetic_distances = squareform(genetic_distances)

# Multidimensional Scaling (MDS) analysis
mds = MDS(n_components=2, dissimilarity='precomputed', normalized_stress='auto')

mds_result = mds.fit_transform(genetic_distances)

# Find the index of the sample with the highest y-coordinate (MDS Component 2)
highest_y_index = np.argmax(mds_result[:, 1])

# Find the index of the sample with the highest x-coordinate (MDS Component 1)
highest_x_index = np.argmax(mds_result[:, 0])

# Print the sample indices with the highest y and x coordinates
print("Sample with highest y-coordinate (MDS Component 2):", highest_y_index)
print("Sample with highest x-coordinate (MDS Component 1):", highest_x_index)

# Plot with enhancements
plt.figure(figsize=(10, 8))
plt.scatter(mds_result[:, 0], mds_result[:, 1], c='blue', s=30, alpha=0.7, edgecolors='none')

# Annotate points of interest
highest_x_point = mds_result[highest_x_index]
highest_y_point = mds_result[highest_y_index]
plt.annotate('Przewalski', highest_x_point, textcoords="offset points", xytext=(0,10), ha='center')

# Labels, title, and other enhancements
plt.title("Multidimensional Scaling (MDS) Plot", fontsize=16)
plt.xlabel("MDS Component 1", fontsize=14)
plt.ylabel("MDS Component 2", fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.grid(True, linestyle='--', alpha=0.7)
plt.axis('equal')  # Set aspect ratio to 'equal'

# Show the plot
plt.tight_layout()
plt.show()


