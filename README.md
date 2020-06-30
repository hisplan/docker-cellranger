# docker-cellranger

Dockerized Cell Ranger v3.1.0

```
# cellranger vdj --help
/opt/cellranger-3.1.0/cellranger-cs/3.1.0/bin
cellranger vdj (3.1.0)
Copyright (c) 2019 10x Genomics, Inc.  All rights reserved.
-------------------------------------------------------------------------------

'cellranger vdj' assembles single-cell V(D)J immune receptor
sequences.

The commands below should be preceded by 'cellranger':

Usage:
    vdj
        --id=ID
        --fastqs=PATH
        [--sample=PREFIX]
        [--reference=DIR]
        [options]
    vdj <run_id> <mro> [options]
    vdj -h | --help | --version

Arguments:
    id      A unique run id, used to name output folder [a-zA-Z0-9_-]+.
    fastqs  Path of folder created by mkfastq or bcl2fastq.
    sample  Prefix of the filenames of FASTQs to select.
    reference   Path of folder containing 10x-compatible VDJ reference.
                    Optional if --denovo is specified.

Options:
# Single Cell V(D)J assembly
    --description=TEXT  Sample description to embed in output files.
    --denovo            Run in reference-free mode (do not use annotations).
    --force-cells=NUM   Force pipeline to use this number of cells, bypassing
                            the cell detection algorithm.
    --inner-enrichment-primers=INNER_ENRICHMENT_PRIMERS  If inner enrichment primers
                                                             other than those
                                                             provided in the 10x
                                                             kits are used, they
                                                             need to be specified
                                                             here as a textfile
                                                             with one primer per line.
    --lanes=NUMS        Comma-separated lane numbers.
    --indices=INDICES   Comma-separated sample index set "SI-001" or sequences.
    --project=TEXT      Name of the project folder within a mkfastq or
                            bcl2fastq-generated folder to pick FASTQs from.

# Martian Runtime
    --jobmode=MODE      Job manager to use. Valid options:
                            local (default), sge, lsf, or a .template file
    --localcores=NUM    Set max cores the pipeline may request at one time.
                            Only applies to local jobs.
    --localmem=NUM      Set max GB the pipeline may request at one time.
                            Only applies to local jobs.
    --localvmem=NUM     Set max virtual address space in GB for the pipeline.
                            Only applies to local jobs.
    --mempercore=NUM    Reserve enough threads for each job to ensure enough
                        memory will be available, assuming each core on your
                        cluster has at least this much memory available.
                            Only applies in cluster jobmodes.
    --maxjobs=NUM       Set max jobs submitted to cluster at one time.
                            Only applies in cluster jobmodes.
    --jobinterval=NUM   Set delay between submitting jobs to cluster, in ms.
                            Only applies in cluster jobmodes.
    --overrides=PATH    The path to a JSON file that specifies stage-level
                            overrides for cores and memory.  Finer-grained
                            than --localcores, --mempercore and --localmem.
                            Consult the 10x support website for an example
                            override file.
    --uiport=PORT       Serve web UI at http://localhost:PORT
    --disable-ui        Do not serve the UI.
    --noexit            Keep web UI running after pipestance completes or fails.
    --nopreflight       Skip preflight checks.

    -h --help           Show this message.
    --version           Show version.

Note: 'cellranger vdj' can be called in two ways, depending on how you
demultiplexed your BCL data into FASTQ files.

1. If you demultiplexed with 'cellranger mkfastq' or directly with
   Illumina bcl2fastq, then set --fastqs to the project folder containing
   FASTQ files. In addition, set --sample to the name prefixed to the FASTQ
   files comprising your sample. For example, if your FASTQs are named:
       subject1_S1_L001_R1_001.fastq.gz
   then set --sample=subject1

2. If you demultiplexed with 'cellranger demux', then set --fastqs to a
   demux output folder containing FASTQ files. Use the --lanes and --indices
   options to specify which FASTQ reads comprise your sample.
   This method is deprecated. Please use 'cellranger mkfastq' going forward.
```