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
selected_model_specs <- c(1,15)

#
# Create target_segments_function. Script will apply over segments and use this FUN as selection criteria
#
highlight_facets_events <- function(segment){
  result <- segment[["seg.median"]] > 0.20 || segment[["seg.median"]] < -0.235
  return(result)
}
highlight_cnprep_events <- function(segment){
  result <- segment[["marginalprob"]]  < 0.01 & segment[["maxzmean"]] != 0
  return(result)
}

#
# Example 1: Use the target_segments_function to highlight aberration events
#
# See the events that CNprep calls
displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ],cluster_cols = cluster_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE,  target_segments_function = highlight_cnprep_events, target_segments_value = "seg.median", target_segments_col = "maroon")
# See the events that FACETs calls
displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ],cluster_cols = cluster_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE,  target_segments_function = highlight_facets_events, target_segments_value = "seg.median", target_segments_col = "blue")

# Example 2: Display CNprep results for organoid "hT1" for CNprep runs #1,12.
# See what cluster each segmedian is assigned to - view the cluster mean as well
displayCNprepResults(organoidId= "hT105", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = FALSE, chrom_lines = TRUE, bin_coord = FALSE)
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