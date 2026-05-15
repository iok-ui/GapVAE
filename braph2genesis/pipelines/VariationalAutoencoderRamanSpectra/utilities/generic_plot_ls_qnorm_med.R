#!/usr/bin/env Rscript

## -------------------------------------------------------------------
## 1) CLI arg: output directory
## -------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args) >= 1 && nzchar(args[1])) args[1] else getwd()
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

## -------------------------------------------------------------------
## 2) Packages
## -------------------------------------------------------------------
options(repos = c(CRAN = "https://cloud.r-project.org"))
cran_pkgs <- c("ggpubr","R.matlab","hdf5r","tidyr","tidyverse","cowplot",
               "ggplot2","ggpattern","magick","ggrepel","scales","viridis","ggsci")
missing <- setdiff(cran_pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing)

suppressPackageStartupMessages({
  if (requireNamespace("hrbrthemes", quietly = TRUE)) {
    library(hrbrthemes)
  } else {
    message("hrbrthemes not available; using theme_bw()")
  }
  library(R.matlab); library(hdf5r); library(ggpubr); library(tidyr)
  library(cowplot);  library(ggplot2); library(ggpattern); library(scales)
  library(tidyverse); library(viridis); library(ggsci); library(ggrepel)
})

## -------------------------------------------------------------------
## 3) Helpers (same palette/shape logic as script #1)
## -------------------------------------------------------------------
get_stress_colour_fallback <- function(label) {
  lab <- tolower(trimws(as.character(label))); if (is.na(lab) || lab == "") lab <- "unknown"
  if (lab %in% c("hl","high light","high_light","highlight")) return("#E64B35FF")
  if (lab %in% c("wl","white light","white_light"))           return("#7E6148FF")
  if (lab %in% c("ll","low light","low_light"))               return("#4DBBD5FF")
  if (lab %in% c("sh","shade"))                                return("#3C5488FF")
  if (lab %in% c("ds","deep shade","deep_shade"))              return("#E64B35FF")
  if (lab %in% c("ms","moderate shade","moderate_shade"))      return("#4DBBD5FF")
  if (lab %in% c("control","ctrl"))                            return("#7E6148FF")
  if (lab %in% c("ht2d","ht 2d","2d ht"))                      return("#4DBBD5FF")
  if (lab %in% c("ht4d","ht 4d","4d ht"))                      return("#3C5488FF")
  if (lab %in% c("ht6d","ht 6d","6d ht"))                      return("#E64B35FF")
  if (lab %in% c("buffer-infiltrated","buffer infiltrated","buffer")) return("#4DBBD5FF")
  if (lab %in% c("pathogen-infiltrated","pathogen infiltrated","pathogen")) return("#E64B35FF")
  if (lab %in% c("elf18-infiltrated","elf18 infiltrated","elf18")) return("#4DBBD5FF")
  if (lab %in% c("flg22-infiltrated","flg22 infiltrated","flg22")) return("#E64B35FF")
  if (lab %in% c("mock-infiltrated","mock infiltrated","mock")) return("#7E6148FF")
  fallback <- c("#E64B35FF","#4DBBD5FF","#7E6148FF","#3C5488FF","#00A087FF")
  fallback[(sum(utf8ToInt(lab)) %% length(fallback)) + 1L]
}
get_stress_shape_fallback <- function(label) {
  lab <- tolower(trimws(as.character(label))); if (is.na(lab) || lab == "") lab <- "unknown"
  if (lab %in% c("hl","high light","high_light","highlight")) return(15L) # square
  if (lab %in% c("wl","white light","white_light"))            return(16L) # circle
  if (lab %in% c("ll","low light","low_light"))                return(17L) # triangle
  if (lab %in% c("sh","shade"))                                return(18L) # diamond
  if (lab %in% c("ds","deep shade","deep_shade"))              return(15L)
  if (lab %in% c("ms","moderate shade","moderate_shade"))      return(16L)
  if (lab %in% c("control","ctrl"))                            return(16L)
  if (lab %in% c("ht2d","ht 2d","2d ht"))                      return(15L)
  if (lab %in% c("ht4d","ht 4d","4d ht"))                      return(17L)
  if (lab %in% c("ht6d","ht 6d","6d ht"))                      return(18L)
  if (lab %in% c("buffer-infiltrated","buffer infiltrated","buffer")) return(15L)
  if (lab %in% c("pathogen-infiltrated","pathogen infiltrated","pathogen")) return(16L)
  if (lab %in% c("elf18-infiltrated","elf18 infiltrated","elf18")) return(15L)
  if (lab %in% c("flg22-infiltrated","flg22 infiltrated","flg22")) return(16L)
  if (lab %in% c("mock-infiltrated","mock infiltrated","mock")) return(17L)
  fallback_shapes <- c(15L,16L,17L,18L)
  fallback_shapes[(sum(utf8ToInt(lab)) %% length(fallback_shapes)) + 1L]
}
as_char_vec <- function(x) {
  if (is.null(x)) return(NULL)
  if (is.list(x)) {
    flat <- unlist(x, recursive = TRUE, use.names = FALSE)
    return(vapply(flat, function(e) as.character(e)[1], FUN.VALUE = character(1)))
  }
  as.character(x)
}
get_mat_field <- function(mat, candidates) {
  for (nm in candidates) if (nm %in% names(mat)) return(mat[[nm]])
  NULL
}
shape_name_to_pch <- function(x) {
  if (is.numeric(x)) return(as.integer(round(x[1])))
  lab <- tolower(trimws(as.character(x)))
  if (lab %in% c("square"))   return(15L)
  if (lab %in% c("circle"))   return(16L)
  if (lab %in% c("triangle")) return(17L)
  if (lab %in% c("diamond"))  return(18L)
  fallback_shapes <- c(15L,16L,17L,18L)
  fallback_shapes[(sum(utf8ToInt(lab)) %% length(fallback_shapes)) + 1L]
}
norm_hex <- function(col_vec) {
  col_vec <- as.character(col_vec)
  col_vec[!grepl("^#", col_vec)] <- paste0("#", col_vec[!grepl("^#", col_vec)])
  col_vec
}

