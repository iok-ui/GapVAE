#!/usr/bin/env Rscript

## -------------------------------------------------------------------
## 1. Parse command-line arguments (output directory)
## -------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)

if (length(args) >= 1 && nzchar(args[1])) {
  out_dir <- args[1]
} else {
  out_dir <- getwd()
}
if (!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
}

## -------------------------------------------------------------------
## 2. Packages
## -------------------------------------------------------------------
options(repos = c(CRAN = "https://cloud.r-project.org"))

cran_pkgs <- c(
  "ggpubr","R.matlab","hdf5r","tidyr","tidyverse","cowplot",
  "ggplot2","ggpattern","magick","ggrepel","scales","viridis","ggsci"
)
missing <- setdiff(cran_pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing)

if (requireNamespace("hrbrthemes", quietly = TRUE)) {
  library(hrbrthemes)
} else {
  message("hrbrthemes not available; using theme_bw()")
}

library(R.matlab)
library(hdf5r)
library(ggpubr)
library(tidyr)
library(cowplot)
library(ggplot2)
library(ggpattern)
library(scales)
library(tidyverse)
library(viridis)
library(ggsci)
library(ggrepel)

## -------------------------------------------------------------------
## 3. Helpers
## -------------------------------------------------------------------

# Fallback colour mapping (used only if STRESS_COLOUR not present)
get_stress_colour_fallback <- function(label) {
  lab <- tolower(trimws(as.character(label)))
  if (is.na(lab) || lab == "") lab <- "unknown"

  if (lab %in% c("hl", "high light", "high_light", "highlight")) return("#E64B35FF")
  if (lab %in% c("wl", "white light", "white_light"))           return("#7E6148FF")
  if (lab %in% c("ll", "low light", "low_light"))               return("#4DBBD5FF")
  if (lab %in% c("sh", "shade"))                                return("#3C5488FF")

  if (lab %in% c("ds", "deep shade", "deep_shade"))             return("#E64B35FF")
  if (lab %in% c("ms", "moderate shade", "moderate_shade"))     return("#4DBBD5FF")

  if (lab %in% c("control", "ctrl"))                            return("#7E6148FF")
  if (lab %in% c("ht2d", "ht 2d", "2d ht"))                     return("#4DBBD5FF")
  if (lab %in% c("ht4d", "ht 4d", "4d ht"))                     return("#3C5488FF")
  if (lab %in% c("ht6d", "ht 6d", "6d ht"))                     return("#E64B35FF")

  if (lab %in% c("buffer-infiltrated", "buffer infiltrated", "buffer")) return("#4DBBD5FF")
  if (lab %in% c("pathogen-infiltrated", "pathogen infiltrated", "pathogen")) return("#E64B35FF")

  if (lab %in% c("elf18-infiltrated", "elf18 infiltrated", "elf18")) return("#4DBBD5FF")
  if (lab %in% c("flg22-infiltrated", "flg22 infiltrated", "flg22")) return("#E64B35FF")
  if (lab %in% c("mock-infiltrated", "mock infiltrated", "mock")) return("#7E6148FF")

  fallback <- c("#E64B35FF","#4DBBD5FF","#7E6148FF","#3C5488FF","#00A087FF")
  idx <- (sum(utf8ToInt(lab)) %% length(fallback)) + 1
  fallback[idx]
}

