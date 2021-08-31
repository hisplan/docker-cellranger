# docker-cellranger

Dockerized Cell Ranger v6.0.2

- GEX: https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/6.0/
- VDJ: https://support.10xgenomics.com/single-cell-vdj/software/downloads/6.0/

Reference dataset included:

- Human reference dataset (GRCh38/Ensembl/10x) required for Cell Ranger V(D)J
- Mouse reference dataset (GRCm38/Ensembl/10x) required for Cell Ranger V(D)J

## Build Container Image

SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/) is required for smooth and uninteruppted build process (e.g. CI/CD). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING in your environment.

[SCING](https://github.com/hisplan/scing) installation is required

```bash
conda activate scing

./build.sh
```

## Push to Docker Registry

```bash
conda activate scing

./push.sh
```

## Usage

```bash
$ cellranger --help
cellranger cellranger-6.0.2
Process 10x Genomics Gene Expression, Feature Barcode, and Immune Profiling data

USAGE:
    cellranger <SUBCOMMAND>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    count               Count gene expression (targeted or whole-transcriptome) and/or feature barcode reads from a
                        single sample and GEM well
    multi               Analyze multiplexed data or combined gene expression/immune profiling/feature barcode data
    vdj                 Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries
    aggr                Aggregate data from multiple Cell Ranger runs
    reanalyze           Re-run secondary analysis (dimensionality reduction, clustering, etc)
    targeted-compare    Analyze targeted enrichment performance by comparing a targeted sample to its cognate parent
                        WTA sample (used as input for targeted gene expression)
    targeted-depth      Estimate targeted read depth values (mean reads per cell) for a specified input parent WTA
                        sample and a target panel CSV file
    mkvdjref            Prepare a reference for use with CellRanger VDJ
    mkfastq             Run Illumina demultiplexer on sample sheets that contain 10x-specific sample index sets
    testrun             Execute the 'count' pipeline on a small test dataset
    mat2csv             Convert a gene count matrix to CSV format
    mkref               Prepare a reference for use with 10x analysis software. Requires a GTF and FASTA
    mkgtf               Filter a GTF file by attribute prior to creating a 10x reference
    upload              Upload analysis logs to 10x Genomics support
    sitecheck           Collect linux system configuration information
    help                Prints this message or the help of the given subcommand(s)
```

## GEX

```bash
$ cellranger count --help
cellranger-count
Count gene expression (targeted or whole-transcriptome) and/or feature barcode reads from a single sample and GEM well

USAGE:
    cellranger count [FLAGS] [OPTIONS] --id <ID> --transcriptome <PATH>

FLAGS:
        --no-bam                  Do not generate a bam file
        --nosecondary             Disable secondary analysis, e.g. clustering. Optional
        --include-introns         Include intronic reads in count
        --no-libraries            Proceed with processing using a --feature-ref but no Feature Barcode libraries
                                  specified with the 'libraries' flag
        --no-target-umi-filter    Turn off the target UMI filtering subpipeline. Only applies when --target-panel is
                                  used
        --dry                     Do not execute the pipeline. Generate a pipeline invocation (.mro) file and stop
        --disable-ui              Do not serve the web UI
        --noexit                  Keep web UI running after pipestance completes or fails
        --nopreflight             Skip preflight checks
    -h, --help                    Prints help information

OPTIONS:
        --id <ID>                 A unique run id and output folder name [a-zA-Z0-9_-]+
        --description <TEXT>      Sample description to embed in output files [default: ]
        --transcriptome <PATH>    Path of folder containing 10x-compatible transcriptome reference
        --fastqs <PATH>...        Path to input FASTQ data
        --project <TEXT>          Name of the project folder within a mkfastq or bcl2fastq-generated folder to pick
                                  FASTQs from
        --sample <PREFIX>...      Prefix of the filenames of FASTQs to select
        --lanes <NUMS>...         Only use FASTQs from selected lanes
        --libraries <CSV>         CSV file declaring input library data sources
        --feature-ref <CSV>       Feature reference CSV file, declaring Feature Barcode constructs and associated
                                  barcodes
        --target-panel <CSV>      The target panel CSV file declaring the target panel used, if any
        --expect-cells <NUM>      Expected number of recovered cells
        --force-cells <NUM>       Force pipeline to use this number of cells, bypassing cell detection. [MINIMUM: 10]
        --r1-length <NUM>         Hard trim the input Read 1 to this length before analysis
        --r2-length <NUM>         Hard trim the input Read 2 to this length before analysis
        --chemistry <CHEM>        Assay configuration. NOTE: by default the assay configuration is detected
                                  automatically, which is the recommened mode. You usually will not need to specify a
                                  chemistry. Options are: 'auto' for autodetection, 'threeprime' for Single Cell 3',
                                  'fiveprime' for  Single Cell 5', 'SC3Pv1' or 'SC3Pv2' or 'SC3Pv3' for Single Cell 3'
                                  v1/v2/v3, 'SC3Pv3LT' for Single Cell 3' v3 LT, 'SC5P-PE' or 'SC5P-R2' for Single Cell
                                  5', paired-end/R2-only, 'SC-FB' for Single Cell Antibody-only 3' v2 or 5' [default:
                                  auto]
        --jobmode <MODE>          Job manager to use. Valid options: local (default), sge, lsf, slurm or a .template
                                  file. Search for help on "Cluster Mode" at support.10xgenomics.com for more details on
                                  configuring the pipeline to use a compute cluster [default: local]
        --localcores <NUM>        Set max cores the pipeline may request at one time. Only applies to local jobs
        --localmem <NUM>          Set max GB the pipeline may request at one time. Only applies to local jobs
        --localvmem <NUM>         Set max virtual address space in GB for the pipeline. Only applies to local jobs
        --mempercore <NUM>        Reserve enough threads for each job to ensure enough memory will be available,
                                  assuming each core on your cluster has at least this much memory available. Only
                                  applies in cluster jobmodes
        --maxjobs <NUM>           Set max jobs submitted to cluster at one time. Only applies in cluster jobmodes
        --jobinterval <NUM>       Set delay between submitting jobs to cluster, in ms. Only applies in cluster jobmodes
        --overrides <PATH>        The path to a JSON file that specifies stage-level overrides for cores and memory.
                                  Finer-grained than --localcores, --mempercore and --localmem. Consult the 10x support
                                  website for an example override file
        --uiport <PORT>           Serve web UI at http://localhost:PORT
```

## V(D)J

```bash
$ cellranger vdj --help
cellranger-vdj
Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries

USAGE:
    cellranger vdj [FLAGS] [OPTIONS] --id <ID>

FLAGS:
        --denovo         Run in reference-free mode (do not use annotations)
        --dry            Do not execute the pipeline. Generate a pipeline invocation (.mro) file and stop
        --disable-ui     Do not serve the web UI
        --noexit         Keep web UI running after pipestance completes or fails
        --nopreflight    Skip preflight checks
    -h, --help           Prints help information

OPTIONS:
        --id <ID>                            A unique run id and output folder name [a-zA-Z0-9_-]+
        --description <TEXT>                 Sample description to embed in output files [default: ]
        --reference <PATH>                   Path of folder containing 10x-compatible VDJ reference. Optional if
                                             '--denovo' is specified
        --fastqs <PATH>...                   Path to input FASTQ data
        --project <TEXT>                     Name of the project folder within a mkfastq or bcl2fastq-generated folder
                                             to pick FASTQs from
        --sample <PREFIX>...                 Prefix of the filenames of FASTQs to select
        --lanes <NUMS>...                    Only use FASTQs from selected lanes
        --chain <CHAIN_SPEC>                 Chain type to display metrics for: 'TR' for T cell receptors, 'IG' for B
                                             cell receptors, or 'auto' to autodetect [default: auto]
        --inner-enrichment-primers <PATH>    If inner enrichment primers other than those provided in the 10x kits are
                                             used, they need to be specified here as a textfile with one primer per
                                             line. Disable secondary analysis, e.g. clustering
        --jobmode <MODE>                     Job manager to use. Valid options: local (default), sge, lsf, slurm or a
                                             .template file. Search for help on "Cluster Mode" at
                                             support.10xgenomics.com for more details on configuring the pipeline to use
                                             a compute cluster [default: local]
        --localcores <NUM>                   Set max cores the pipeline may request at one time. Only applies to local
                                             jobs
        --localmem <NUM>                     Set max GB the pipeline may request at one time. Only applies to local jobs
        --localvmem <NUM>                    Set max virtual address space in GB for the pipeline. Only applies to local
                                             jobs
        --mempercore <NUM>                   Reserve enough threads for each job to ensure enough memory will be
                                             available, assuming each core on your cluster has at least this much memory
                                             available. Only applies in cluster jobmodes
        --maxjobs <NUM>                      Set max jobs submitted to cluster at one time. Only applies in cluster
                                             jobmodes
        --jobinterval <NUM>                  Set delay between submitting jobs to cluster, in ms. Only applies in
                                             cluster jobmodes
        --overrides <PATH>                   The path to a JSON file that specifies stage-level overrides for cores and
                                             memory. Finer-grained than --localcores, --mempercore and --localmem.
                                             Consult the 10x support website for an example override file
        --uiport <PORT>                      Serve web UI at http://localhost:PORT
```