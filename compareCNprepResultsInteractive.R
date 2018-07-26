#
# Load sources
#
setwd("~/Git-Projects/Git-Research-Projects/compare-cnprep-results/") # Set working directory to where the scripts are located at
source("compareCNprepResultsLibrary.R") # Import visualization library
library(RColorBrewer) # Import brewer for coloring

#
# Set colors
#
cluster_cols <- brewer.pal(n = 7, name="Dark2") # Set colors for clusters. Let n > 5
supplementary_cols <- brewer.pal(n = 7, name="Set2") # Set colors for suppl. Let n >= number of suppl values

#
# See available CNprep runs
#
print(all_model_specs)

#
# Select the CNprep specs to compare with
#
selected_model_specs <- c(1,12)

# Example 1: Display CNprep results for organoid "hT1" for CNprep runs #1,12.
# See what cluster each segmedian is assigned to - view the cluster mean as well
displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

# Display in specific range (make sure range is consistent with x units selected)
displayCNprepResults(organoidId= "hT1", start = 1000000000, end = 2500000000, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

# Display in specific chromosome
displayCNprepResults(organoidId= "hT1",select_chrom = 8, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

# Display original with no layout lines
displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = FALSE)

# Display in bin units
displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = TRUE)

# Display within bin range
displayCNprepResults(organoidId= "hT1", start = 20000, end = 60000, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = TRUE)
