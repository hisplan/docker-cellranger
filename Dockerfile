FROM centos:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ENV CELLRANGER_VERSION 4.0.0

ENV PATH /opt/cellranger-${CELLRANGER_VERSION}:$PATH

RUN yum group install -y "Development Tools" \
    && yum install -y which

# https://support.10xgenomics.com/single-cell-vdj/software/downloads/4.0
# cell ranger binaries
RUN curl -o cellranger-4.0.0.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-4.0.0.tar.gz?Expires=1598586910&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci00LjAuMC50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE1OTg1ODY5MTB9fX1dfQ__&Signature=NXSW38hrpow5OBuBI~xZD5Rtx~u7-lh1v60f0sJ0gnGdRTqC1ClazkUSj03gMSr6s0Y1jle69NI8DaP6mHJdyP0YHDIIfejn1StiCcNp02GmCjkik4eZwWTiowmD1V5gv1FRa~h1CQifIDULl6BOxfX5XHW~KAxZftfHBHvlrk7cPcYiYwTJTVtWoRURYaqSQSJ3KluhYhaWeJIqDh56oXaK7H00Cj9viSBN3vBcNC7euJL192C5D7pctMJyKAxax6NavzKRxwELaLYHVns6nBVa6w9AwSShmU2PEYD6DLM7XtQJi5nnQzS1EV9G6y2KYjzrWyEfZhu74cHJ7td1yg__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && tar xzf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && mv cellranger-${CELLRANGER_VERSION} /opt/

# V(D)J GRCh38 Reference - 4.0.0 (July 7, 2020)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION} /opt/

# V(D)J GRCm38 Reference - 4.0.0 (July 7, 2020)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION} /opt/

WORKDIR /opt
