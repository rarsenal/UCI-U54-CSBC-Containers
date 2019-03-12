FROM ucigenomics/ghtf-r3.5-jpy-base

MAINTAINER iychang@uci.edu

USER root

#setup R configs
#install libs needed for png 
RUN apt-get update && \
    apt-get -y install --fix-missing libhdf5-dev libtiff5-dev libgmp-dev libpng-dev texinfo texlive texlive-fonts-extra && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /bin/gzip /usr/bin/gzip && \
    ln -s /bin/tar /bin/gtar

USER $NB_USER 

#install R packages 1/3
RUN Rscript -e 'BiocManager::install("monocle", version = "3.8")'

#install R packages 2/3
RUN Rscript -e "install.packages('Seurat', dependencies=TRUE)"
