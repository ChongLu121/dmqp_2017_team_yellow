FROM centos:latest

MAINTAINER DMQB_yellow

# Setting the working directory to /Tss_workflow
WORKDIR /Tss_workflow

# Install prerequisites
RUN yum -y upgrade
RUN yum -y install wget
RUN yum -y install unzip bzip2 gcc gcc-c++ make ncurses-devel ncurses xz-devel zlib-devel bzip2-devel-1.0.6-13.el7.x86_64

# Install samtools
RUN mkdir /st && cd /st/ && wget --no-check-certificate -O /st/samtools.tar.bz2 http://sourceforge.net/projects/samtools/files/samtools/1.5/samtools-1.5.tar.bz2/download && \
  bunzip2 samtools.tar.bz2 && \
  tar xf samtools.tar && \
  cd samtools-1.5 && \
  make
  
# Set global path for samtools:
ENV PATH /st/samtools-1.5:$PATH

# Run samtools 
ENTRYPOINT samtools view -b ${samfile} -o ${samfile/.sam/_r.bam} && \
  samtools sort ${samfile/.sam/_r.bam} -o ${samfile/_r.bam/.bam}