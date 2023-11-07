# Metagenomic CRISPR cas mining
A small pipeline to mine CRISPR cas systems from metagenomic samples. This is a containerized pipeline designed to be run on the AWS cloud. It reads metagenomic assemblies from S3 and mines them on the cloud. The data are parsed and deposited into an S3 bucket. Not shown here, but the output parquets are read by Athena for easy querying.