# Fallback shape mapping (used only if STRESS_SHAPE not present)
get_stress_shape_fallback <- function(label) {
  lab <- tolower(trimws(as.character(label)))
  if (is.na(lab) || lab == "") lab <- "unknown"

  if (lab %in% c("hl", "high light", "high_light", "highlight")) return(15L)
  if (lab %in% c("wl", "white light", "white_light"))            return(16L)
  if (lab %in% c("ll", "low light", "low_light"))                return(17L)
  if (lab %in% c("sh", "shade"))                                 return(18L)

  if (lab %in% c("ds", "deep shade", "deep_shade"))              return(15L)
  if (lab %in% c("ms", "moderate shade", "moderate_shade"))      return(16L)
  if (lab %in% c("white light", "white_light", "wl"))            return(17L)

  if (lab %in% c("control", "ctrl"))                             return(16L)
  if (lab %in% c("ht2d", "ht 2d", "2d ht"))                      return(15L)
  if (lab %in% c("ht4d", "ht 4d", "4d ht"))                      return(17L)
  if (lab %in% c("ht6d", "ht 6d", "6d ht"))                      return(18L)

  if (lab %in% c("buffer-infiltrated", "buffer infiltrated", "buffer")) return(15L)
  if (lab %in% c("pathogen-infiltrated", "pathogen infiltrated", "pathogen")) return(16L)

  if (lab %in% c("elf18-infiltrated", "elf18 infiltrated", "elf18")) return(15L)
  if (lab %in% c("flg22-infiltrated", "flg22 infiltrated", "flg22")) return(16L)
  if (lab %in% c("mock-infiltrated", "mock infiltrated", "mock")) return(17L)

  fallback_shapes <- c(15L,16L,17L,18L)
  idx <- (sum(utf8ToInt(lab)) %% length(fallback_shapes)) + 1
  fallback_shapes[idx]
}

# Convert MATLAB cellstr or char to a plain character vector
as_char_vec <- function(x) {
  if (is.null(x)) return(NULL)

  # Flatten nested lists from R.matlab (e.g. 1x4 cell -> list[[1]][[1..4]])
  if (is.list(x)) {
    flat <- unlist(x, recursive = TRUE, use.names = FALSE)
    return(vapply(flat, function(e) as.character(e)[1], FUN.VALUE = character(1)))
  }

  as.character(x)
}

# Safely extract one of several possible field names
get_mat_field <- function(mat, candidates) {
  for (nm in candidates) {
    if (nm %in% names(mat)) return(mat[[nm]])
  }
  NULL
}

# Map shape names from STRESS_SHAPE to pch codes
shape_name_to_pch <- function(x) {
  lab <- tolower(trimws(as.character(x)))
  if (lab %in% c("square"))   return(15L)
  if (lab %in% c("circle"))   return(16L)
  if (lab %in% c("triangle")) return(17L)
  if (lab %in% c("diamond"))  return(18L)
  # fallback
  fallback_shapes <- c(15L,16L,17L,18L)
  idx <- (sum(utf8ToInt(lab)) %% length(fallback_shapes)) + 1
  fallback_shapes[idx]
}

# Normalise hex colour (ensure leading "#")
norm_hex <- function(col_vec) {
  col_vec <- as.character(col_vec)
  col_vec[!grepl("^#", col_vec)] <- paste0("#", col_vec[!grepl("^#", col_vec)])
  col_vec
}

## -------------------------------------------------------------------
## 4. Locate Diff Spectrum files
## -------------------------------------------------------------------
work_dir <- getwd()
diff_dir <- file.path(work_dir, "crnr_transformed")

if (!dir.exists(diff_dir)) {
  stop("Directory 'crnr_transformed' not found in working directory: ", work_dir)
}

diff_files <- list.files(
  path       = diff_dir,
  pattern    = "^\\(Tr\\) Diff Spectrum \\(.*\\) with .* and .*\\.mat$",
  full.names = FALSE
)

if (length(diff_files) == 0) {
  stop("No '(Tr) Diff Spectrum (...) with ... and ....mat' files found in ", diff_dir)
}

message("Found ", length(diff_files), " Diff Spectrum file(s) in ", diff_dir)

## -------------------------------------------------------------------
## 4b. Pre-scan to decide ONE global y max across all figures (lollipop)
## -------------------------------------------------------------------
global_max <- -Inf

