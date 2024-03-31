set -e  # Exit immediately if a command exits with a non-zero status, ensuring errors are not ignored

# Change directory to where the results of FastQC on untrimmed reads are stored
cd /mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/results 

# Define the path to the reference genome
genome=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/ecoli_rel606.fasta

# Index the reference genome using BWA for faster alignment
bwa index $genome

# Create directories to store SAM, BAM, BCF, and VCF files if they don't already exist
mkdir -p sam bam bcf vcf

# Loop through each paired-end fastq file in the trimmed_fastq_small directory
for fq1 in /mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/data/trimmed_fastq_small/*_1.trim.sub.fastq
do
    echo "working with file $fq1"  # Print the current file being processed

    # Extract the base name of the file without the suffix for naming outputs
    base=$(basename $fq1 _1.trim.sub.fastq)
    echo "base name is $base"

    # Define paths to the input fastq files, SAM, BAM, sorted BAM, raw BCF, variant VCF, and final variant VCF files
    fq1=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/data/trimmed_fastq_small/${base}_1.trim.sub.fastq
    fq2=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/data/trimmed_fastq_small/${base}_2.trim.sub.fastq
    sam=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/sam${base}.aligned.sam
    bam=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/bam${base}.aligned.bam
    sorted_bam=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/bam/${base}.aligned.sorted.bam
    raw_bcf=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/bcf/${base}_raw.bcf
    variants=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/bcf/${base}_variants.vcf
    final_variants=/mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/trimmed_fastq/ref_genome/results/vcf/${base}_final_variants.vcf

    # Align reads to the reference genome using BWA and output to a SAM file
    bwa mem $genome $fq1 $fq2 > $sam
    # Convert SAM to BAM, filtering out unaligned reads with samtools view
    samtools view -S -b $sam > $bam
    # Sort the BAM file by coordinates
    samtools sort -o $sorted_bam $bam
    # Index the sorted BAM file for faster access
    samtools index $sorted_bam
    # Generate a BCF file of the pileup, calling raw variant candidates
    bcftools mpileup -O b -o $raw_bcf -f $genome $sorted_bam
    # Call variants using a Bayesian model, outputting into a VCF file
    bcftools call --ploidy 1 -m -v -o $variants $raw_bcf
    # Filter the VCF for high-quality variants, outputting the final variants
    vcfutils.pl varFilter $variants > $final_variants

done  # End of the for loop

