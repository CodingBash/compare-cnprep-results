
#
# Load sources
#
setwd("~/Documents/Git-Projects/Git-Research-Projects/compare-cnprep-results/") # Set working directory to where the scripts are located at
source("compareCNprepResultsLibrary.R") # Import visualization library
library(RColorBrewer) # Import brewer for coloring
library(repr)

cluster_cols <- brewer.pal(n = 7, name="Dark2") # Set colors for clusters. Let n > 5
supplementary_cols <- brewer.pal(n = 7, name="Set2") # Set colors for suppl. Let n >= number of suppl values

options(repr.plot.width=15, repr.plot.height=7)
options(warn=-1)


print(all_model_specs)

selected_model_specs <- c(1,15)
print(all_model_specs[selected_model_specs,])

highlight_facets_events <- function(segment){
  result <- segment[["seg.median"]] > 0.20 || segment[["seg.median"]] < -0.235
  return(result)
}
highlight_cnprep_events <- function(segment){
  result <- segment[["marginalprob"]]  < 0.001 & segment[["mediandev"]] != 0
  return(result)
}

displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ],cluster_cols = cluster_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE,  target_segments_function = highlight_cnprep_events, target_segments_value = "seg.median", target_segments_col = "maroon", supplementary_values = c("seg.median"), supplementary_cols = supplementary_cols)

displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ],cluster_cols = cluster_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE,  target_segments_function = highlight_facets_events, target_segments_value = "seg.median", target_segments_col = "maroon", supplementary_values = c("seg.median"), supplementary_cols = supplementary_cols)

displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

displayCNprepResults(organoidId= "hT1", start = 1000000000, end = 2500000000, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

displayCNprepResults(organoidId= "hT1",select_chrom = 8, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, grid_lines = TRUE, chrom_lines = TRUE, bin_coord = FALSE)

displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = FALSE)

displayCNprepResults(organoidId= "hT1", model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = TRUE)

displayCNprepResults(organoidId= "hT1", start = 20000, end = 60000, model_specs = all_model_specs[selected_model_specs, ], cluster_value = "maxzmean", clustered_supplementary_value = "mediandev", overlay_cluster_means = TRUE, cluster_cols = cluster_cols, supplementary_cols =  supplementary_cols, bin_coord = TRUE)
