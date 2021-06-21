FROM centos:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ENV CELLRANGER_VERSION 6.0.2
ENV REFERENCE_VERSION 5.0.0
ENV PATH /opt/cellranger-${CELLRANGER_VERSION}:$PATH

RUN yum group install -y "Development Tools" \
    && yum install -y which

# https://support.10xgenomics.com/single-cell-vdj/software/downloads/6.0/
# cell ranger binaries
RUN curl -o cellranger-6.0.2.tar.gz "https://cf.10xgenomics.com/releases/cell-vdj/cellranger-6.0.2.tar.gz?Expires=1624326738&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC12ZGovY2VsbHJhbmdlci02LjAuMi50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MjQzMjY3Mzh9fX1dfQ__&Signature=YoUQCQZdnkU9LkVOpBTQIVuQjcAxB5nTAeYSg1cF2vwVL5q7dZhn2h9UZ5GQrgWRM-wALHMDhvxOcHr1xAxQ6r7yCxAySzciXILdnnzC71Uc2fMDzAYa-FTtoGKjQwTBjgCPVYsPhE1TxiSNQ9lPBGLWK28XKRmv0gDOxa1zanLvq-alpkaM1RRPROYYtfzpOc7v2jysPyvlFrP0TFMZ4gpHggZ~II4uWg~IHRLW6znaf55bq-QSk2K1GVePZq0~tKRfalVx2-8QNF4ucz4pMpIO6qGf-vE-qSv~UWAcqnw6B~mqjX075p84YNdyK-DZF5~D62nXrOp5aBKFYkHS7Q__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && tar xzf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && mv cellranger-${CELLRANGER_VERSION} /opt/

# V(D)J GRCh38 Reference - 5.0.0 (November 19, 2020)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCh38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCh38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCh38-alts-ensembl-${REFERENCE_VERSION} /opt/

# V(D)J GRCm38 Reference - 5.0.0 (November 19, 2020)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCm38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCm38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCm38-alts-ensembl-${REFERENCE_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCm38-alts-ensembl-${REFERENCE_VERSION} /opt/

WORKDIR /opt

ENTRYPOINT [ "cellranger" ]