for (df_name in diff_files) {

  m <- regexec("\\(Tr\\) Diff Spectrum \\(([^)]*)\\) with (.+) and (.+)\\.mat", df_name)
  parts <- regmatches(df_name, m)[[1]]
  if (length(parts) != 4) next

  seq_str <- parts[2]
  kind    <- parts[3]

  cond_tokens <- trimws(strsplit(seq_str, "-")[[1]])
  n_cond <- length(cond_tokens)
  if (n_cond < 1) next

  # Load mat to prefer STRESS_SEQ tokens (ensures correct token->peaks-file mapping)
  mat_diff <- readMat(file.path(diff_dir, df_name))

  stress_seq_mat <- NULL
  if ("stress_seq" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$stress_seq)
  } else if ("stress.seq" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$stress.seq)
  } else if ("STRESS_SEQ" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$STRESS_SEQ)
  }

  if (!is.null(stress_seq_mat) && length(stress_seq_mat) == n_cond) {
    cond_tokens <- stress_seq_mat
  }

  for (k in seq_len(n_cond)) {
    token_k <- cond_tokens[k]
    peaks_fname <- sprintf("ranked_sig_pks_%s %s.mat", token_k, kind)
    peaks_path  <- file.path(work_dir, peaks_fname)
    if (!file.exists(peaks_path)) next

    mat_pk <- readMat(peaks_path)
    var_candidates <- c(
      sprintf("ranked_sig_pks_%s", token_k),
      sprintf("ranked.sig.pks.%s", token_k),
      sprintf("ranked.sig.pks.%s", tolower(token_k)),
      sprintf("ranked.sig.pks.%s", toupper(token_k))
    )
    avail <- intersect(var_candidates, names(mat_pk))
    if (length(avail) == 0) next

    df_pk <- as.data.frame(mat_pk[[avail[1]]])
    if (ncol(df_pk) < 2) next

    # value column: if 3 cols exist use col 3, else use col 2
    val_col <- if (ncol(df_pk) >= 3) 3 else 2
    global_max <- max(global_max, suppressWarnings(as.numeric(df_pk[[val_col]])), na.rm = TRUE)
  }
}

if (!is.finite(global_max) || global_max <= 0) global_max <- 1
global_ymax_value <- max(1, ceiling(global_max / 500) * 500 + 100)

message("Global lollipop y max set to: ", global_ymax_value)

