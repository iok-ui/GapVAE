# R 4.4.1 base (multi-arch; works on arm64/Apple Silicon)
FROM rocker/r-ver:4.4.1

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# System libs for your package set (sf, magick, hdf5r, ragg, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ gfortran make cmake patch pkg-config git \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    libhdf5-dev \
    libmagick++-dev ghostscript \
    libharfbuzz-dev libfribidi-dev \
    libfontconfig1-dev libfreetype6-dev \
    libpng-dev libjpeg-dev libtiff5-dev libwebp-dev \
    libudunits2-dev libgdal-dev libgeos-dev libproj-dev libabsl-dev \
    fonts-roboto fonts-ibm-plex \
 && rm -rf /var/lib/apt/lists/*

# Refresh font cache (helps hrbrthemes text rendering)
RUN fc-cache -f -v

# Pre-install CRAN pkgs + hrbrthemes from GitHub
RUN R -q -e "options(repos=c(CRAN='https://cloud.r-project.org')); \
  pkgs <- c( \
    'tidyverse','ggpubr','R.matlab','hdf5r','cowplot','ggpattern','magick','here', \
    'dplyr','scales','rstatix','car','sf','units','s2','ragg','ggrepel','viridis','ggsci','remotes' \
  ); \
  inst <- rownames(installed.packages()); \
  to_install <- setdiff(pkgs, inst); \
  if (length(to_install)) install.packages(to_install); \
  remotes::install_github('hrbrmstr/hrbrthemes', upgrade='never')"

WORKDIR /work
CMD ["R","-q"]
