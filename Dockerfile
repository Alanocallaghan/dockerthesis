FROM bioconductor/bioconductor_docker:RELEASE_3_13

LABEL name="dockerthesis" \
      version="0.2.0" \
      url="https://github.com/Alanocallaghan/dockerthesis" \
      maintainer="alan.ocallaghan@outlook.com" \
      description="Docker image for rendering thesis docs" \
      license="GPL-3"

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    apt-utils \
    libssh2-1-dev \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    texlive-science \
    texi2html \
    texinfo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Trying to fix rmarkdown issue	(maybe not necessary)
RUN touch /home/rstudio/.Rprofile

RUN Rscript -e 'install.packages(c( \
    "bit64", \
    "coda", \
    "knitr", \
    "ggplot2", \
    "ggpointdensity", \
    "rmarkdown", \
    "RSQLite", \
    "reshape2", \
    "magick", \
    "patchwork", \
    "tidyr", \
    "mvtnorm", \
    "tikzDevice", \
    "hexbin"), Ncpus = 4)'

RUN Rscript -e 'BiocManager::install(c( \
    "AnnotationDbi", \
    "BASiCS", \
    "BiocStyle", \
    "biomaRt", \
    "EnsDb.Mmusculus.v79", \
    "GenomicFeatures", \
    "goseq", \
    "org.Mm.eg.db", \
    "scran", \
    "ComplexHeatmap", \
    "scater", \
    "SingleCellExperiment", \
    "BiocWorkflowTools"), Ncpus = 4)'
