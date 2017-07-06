FROM centos:latest

MAINTAINER DMQB_yellow

# Setting the working directory to /Tss_workflow
WORKDIR /Tss_workflow

# Install prerequisites
RUN yum -y upgrade
RUN yum -y install wget
RUN yum -y install zip unzip

# Install bowtie2
RUN wget --no-check-certificate -O bowtie.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.7/bowtie2-2.2.7-linux-x86_64.zip/download && \
  unzip bowtie.zip -d /bt/ && \
  ln -s /bt/bowtie2-2.2.7/ /bt/bowtie && \
  rm bowtie.zip

# Set global path for bowtie2:
ENV PATH /bt/bowtie2-2.2.7:$PATH

# Run bowtie2:
ENTRYPOINT bowtie2-build -p ${fasta} ${indeces} && \
  bowtie2-align-s -x ${indeces} -U ${fastq} -S ${fastq/fastq/sam}