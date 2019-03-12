FROM jupyter/r-notebook

USER root

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		libapparmor1 \
		libedit2 \
		lsb-release \ 
		libssl1.0.0 \
		psmisc \
		libcurl4-openssl-dev \
		;

RUN apt-get update && \
    apt-get -y install --fix-missing libxml2-dev

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# You can use rsession from rstudio's desktop package as well.
ENV RSTUDIO_PKG=rstudio-server-1.1.463-amd64.deb

RUN wget -q http://download2.rstudio.org/${RSTUDIO_PKG}
RUN dpkg -i ${RSTUDIO_PKG}
RUN rm ${RSTUDIO_PKG}

USER $NB_USER

RUN conda install --yes \
	'libssh2' \
	'krb5' && \
	conda clean -tipsy

RUN pip install jupyter-server-proxy
RUN pip install jupyter-rsession-proxy

# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
#ENV LD_LIBRARY_PATH="/opt/conda/lib/R/lib:/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server"
ENV LD_LIBRARY_PATH="/opt/conda/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server"

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
    Rscript -e "install.packages('devtools')" \
    -e "install.packages('ggplot2', dependencies=TRUE)" \
    -e "install.packages('ggrepel', dependencies=TRUE)" \
    -e "install.packages('dplyr', dependencies=TRUE)" \
    -e "install.packages('stringr', dependencies=TRUE)" \
    -e "install.packages('qcc', dependencies=TRUE)" \
    -e "install.packages('data.table', dependencies=TRUE)" \
    -e "install.packages('reshape2', dependencies=TRUE)"

#install R packages
RUN Rscript -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")'
RUN Rscript -e 'BiocManager::install("biomaRt", version = "3.8")'
RUN Rscript -e 'BiocManager::install("SWATH2stats", version = "3.8")'

RUN conda install --yes -c anaconda \
        'curl' && \
        conda clean -tipsy

