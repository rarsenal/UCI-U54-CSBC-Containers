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

#install Python: Scanpy
RUN git clone https://github.com/theislab/scanpy.git && \
	cd scanpy && \
	pip install -e . && \
	cd .. && \
	rm -Rf scanpy

#install R: Monocle Seurat2 CoGAPS ProjectR
RUN Rscript -e 'BiocManager::install("monocle", version = "3.8")' && \
	Rscript -e "install.packages('Seurat', dependencies=TRUE)" && \
	Rscript -e 'BiocManager::install("CoGAPS", version = "3.8")' && \
	Rscript -e 'withr::with_makevars(c(PKG_LIBS="-liconv"), install.packages("readxl"), assignment="+=")' && \
	Rscript -e 'withr::with_makevars(c(PKG_LIBS="-liconv"), install.packages("haven"), assignment="+=")' && \
	Rscript -e 'BiocManager::install("SingleCellExperiment", version = "3.8")' && \
	Rscript -e "install.packages('remotes', dependencies=TRUE)" && \
	Rscript -e 'BiocManager::install("genesofeve/projectR")'

RUN Rscript -e 'BiocManager::install("DESeq2", version = "3.8")' && \
	Rscript -e 'BiocManager::install("edgeR", version = "3.8")' && \
	Rscript -e 'BiocManager::install("limma", version = "3.8")' && \
	Rscript -e 'BiocManager::install("DEXSeq", version = "3.8")'

#install Python: CellXGene scVelocity
RUN pip install -U scvelo && \
	pip install python-igraph louvain && \
	git clone https://github.com/chanzuckerberg/cellxgene.git && \
	cd cellxgene && \
	pip install -e . && \
	cd .. && \
	rm -Rf cellxgene

RUN conda install --quiet --yes -c bioconda samtools numpy scipy cython numba matplotlib scikit-learn h5py click && \
	conda clean -tipsy && \
	fix-permissions $CONDA_DIR

RUN pip install velocyto

