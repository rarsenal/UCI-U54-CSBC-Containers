FROM ucigenomics/ghtf-r3.5-jpy-base

MAINTAINER iychang@uci.edu

USER root

#install libs needed for png 
RUN apt-get update && \
    apt-get -y install --fix-missing libhdf5-dev libtiff5-dev libgmp-dev libpng-dev texinfo texlive texlive-fonts-extra && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /bin/gzip /usr/bin/gzip
RUN ln -s /bin/tar /bin/gtar
USER $NB_USER
RUN Rscript -e "devtools::install_github(repo = 'satijalab/seurat', ref = 'release/3.0')"

RUN conda install --yes -c conda-forge umap-learn && \
	conda clean -tipsy
