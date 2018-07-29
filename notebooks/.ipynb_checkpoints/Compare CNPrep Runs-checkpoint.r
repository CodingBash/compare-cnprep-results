
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

organoidId <- "hT1"

supplementary_values <- c("seg.median")
grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, model_specs = all_model_specs[selected_model_specs, ], supplementary_values = c("seg.median"), supplementary_cols =  supplementary_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

cluster_value = "maxzmean"
grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, model_specs = all_model_specs[selected_model_specs, ], cluster_value = cluster_value , cluster_cols = cluster_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

cluster_value = "maxzmean"
clustered_supplementary_value = "mediandev"
overlay_cluster_means = TRUE
grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, model_specs = all_model_specs[selected_model_specs, ], cluster_value = cluster_value, clustered_supplementary_value = clustered_supplementary_value, overlay_cluster_means = overlay_cluster_means, cluster_cols = cluster_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

start = 1e9
end = 2.5e9

cluster_value = "maxzmean"
clustered_supplementary_value = "mediandev"
overlay_cluster_means = TRUE
grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, start = start, end = end, model_specs = all_model_specs[selected_model_specs, ], cluster_value = cluster_value, clustered_supplementary_value = clustered_supplementary_value, overlay_cluster_means = overlay_cluster_means, cluster_cols = cluster_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

select_chrom = 3

cluster_value = "maxzmean"
clustered_supplementary_value = "mediandev"
overlay_cluster_means = TRUE
grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, select_chrom = select_chrom, model_specs = all_model_specs[selected_model_specs, ], cluster_value = cluster_value, clustered_supplementary_value = clustered_supplementary_value, overlay_cluster_means = overlay_cluster_means, cluster_cols = cluster_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

highlight_facets_events <- function(segment){
  result <- segment[["seg.median"]] > 0.20 || segment[["seg.median"]] < -0.235
  return(result)
}
highlight_cnprep_events <- function(segment){
  result <- segment[["marginalprob"]]  < 0.001 & segment[["mediandev"]] != 0
  return(result)
}

target_segments_function = highlight_cnprep_events
target_segments_value = "seg.median"
target_segments_col = "maroon"
supplementary_values = c("seg.median")

grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, model_specs = all_model_specs[selected_model_specs, ], target_segments_function = target_segments_function, target_segments_value = target_segments_value, target_segments_col = target_segments_col, supplementary_values = supplementary_values , supplementary_cols = supplementary_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)

target_segments_function = highlight_facets_events
target_segments_value = "seg.median"
target_segments_col = "maroon"
supplementary_values = c("seg.median")

grid_lines <- TRUE
chrom_lines <- TRUE
bin_coord <- FALSE

displayCNprepResults(organoidId= organoidId, model_specs = all_model_specs[selected_model_specs, ], target_segments_function = target_segments_function, target_segments_value = target_segments_value, target_segments_col = target_segments_col, supplementary_values = supplementary_values , supplementary_cols = supplementary_cols, grid_lines = grid_lines, chrom_lines = chrom_lines, bin_coord = bin_coord)