## -------------------------------------------------------------------
## 5. Main loop
## -------------------------------------------------------------------
for (df_name in diff_files) {
  message("Processing Diff Spectrum file: ", df_name)

  # Parse "(Tr) Diff Spectrum (SEQ) with KIND and LOCATION.mat"
  m <- regexec("\\(Tr\\) Diff Spectrum \\(([^)]*)\\) with (.+) and (.+)\\.mat", df_name)
  parts <- regmatches(df_name, m)[[1]]
  if (length(parts) != 4) {
    warning("Could not parse file name pattern for: ", df_name, " – skipping.")
    next
  }

  seq_str  <- parts[2]  # e.g. "HL-WL-LL-SH"
  kind     <- parts[3]  # e.g. "AB", "CS", "KL", "WT", ...
  location <- parts[4]  # e.g. "leaf", "loc1", ...

  # Initial condition "tokens" from the filename (HL, WL, ...)
  cond_tokens <- trimws(strsplit(seq_str, "-")[[1]])
  n_cond <- length(cond_tokens)
  if (n_cond < 1) {
    warning("No conditions parsed from sequence: ", seq_str, " – skipping.")
    next
  }

  ## ---------------------------------------------------------------
  ## 5a. Load Diff Spectrum + STRESS metadata
  ## ---------------------------------------------------------------
  diff_path <- file.path(diff_dir, df_name)
  mat_diff  <- readMat(diff_path)

  if (!"x" %in% names(mat_diff)) {
    stop("No 'x' found in Diff Spectrum file: ", diff_path)
  }
  x_vec <- as.numeric(mat_diff$x)

  cat("  mat_diff names:", paste(names(mat_diff), collapse = ", "), "\n")

  # stress_seq: tokens such as HL, WL, LL, SH
  if ("stress_seq" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$stress_seq)
  } else if ("stress.seq" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$stress.seq)
  } else if ("STRESS_SEQ" %in% names(mat_diff)) {
    stress_seq_mat <- as_char_vec(mat_diff$STRESS_SEQ)
  } else {
    stress_seq_mat <- NULL
  }

  # stress_label: display labels such as "High light", "White light", ...
  if ("stress_label" %in% names(mat_diff)) {
    stress_label_mat <- as_char_vec(mat_diff$stress_label)
  } else if ("stress.label" %in% names(mat_diff)) {
    stress_label_mat <- as_char_vec(mat_diff$stress.label)
  } else if ("STRESS_LABEL" %in% names(mat_diff)) {
    stress_label_mat <- as_char_vec(mat_diff$STRESS_LABEL)
  } else {
    stress_label_mat <- NULL
  }

  # stress_colour: hex colours
  if ("stress_colour" %in% names(mat_diff)) {
    stress_colour_mat <- norm_hex(as_char_vec(mat_diff$stress_colour))
  } else if ("stress.colour" %in% names(mat_diff)) {
    stress_colour_mat <- norm_hex(as_char_vec(mat_diff$stress.colour))
  } else if ("STRESS_COLOUR" %in% names(mat_diff)) {
    stress_colour_mat <- norm_hex(as_char_vec(mat_diff$STRESS_COLOUR))
  } else {
    stress_colour_mat <- NULL
  }

  # stress_shape: "square", "circle", ...
  if ("stress_shape" %in% names(mat_diff)) {
    stress_shape_mat <- as_char_vec(mat_diff$stress_shape)
  } else if ("stress.shape" %in% names(mat_diff)) {
    stress_shape_mat <- as_char_vec(mat_diff$stress.shape)
  } else if ("STRESS_SHAPE" %in% names(mat_diff)) {
    stress_shape_mat <- as_char_vec(mat_diff$STRESS_SHAPE)
  } else {
    stress_shape_mat <- NULL
  }

  # tokens: use STRESS_SEQ if available, otherwise filename tokens
  if (!is.null(stress_seq_mat) && length(stress_seq_mat) == n_cond) {
    cond_tokens <- stress_seq_mat
  }

  # labels shown in legend: prefer stress_label_mat
  if (!is.null(stress_label_mat) && length(stress_label_mat) == length(cond_tokens)) {
    cond_labels_display <- stress_label_mat
  } else {
    cond_labels_display <- cond_tokens
  }

  # colours: prefer stress_colour_mat, otherwise fallback based on tokens
  if (!is.null(stress_colour_mat) && length(stress_colour_mat) == length(cond_tokens)) {
    cond_colours <- stress_colour_mat
  } else {
    cond_colours <- norm_hex(vapply(cond_tokens, get_stress_colour_fallback, character(1)))
  }

  # shapes: prefer stress_shape_mat, otherwise fallback
  if (!is.null(stress_shape_mat) && length(stress_shape_mat) == length(cond_tokens)) {
    cond_shapes <- vapply(stress_shape_mat, shape_name_to_pch, integer(1))
  } else {
    cond_shapes <- vapply(cond_tokens, get_stress_shape_fallback, integer(1))
  }

  if (length(cond_labels_display) != n_cond ||
      length(cond_colours)        != n_cond ||
      length(cond_shapes)         != n_cond) {
    stop("Length mismatch between conditions/labels/colours/shapes in ", df_name)
  }

  cat("  cond_labels_display (legend):", paste(cond_labels_display, collapse = ", "), "\n")

  ## ---------------------------------------------------------------
  ## 5b. Extract spectra per condition
  ## ---------------------------------------------------------------
  spectra_list <- list()
  if ("data" %in% names(mat_diff)) {
    raw_d <- mat_diff$data

    if (is.list(raw_d)) {
      if (length(raw_d) < n_cond) {
        stop("Diff Spectrum 'data' has fewer elements than conditions for file: ", diff_path)
      }
      for (k in seq_len(n_cond)) {
        v <- raw_d[[k]]
        if (is.list(v)) v <- v[[1]]
        spectra_list[[k]] <- as.numeric(v)
      }
    } else {
      if (ncol(raw_d) < n_cond) {
        stop("Diff Spectrum matrix has fewer columns than conditions in: ", diff_path)
      }
      for (k in seq_len(n_cond)) {
        spectra_list[[k]] <- as.numeric(raw_d[, k])
      }
    }
  } else {
    for (k in seq_len(n_cond)) {
      name_k <- paste0("data", k)
      if (!name_k %in% names(mat_diff)) {
        stop("Missing '", name_k, "' in Diff Spectrum file: ", diff_path)
      }
      spectra_list[[k]] <- as.numeric(mat_diff[[name_k]])
    }
  }

  x_z_df <- data.frame(xValue = x_vec)
  for (k in seq_len(n_cond)) {
    x_z_df[[cond_labels_display[k]]] <- spectra_list[[k]]
  }

  x_z_long <- x_z_df |>
    pivot_longer(
      cols      = -xValue,
      names_to  = "cond",
      values_to = "value"
    )

  cond_order   <- cond_labels_display
  col_vec_named <- setNames(cond_colours, cond_labels_display)

  plot1d <- ggplot(x_z_long, aes(x = xValue, y = value, colour = cond)) +
  geom_line(linewidth = 1) +
  scale_colour_manual(values = col_vec_named, name = NULL) +
  theme_bw() +
  theme(
    plot.title       = element_text(size = 12),
    panel.border     = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line.x      = element_blank(),
    axis.line.y      = element_line(),
    axis.ticks.x     = element_blank(),
    axis.ticks.y     = element_line(),
    axis.text.x      = element_blank(),
    axis.text.y      = element_text(size = 12),
    axis.title.y     = element_text(size = 12, margin = margin(r = 8)),
    legend.position  = "none",
    plot.margin      = margin(0.5, 0.5, 0, 0.5, "cm")
  ) +
  labs(
    x = "",
    y = ""
  )

  ## ---------------------------------------------------------------
  ## 5c. Load ranked peaks (lollipop)
  ## ---------------------------------------------------------------
  peaks_list <- list()
  N <- 5

  for (k in seq_len(n_cond)) {
    token_k  <- cond_tokens[k]
    label_k  <- cond_labels_display[k]

    peaks_fname <- sprintf("ranked_sig_pks_%s %s.mat", token_k, kind)
    peaks_path  <- file.path(work_dir, peaks_fname)

    if (!file.exists(peaks_path)) {
      warning("Peaks file not found: ", peaks_fname, " – skipping this condition.")
      next
    }

    mat_pk <- readMat(peaks_path)
    var_candidates <- c(
      sprintf("ranked_sig_pks_%s", token_k),
      sprintf("ranked.sig.pks.%s", token_k),
      sprintf("ranked.sig.pks.%s", tolower(token_k)),
      sprintf("ranked.sig.pks.%s", toupper(token_k))
    )
    avail <- intersect(var_candidates, names(mat_pk))
    if (length(avail) == 0) {
      warning("No matching variable in peaks file: ", peaks_fname,
              " (tried: ", paste(var_candidates, collapse = ", "), ")")
      next
    }

    pk_mat <- mat_pk[[avail[1]]]
    df_pk  <- as.data.frame(pk_mat)
    if (ncol(df_pk) < 2) {
      warning("Peaks matrix has fewer than 2 columns in: ", peaks_fname)
      next
    }

    if (ncol(df_pk) >= 3) {
      df_pk <- df_pk[, 1:3, drop = FALSE]
      colnames(df_pk) <- c("wavenum_original", "wavenum", "value")
    } else {
      colnames(df_pk)[1:2] <- c("wavenum", "value")
      df_pk$wavenum_original <- df_pk$wavenum
      df_pk <- df_pk[, c("wavenum_original", "wavenum", "value")]
    }

    df_pk <- head(df_pk, N)

    peaks_list[[length(peaks_list) + 1]] <- data.frame(
      wavenum = df_pk$wavenum,
      value   = df_pk$value,
      cond    = label_k
    )
  }

  if (length(peaks_list) == 0) {
    warning("No valid peaks for kind ", kind, " – skipping lollipop.")
    next
  }

  data_ll <- bind_rows(peaks_list)
  data_ll$cond <- factor(data_ll$cond, levels = cond_order)

  ymax_value <- global_ymax_value

  tick_increment <- if (ymax_value < 4000) {
    500
  } else if (ymax_value <= 6000) {
    1000
  } else {
    2000
  }

  if (ymax_value < 500) tick_increment <- max(1, round(ymax_value / 5))
  
  levs         <- levels(data_ll$cond)
  col_vec_full <- setNames(cond_colours, cond_labels_display)[levs]
  shape_vec    <- setNames(cond_shapes,  cond_labels_display)[levs]

