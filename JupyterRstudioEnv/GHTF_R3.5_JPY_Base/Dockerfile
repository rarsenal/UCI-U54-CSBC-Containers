FROM jupyter/r-notebook

USER root

# general pre-requisites
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		libapparmor1 \
		libedit2 \
		lsb-release \ 
		libssl1.0.0 \
		psmisc \
		libcurl4-openssl-dev \
		libxml2-dev \
		zlib1g-dev \
		libssl-dev \
		python-cffi \
		file \
		libffi6 \
		libffi-dev \
		libmariadbclient-dev \
		libpq-dev && \
	apt-get clean && \
    	rm -rf /var/lib/apt/lists/*

# Set rstudio server version to install
# You can use rsession from rstudio's desktop package as well.
ENV RSTUDIO_PKG=rstudio-server-1.1.463-amd64.deb

RUN wget -q http://download2.rstudio.org/${RSTUDIO_PKG} && \
	dpkg -i ${RSTUDIO_PKG} && \
	rm ${RSTUDIO_PKG}


USER $NB_USER

RUN pip install jupyter-server-proxy jupyter-rsession-proxy synapseclient

# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
#ENV LD_LIBRARY_PATH="/opt/conda/lib/R/lib:/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server"
ENV LD_LIBRARY_PATH="/opt/conda/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server"


#setting up R installation utils

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
	 Rscript -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")'

#install R packages

Run Rscript -e "install.packages('dplyr', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('stringr', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('qcc', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('data.table', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('reshape2', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('ggrepel', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e "install.packages('gplots', dependencies=TRUE, quiet=FALSE)" && \
	Rscript -e 'BiocManager::install("biomaRt", version = "3.8")' && \
	Rscript -e 'BiocManager::install("SWATH2stats", version = "3.8")'

#Run Rscript -e 'install.packages("synapser", repos=c("https://sage-bionetworks.github.io/ran", "http://cran.fhcrc.org"))' && \
#	Rscript -e 'install.packages("synapserutils", repos=c("https://sage-bionetworks.github.io/ran", "http://cran.fhcrc.org"))'

RUN conda install --quiet --yes \
	'libssh2' \
	'krb5' && \
	conda install --yes -c anaconda 'curl' && \
	conda clean -tipsy && \
    	fix-permissions $CONDA_DIR