## -------------------------------------------------------------------
## 4) Locate input files
## -------------------------------------------------------------------
work_dir <- getwd()
lat_dir  <- file.path(work_dir, "crnr_transformed")
if (!dir.exists(lat_dir)) stop("Directory 'crnr_transformed' not found in: ", work_dir)

lat_files <- list.files(lat_dir, pattern = "^latent_.*\\.mat$", full.names = FALSE)
if (!length(lat_files)) stop("No 'latent_*.mat' files found in ", lat_dir)
cat("Found", length(lat_files), "latent file(s) in", lat_dir, "\n")

## -------------------------------------------------------------------
## 5) Global standardisation & qnorm-style axis mapping
##     (wide near 0, compressed in tails) using the Gaussian CDF.
## -------------------------------------------------------------------
z1_pool <- z2_pool <- numeric(0)
for (lf in lat_files) {
  dat <- readMat(file.path(lat_dir, lf))
  if (!("z1" %in% names(dat)) || !("z2" %in% names(dat))) next
  z1_pool <- c(z1_pool, as.numeric(unlist(dat$z1)))
  z2_pool <- c(z2_pool, as.numeric(unlist(dat$z2)))
}
z1_pool <- z1_pool[is.finite(z1_pool)]; z2_pool <- z2_pool[is.finite(z2_pool)]
mu1 <- if (length(z1_pool)) mean(z1_pool) else 0
sd1 <- if (length(z1_pool) && sd(z1_pool) > 0) sd(z1_pool) else 1
mu2 <- if (length(z2_pool)) mean(z2_pool) else 0
sd2 <- if (length(z2_pool) && sd(z2_pool) > 0) sd(z2_pool) else 1
cat(sprintf("Global z1 mean/sd: %.4f / %.4f\n", mu1, sd1))
cat(sprintf("Global z2 mean/sd: %.4f / %.4f\n", mu2, sd2))

# Map standardised z to display coordinate in [-5, 5] via CDF
to_display <- function(z_std) 10 * pnorm(1.5*z_std) - 5

# Axis ticks: labels and their *display* positions
tick_labels <- c("-5","-1","-0.5","0","0.5","1","5")
tick_values <- c(-5,  -1,   -0.5,   0,   0.5,  1,  5)
tick_breaks <- to_display(tick_values)
axis_limits <- c(-5.5, 5.5)

