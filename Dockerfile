FROM centos:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ARG CELLRANGER_VERSION
ARG VDJ_REFERENCE_VERSION
ARG DOWNLOAD_URL
ENV PATH /opt/cellranger-${CELLRANGER_VERSION}:$PATH

RUN yum group install -y "Development Tools" \
    && yum install -y which

# cell ranger binaries
RUN curl -o cellranger-${CELLRANGER_VERSION}.tar.gz ${DOWNLOAD_URL} \
    && tar xzf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && mv cellranger-${CELLRANGER_VERSION} /opt/

# V(D)J GRCh38 Reference - 7.0.0 (May 17, 2022)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION} /opt/

# V(D)J GRCm38 Reference - 7.0.0 (May 17, 2022)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCm38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCm38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCm38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCm38-alts-ensembl-${VDJ_REFERENCE_VERSION} /opt/

WORKDIR /opt

ENTRYPOINT [ "cellranger" ]