ll <- ggscatter(
  data_ll, x = "wavenum", y = "value",
  color = "cond", palette = col_vec_full,
  shape = "cond", xlim = c(600, 1750),
  ylim = c(0, ymax_value), size = 5,
  ellipse = FALSE, mean.point = FALSE, star.plot = FALSE
) +
  scale_shape_manual(values = shape_vec, name = NULL) +
  scale_color_manual(values = col_vec_full, name = NULL) +
  expand_limits(x = c(600, 1750)) +
  scale_x_continuous(breaks = seq(600, 1750, by = 100)) +
  scale_y_continuous(breaks = seq(0, ymax_value, by = tick_increment)) +
  labs(
    x = "",
    y = ""
  ) +
  theme(
    legend.position = "top",
    axis.title.x    = element_text(size = 12, margin = margin(t = 8)),
    axis.title.y    = element_text(size = 12, margin = margin(r = 8)),
    axis.text       = element_text(size = 10),
    plot.margin     = margin(0, 0.5, 0, 0.5, "cm")
  )

  # legend from lollipop (shows colour + shape)
  legend_g <- cowplot::get_legend(ll)

  # remove legend from lollipop for the combined panel
  ll_nolegend <- ll + theme(legend.position = "none")

  # legend from lollipop (has colour + shape)
  legend_ll <- cowplot::get_legend(ll + theme(legend.position = "top"))

  # versions without legend for alignment
  p1_noleg <- plot1d + theme(legend.position = "none")
  p2_noleg <- ll      + theme(legend.position = "none")

  # align inner panels vertically, matching left/right axes
  aligned <- cowplot::align_plots(p1_noleg, p2_noleg,
                                align = "v", axis = "lr")

  core <- cowplot::plot_grid(
    aligned[[1]],
    aligned[[2]],
    ncol = 1,
    rel_heights = c(4, 4)
  )

  # put legend on top of the aligned core
  combo <- cowplot::plot_grid(
    legend_ll,
    core,
    ncol = 1,
    rel_heights = c(0.3, 4)
  )

  w <- 8
  h <- 5

  loc_suffix <- ""
  if (location %in% c("leaf", "petiole")) {
    loc_suffix <- paste0("_", location)
  } else if (!identical(location, "loc1")) {
    loc_suffix <- paste0("_", location)
  }

  out_fname <- sprintf("%s%s_1d_ll.jpeg", kind, loc_suffix)
  out_path  <- file.path(out_dir, out_fname)

  ggsave(
    filename = out_path,
    plot     = combo,
    units    = "in",
    width    = w,
    height   = h,
    device   = "tiff",
    dpi      = 600
  )

  message("Saved palette figure: ", out_path)
}

message(sprintf("Generic palette figures produced successfully and saved in: %s", out_dir))
