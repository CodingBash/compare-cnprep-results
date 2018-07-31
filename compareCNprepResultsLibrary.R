#
# Create dataframe of available CNprep runs
#
all_model_specs <- data.frame(stringsAsFactors = FALSE)
cnprep_run <- list()
cnprep_run[[1]] <- data.frame(dir="prev_run1", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[2]] <- data.frame(dir="prev_run3", model="V", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[3]] <- data.frame(dir="prev_run_7_15_2018_14", model="E", minjoin=0.25, ntrial = 40, stringsAsFactors = FALSE)
cnprep_run[[4]] <- data.frame(dir="prev_run_7_15_2018_15", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[5]] <- data.frame(dir="prev_run_7_15_2018_16", model="V", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[6]] <- data.frame(dir="prev_run_7_15_2018_17", model="E", minjoin=0.01, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[7]] <- data.frame(dir="prev_run_7_15_2018_18", model="V", minjoin=0.01, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[8]] <- data.frame(dir="prev_run_7_15_2018_19", model="E", minjoin=0.01, ntrial = 50, stringsAsFactors = FALSE)
cnprep_run[[9]] <- data.frame(dir="prev_run_7_15_2018_18", model="V", minjoin=0.01, ntrial = 50, stringsAsFactors = FALSE)
cnprep_run[[10]] <- data.frame(dir="prev_run_7_15_2018_18", model="V", minjoin=0.01, ntrial = 50, stringsAsFactors = FALSE)
cnprep_run[[11]] <- data.frame(dir="prev_run_7_19_2018_1", model="E", minjoin=0.50, ntrial = 40, stringsAsFactors = FALSE)
cnprep_run[[12]] <- data.frame(dir="prev_run_7_19_2018_2", model="E", minjoin=1.00, ntrial = 40, stringsAsFactors = FALSE)
cnprep_run[[13]] <- data.frame(dir="prev_run_7_19_2018_3", model="V", minjoin=1.00, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[14]] <- data.frame(dir="prev_run_7_27_2018_3", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[15]] <- data.frame(dir="prev_run_7_27_2018_4", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[16]] <- data.frame(dir="prev_run_7_27_2018_8", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[17]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_1", model="E", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[18]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_2", model="E", minjoin=0.50, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[19]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_3", model="E", minjoin=1.00, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[20]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_4", model="V", minjoin=0.25, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[21]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_5", model="V", minjoin=0.50, ntrial = 10, stringsAsFactors = FALSE)
cnprep_run[[22]] <- data.frame(dir="cnvkit_prev_run_7_30_2018_6", model="V", minjoin=1.00, ntrial = 10, stringsAsFactors = FALSE)
all_model_specs <- do.call(rbind, cnprep_run)

#
# Retrieve the segtable from the CNprep::CNpreprocessing output
#
retrieveSegtable <- function(sample, dir = "segClusteringResults/"){
  segtable <- read.table(paste(dir, sample, "_segtable.tsv", sep = ""), sep = "\t", header = TRUE)
  return(segtable)
}

#
# Method to display and compare CNprep results
#
# @param("organoidId") - string of the organoid sample
# @param("select_chrom") - chromosome to view segments within (overrides @param(start) and @param(end))
# @param("start") - start of the x-axis (in unit defined by @param(bin_coord))
# @param("end") - end of the x-axis (in unit defined by @param(bin_coord))
# @param("model_specs") - list of CNprep runs to compare
# @param("cluster_value") - value of the segtable column with the cluster values
# @param("clustered_supplementary_value") - segtable column to display with segments color coded based on cluster assignment
# @param("overlay_cluster_means") - if @param("clustered_supplementary_value") is supplied, @param("cluster_value") will not be displayed unless @param("overlay_cluster_means") is TRUE
# @param("supplementary_values") - values of the segtable columns with any supplementary data to overlay
# @param("cluster_cols") - color palette for each cluster
# @param("supplementary_cols") - color palette for each supplementary data
# @param("grid_lines") - boolean declaring if plot horizontal lines should appear
# @param("chrom_lines") - boolean declaring if plot vertical lines for chromosome boundaries should appear
# @param("bin_coord") - boolean determine unit (TRUE if bin, FALSE if abs bp)
# TODO: Have description of target arguments
displayCNprepResults <- function(organoidId, select_chrom, start, end, model_specs, cluster_value = "maxzmean", clustered_supplementary_value, overlay_cluster_means = FALSE, supplementary_values, cluster_cols, supplementary_cols, grid_lines = FALSE, chrom_lines = TRUE, bin_coord = TRUE, target_segments_function, target_segments_value, target_segments_col, yrange_trim = 0.0){
  #
  # Set coordinate unit
  #
  start_col <- if(bin_coord == TRUE) "start" else "abs.pos.start"
  end_col <- if(bin_coord == TRUE) "end" else "abs.pos.end"
  
  
  
  #
  # Set plot parameters
  #
  layout(matrix(seq(1, nrow(model_specs) * 2), nrow(model_specs), 2, byrow = TRUE), 
         widths=c(4,1))
  par(mar=c(2,2,1.25,0))
  
  #
  # Retrieve list of all CNprep segtables (accounting for bin range)
  #
  all_segtables <- lapply(seq(1, nrow(model_specs)), function(model_specs.index, select_chrom, start, end){
    # TODO: segtable dir should be a parameter
    segtable <- retrieveSegtable(organoidId, dir = paste0("segClusteringResults/", model_specs[model_specs.index, ]$dir, "/"))
    #
    # If selected chrom is provided, determine the start and end range
    #
    if(!missing(select_chrom)){
      chrom_start_coordinates <- segtable[segtable$chrom == as.character(select_chrom), ][[start_col]]
      chrom_end_coordinates <- segtable[segtable$chrom == as.character(select_chrom), ][[end_col]]
      start <- min(chrom_start_coordinates)
      end <- max(chrom_end_coordinates)
    }
    
    #
    # Select segtables observations based on provided start/end range
    #
    if(!missing(start) & !missing(end)){
      segtable <- segtable[segtable[[start_col]] >= start & segtable[[end_col]] <= end,]  
    } else if (!missing(start)){
      segtable <- segtable[segtable[[start_col]] >= start,]  
    } else if (!missing(end)) {
      segtable <- segtable[segtable[[end_col]] <= end,]  
    }
    return(segtable)
  }, select_chrom, start, end)
  
  #
  # Ensure all segtables have same columns so that they can be rbinded together
  #
  all_colnames <- lapply(all_segtables, function(segtable) colnames(segtable))
  common_colnames <- Reduce(intersect, all_colnames)
  all_segtables <- lapply(all_segtables, function(segtable) segtable[,common_colnames])
 
  #
  # Generate dataframe with all CNprep segtables
  #
  binded_segtables <- do.call(rbind, all_segtables)
  
  #
  # Determine plot ranges
  #
  values <- list()
  if(!missing(cluster_value) & (missing(clustered_supplementary_value) | overlay_cluster_means == TRUE)){
    values <- c(values, cluster_value)
  }
  if(!missing(clustered_supplementary_value)){
    values <- c(values, clustered_supplementary_value)
  }
  if(!missing(supplementary_values)){
    values <- c(values, supplementary_values)
  }
  
  ymargin <- 0.1
  yplot <- 0.5
  yvalues <- sapply(values, function(value){binded_segtables[[value]]})
  
  #
  # Add target/selected segments to yvalue to calculate appropriate yrange
  #
  if(!missing(target_segments_function) & !missing(target_segments_value) & !missing(target_segments_col)){
    segtable_as_list <- split(binded_segtables, seq(nrow(binded_segtables)))
    selected_segtable <- binded_segtables[sapply(segtable_as_list, target_segments_function),]
    yvalues <- unlist(c(yvalues, selected_segtable[[target_segments_value]]))
  }
 
  #
  # Trim yvalues
  #
  yvalues <- sort(yvalues)
  yvalues <- yvalues[seq(yrange_trim*length(yvalues) + 1, (1-yrange_trim)*length(yvalues))]  
  
  xrange <- range(binded_segtables[[start_col]],binded_segtables[[end_col]])
  yrange <- range(yvalues - ymargin, yvalues + ymargin)
  
  #
  # Iterate through each CNprep segtable
  #
  for(segtable.i in seq_along(all_segtables)){
    #
    # Store necessary data information
    #
    segtable <- all_segtables[[segtable.i]]
    model_spec <- model_specs[segtable.i, ]
    #
    # Set plot information
    #
    as.list(model_spec)
    title <- paste0("organoidId=", organoidId, " dir=", model_spec$dir, " model=", model_spec$model, " minjoin=", model_spec$minjoin, " ntrial=", model_spec$ntrial)
    plot(xrange, yrange, main = title, type="n", xlab = "", ylab = "")
    legend_values <- c()
    legend_col <- c()
    
    #
    # Display supplementary value segments
    #
    if(!missing(supplementary_values)){
      for(supplementary_value.index in seq_along(supplementary_values)){
        segments(x0 = segtable[[start_col]], x1 = segtable[[end_col]], y0 = segtable[[supplementary_values[[supplementary_value.index]]]], y1 = segtable[[supplementary_values[[supplementary_value.index]]]],
                 col = supplementary_cols[[supplementary_value.index]], lty = par("lty"), lwd = 3)
      }
      
      legend_values <- c(legend_values, supplementary_values)
      legend_col <- c(legend_col, head(supplementary_cols, length(supplementary_values)))
    }
    
    #
    # Display clusters
    #
    if(!missing(cluster_value) & (missing(clustered_supplementary_value) | overlay_cluster_means == TRUE)){
      clusters <- split(segtable, f=segtable[[cluster_value]])
      for(cluster.index in seq_along(clusters)){
        segments(x0 = clusters[[cluster.index]][[start_col]], x1 = clusters[[cluster.index]][[end_col]], y0 = clusters[[cluster.index]][[cluster_value]], y1 = clusters[[cluster.index]][[cluster_value]],
                 col = cluster_cols[[cluster.index]], lty = if(overlay_cluster_means == FALSE) par("lty") else "dotted" , lwd = if(overlay_cluster_means == FALSE) 3 else 2)
      }
      legend_values <- c(legend_values, paste0(cluster_value,"#", unlist(lapply(names(clusters), function(cluster){ return(substr(cluster, 1, 5))}))))
      legend_col <- c(legend_col, head(cluster_cols, length(names(clusters))))
    }
    
    #
    # Display supplementary value color coded by cluster assignment
    #
    if(!missing(clustered_supplementary_value)){
      clusters <- split(segtable, f=segtable[[cluster_value]])
      for(cluster.index in seq_along(clusters)){
        segments(x0 = clusters[[cluster.index]][[start_col]], x1 = clusters[[cluster.index]][[end_col]], y0 = clusters[[cluster.index]][[clustered_supplementary_value]], y1 = clusters[[cluster.index]][[clustered_supplementary_value]],
                 col = cluster_cols[[cluster.index]], lty = par("lty"), lwd = 3)
      }
      legend_values <- c(legend_values, paste0(cluster_value,"#", unlist(lapply(names(clusters), function(cluster){ return(substr(cluster, 1, 5))}))))
      legend_col <- c(legend_col, head(cluster_cols, length(names(clusters))))
    }
    
    #
    # Display target segments
    #
    if(!missing(target_segments_function) & !missing(target_segments_value) & !missing(target_segments_col)){
      segtable_as_list <- split(segtable, seq(nrow(segtable)))
      selected_segtable <- segtable[sapply(segtable_as_list, target_segments_function),]
      
      segments(x0 = selected_segtable[[start_col]], x1 = selected_segtable[[end_col]], y0 = selected_segtable[[target_segments_value]], y1 = selected_segtable[[target_segments_value]],
               col = target_segments_col, lty = par("lty"), lwd = 4)
      legend_values <- c(legend_values, paste0("target-", target_segments_value))
      legend_col <- c(legend_col, target_segments_col)
    }
    
    #
    # Display horizontal lines
    #
    if(grid_lines == TRUE){
      abline(h=0)
      abline(h=0.5, col = "#4F4F4F")
      abline(h=-0.5, col = "#4F4F4F")
      abline(h=1, col = "#BABABA")
      abline(h=-1, col = "#BABABA")
    }
    
    #
    # Display chromosome boundaries
    #
    if(chrom_lines == TRUE){
      for(chrom in c(as.character(seq(2, 22)), "X")){
        chrom_coordinates <- segtable[segtable$chrom == as.character(chrom), ][[start_col]]
        chrom_start <- min(chrom_coordinates)
        abline(v = chrom_start)
      }
    }
    
    #
    # Set legend
    #
    windows.options(width=10, height=10)
    plot.new()
    legend("left", legend=legend_values,
           col = legend_col, seg.len = 0.5, lty=1, cex=0.65, pt.cex = 1, xpd = TRUE, y.intersp=1, x.intersp=.1)
  }
}