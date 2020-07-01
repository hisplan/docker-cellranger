FROM centos:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ENV CELLRANGER_VERSION 3.1.0

ENV PATH /opt/cellranger-${CELLRANGER_VERSION}:$PATH

RUN yum group install -y "Development Tools" \
    && yum install -y which

# https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/3.1
# cell ranger binaries
RUN curl -o cellranger-${CELLRANGER_VERSION}.tar.gz "http://cf.10xgenomics.com/releases/cell-exp/cellranger-3.1.0.tar.gz?Expires=1593576462&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9jZWxsLWV4cC9jZWxscmFuZ2VyLTMuMS4wLnRhci5neiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTU5MzU3NjQ2Mn19fV19&Signature=S7ldit6Oxu1WoQqYw3vT2hEmiMaJQ5hnl7SpoPLpq1oQMLy-khCSPiv~oXemAHBR2RkmlTFO2t-L8sPLAldy2DhQIjgU7fL~ZiuJv6JpAPRaggQYR1S6kuF6w2vBzZ27iLO~AJ1N~diOjLxl6gCL3AhFUq3qLG3ImWFaZruJFCV6kal~XdpmOm9sLPTjZ5QDeeInKLLamQPVWTY6J8lS3T3vxnm5NTCwiz66OZxvlu5DXRta5ziF7kVsyvzn5DCu9Thz3qRUXjlEDAycEU1rwBy2N4BpWJ6LNOUNrXYDIiSprYfrQhOu4k7Htw5Bn6dAYCzZ3rDhYWkddfmDCL37dA__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && tar xzf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && mv cellranger-${CELLRANGER_VERSION} /opt/

# human reference
RUN curl -O http://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCh38-alts-ensembl-${CELLRANGER_VERSION} /opt/

# # mouse reference
RUN curl -O http://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCm38-alts-ensembl-${CELLRANGER_VERSION} /opt/

WORKDIR /opt
