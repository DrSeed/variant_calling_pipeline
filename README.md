
FastQC Analysis Workflow
This repository contains scripts designed to automate quality control checks on DNA sequencing data using FastQC. The scripts are intended to streamline the process of analyzing .fastq files, organizing FastQC output, and compiling summaries for a comprehensive quality assessment.

Overview
The repository includes two scripts:

FastQC Analysis Script: Automates the running of FastQC on .fastq files, organizes the output into a designated directory, and unzips the results for easy access.

FastQC Summary Compilation Script: Gathers all FastQC summary reports from the analysis output and compiles them into a single document for a concise overview of the quality metrics.

FastQC Analysis Script
This script performs the following operations:

Navigates to the directory containing .fastq files.
Initiates FastQC analysis on all .fastq files.
Creates a directory to store FastQC outputs and moves the results to this directory.
Unzips the FastQC result files for further inspection.
FastQC Summary Compilation Script
After FastQC analysis, this script:

Navigates to the directory with unzipped FastQC results.
Extracts the summary.txt from each FastQC output and compiles them into a single file, providing an aggregated view of the quality control checks.

The second script is a variant calling pipeline that performs the following steps

Preparation: Sets up the environment to halt on errors and navigates to the directory containing FastQC results.
Reference Genome Indexing: Indexes the reference genome using BWA for efficient alignment.
Directory Setup: Creates directories for storing intermediate files such as SAM, BAM, and variant calling files (BCF, VCF).
Alignment and Processing:
Aligns paired-end reads to the reference genome.
Converts the SAM format to BAM, filters unaligned reads, sorts, and indexes the BAM files.
Variant Calling:
Generates a pileup and calls raw variant candidates.
Applies variant calling producing a VCF file.
Filters the VCF to retain high-quality variants.

Prerequisites
To run this script, you need to have the following tools installed:

BWA: For aligning sequencing reads to the reference genome.
Samtools: For processing SAM/BAM alignment files.
BCFtools: For calling and manipulating variant calls (VCF/BCF).
Ensure these tools are accessible from your command line environment.

Customization
You may need to adjust file paths and parameters within the script to match your specific project setup, including the location of your FastQC results, the reference genome, and the input sequencing data.

Contributing
Suggestions for improvements, bug reports, and pull requests are welcome. Feel free to fork this repository and contribute.