## -------------------------------------------------------------------
## 6) Main loop per latent file
## -------------------------------------------------------------------
for (lf in lat_files) {
  lat_path <- file.path(lat_dir, lf)
  data <- readMat(lat_path)
  if (!("z1" %in% names(data)) || !("z2" %in% names(data))) {
    warning("Skipping ", lf, " (no z1/z2)")
    next
  }

  z1_raw <- data$z1; z2_raw <- data$z2
  if (!is.list(z1_raw) || !is.list(z2_raw)) {
    warning("z1/z2 not cell arrays in ", lf, " – skipping.")
    next
  }

  z1_list <- lapply(z1_raw, function(v) as.numeric(unlist(v)))
  z2_list <- lapply(z2_raw, function(v) as.numeric(unlist(v)))
  if (length(z1_list) != length(z2_list)) {
    warning("length(z1_list) != length(z2_list) in ", lf); next
  }
  n_cond <- length(z1_list); if (n_cond < 1) next

  ## ---- metadata for legend/shape/colour/labels
  stress_seq_mat    <- as_char_vec(get_mat_field(data, c("stress_seq","stress.seq","STRESS_SEQ")))
  stress_label_mat  <- as_char_vec(get_mat_field(data, c("stress_label","stress.label","STRESS_LABEL")))
  stress_colour_mat <- as_char_vec(get_mat_field(data, c("stress_colour","stress.colour","STRESS_COLOUR")))
  stress_shape_mat  <- as_char_vec(get_mat_field(data, c("stress_shape","stress.shape","STRESS_SHAPE")))

  if (!is.null(stress_seq_mat) && length(stress_seq_mat) == n_cond) {
    cond_tokens <- stress_seq_mat
  } else cond_tokens <- paste0("Cond", seq_len(n_cond))

  if (!is.null(stress_label_mat) && length(stress_label_mat) == n_cond) {
    cond_labels <- stress_label_mat
  } else cond_labels <- cond_tokens

  if (!is.null(stress_colour_mat) && length(stress_colour_mat) == n_cond) {
    cond_colours <- norm_hex(stress_colour_mat)
  } else cond_colours <- norm_hex(vapply(cond_tokens, get_stress_colour_fallback, character(1)))

  if (!is.null(stress_shape_mat) && length(stress_shape_mat) == n_cond) {
    cond_shapes <- vapply(stress_shape_mat, shape_name_to_pch, integer(1))
  } else cond_shapes <- vapply(cond_tokens, get_stress_shape_fallback, integer(1))

  if (length(cond_labels) != n_cond || length(cond_colours) != n_cond || length(cond_shapes) != n_cond)
    stop("Length mismatch in ", lf)

  cat("Processing ", lf, "\n")
  cat("  cond_tokens: ", paste(cond_tokens, collapse = ", "), "\n", sep = "")
  cat("  cond_labels: ", paste(cond_labels, collapse = ", "), "\n", sep = "")

  ## ---- build plotting data using the SAME mapping for x & y
  df_list <- list()
  for (i in seq_len(n_cond)) {
    z1 <- z1_list[[i]]; z2 <- z2_list[[i]]
    z1 <- z1[is.finite(z1)]; z2 <- z2[is.finite(z2)]
    if (!length(z1) || !length(z2)) next

    z1_std <- (z1 - mu1) / sd1
    z2_std <- (z2 - mu2) / sd2

    df_list[[length(df_list) + 1L]] <- data.frame(
      x = to_display(z1_std),
      y = to_display(z2_std),
      state = cond_labels[i],
      stringsAsFactors = FALSE
    )
  }
  if (!length(df_list)) { warning("No valid data in ", lf); next }
  df <- dplyr::bind_rows(df_list)
  df$state <- factor(df$state, levels = cond_labels)

  median_points <- df |>
    dplyr::group_by(state) |>
    dplyr::summarise(
      x = median(x, na.rm = TRUE),
      y = median(y, na.rm = TRUE),
      .groups = "drop"
    )

  ## ---- colours & shapes in legend
  levs        <- levels(df$state)
  palette_use <- setNames(cond_colours, cond_labels)[levs]
  shapes_use  <- setNames(cond_shapes,  cond_labels)[levs]

  ## ---- plot
  ls_plot <- ggpubr::ggscatter(
    df, x = "x", y = "y",
    color = "state", palette = palette_use,
    shape = "state", size = 1.5, alpha = 0.4
  ) +
    scale_colour_manual(values = palette_use, name = "state") +
    scale_shape_manual(values  = shapes_use,  name = "state") +
    labs(x = "z1", y = "z2") +
    theme_bw() +
    theme(
      aspect.ratio = 1,
      panel.border     = element_rect(linewidth = 1),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.text.x      = element_text(angle = 45, vjust = 1, hjust = 1, size = 9),
      axis.text.y      = element_text(size = 9), 
      axis.title       = element_text(size = 9),
      legend.title     = element_text(size = 5),
      legend.position  = "top",
      legend.text      = element_text(size = 4),
      legend.key.width = unit(4, "pt"),               # narrower key
      legend.key.height= unit(4, "pt"),               # shorter key
      legend.spacing.x = unit(1, "pt"),               # less horiz spacing
      legend.spacing.y = unit(1, "pt"), 
      plot.margin      = margin(0.2, 0.2, 0.2, 0.2, "cm")
    ) + guides(
      colour = guide_legend(
        override.aes = list(size = 2, alpha = 1),    # smaller legend symbols
        keywidth  = unit(6, "pt"),
        keyheight = unit(6, "pt")
      ),
      shape  = guide_legend(
        override.aes = list(size = 2),
        keywidth  = unit(6, "pt"),
        keyheight = unit(6, "pt")
      )
    ) + 
    scale_x_continuous(breaks = tick_breaks, labels = tick_labels,
                       limits = axis_limits, expand = c(0,0)) +
    scale_y_continuous(breaks = tick_breaks, labels = tick_labels,
                       limits = axis_limits, expand = c(0,0)) +
    coord_fixed(ratio = 1) +
    geom_point(
      data = median_points,
      aes(x = x, y = y, color = state, shape = state),
      size = 4
    )

  ## ---- save
  w <- 2.75; h <- 2.75
  base_name <- sub("^latent_", "", tools::file_path_sans_ext(lf))
  out_file  <- paste0(base_name, "_ls_qnorm_med.jpeg")
  ggsave(
    filename = file.path(out_dir, out_file),
    plot     = ls_plot,
    units    = "in",
    width    = w,
    height   = h,
    device   = "tiff",
    dpi      = 600
  )
  cat("Saved: ", file.path(out_dir, out_file), "\n", sep = "")
}

message(sprintf("Latent Q–Q plots written to: %s", out_dir))