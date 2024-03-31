set -e  # This command tells the script to stop immediately if any command fails, ensuring errors are caught early.

# Changes the current directory to where the FastQC files are located. Think of it as navigating to a specific folder on your computer.
cd /mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc

echo "Running FastQC ..."  # Prints a message to let you know that the FastQC quality control checks are starting.

# Runs FastQC on all files ending with '.fastq' in the current directory. FastQC is a tool that assesses the quality of DNA sequencing data.
fastqc *.fastq*

# Creates a new directory (folder) to store the FastQC results. The '-p' option ensures no error if the directory already exists.
mkdir -p ~/results/fastqc_untrimmed_reads

echo "Saving FastQC results..."  # Prints a message indicating that the results are being saved.

# Moves the FastQC results, which are in '.zip' and '.html' format, to the newly created directory for organized storage.
mv *.zip ~/results/fastqc_untrimmed_reads/
mv *.html ~/results/fastqc_untrimmed_reads/

# Changes the current directory to where the FastQC results were moved. It's like opening the folder where we just moved our files.
cd ~/results/fastqc_untrimmed_reads/

echo "Unzipping..."  # Prints a message to indicate that the zipped FastQC result files are being unzipped.

# Loops through each '.zip' file in the current directory and unzips it. This is like extracting files from a compressed folder one by one.
for filename in *.zip
do
    unzip $filename
done

echo "Saving summary..."  # Prints a message indicating that a summary of the results is being compiled.

# This line is intended to concatenate the contents of all 'summary.txt' files into one
cat */summary.txt > /mnt/c/Users/phili/Downloads/New_folder_3/untrimmed_fastqc/docs/fastqc_summaries.txt

# What it does: It takes the summary.txt file from each FastQC result folder, combines them, and saves them to a single file for an overview.

