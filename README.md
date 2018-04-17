# qbic-singularity-snpeff
[![DOI](https://zenodo.org/badge/107653854.svg)](https://zenodo.org/badge/latestdoi/107653854)

This is a containerized version of the genetic variant annotation tool [SnpEff](http://snpeff.sourceforge.net/). We use [Singularity](http://singularity.lbl.gov/) as container technology.

## Bootstrap files with tags
We provide always a bootstrap file (`Singularity`) tagged `.latest` which represents the most resent development status of the container. If you see version tags like `.v1.0`, this means that this is the recipe of a container with a stable version tag.

## How to build the container

Clone the repository:

```bash
git clone https://github.com/qbicsoftware/qbic-singularity-snpeff.git
cd qbic-singularity-snpeff
```

Since Singularity 2.4, the build command from file looks like this:

```bash
sudo singularity build myContainer.simg <Singularity file>
```

You can also download the build and ready-to-use container from Singularity Hub:

```bash
singularity pull shub://qbicsoftware/qbic-singularity-snpeff:latest
singularity pull shub://qbicsoftware/qbic-singularity-snpeff:v1.0
...
```

## How to run the container and calling SnpEff
To run the container and calling SnpEff you just need to 

```bash
singularity exec myContainer.simg snpEff [arguments]
singularity exec myContainer.simg snpEff -h
```

## Defining the reference genome
Providing them inside of the container would make the container big, so we think it is a better idea to mount the reference genome into the right folder inside the container, where snpEff automatically searches for reference genome databases.

You can simple download the databases, unzip them on your filesystem, and bind its `data` directory into the container. If you use snpEff's `-v` verbose output option, you will see that it will find the pre-installed databases and will not try to download it.

Here is an example, where we downloaded the **hg19** reference genome with 

```bash
wget http://downloads.sourceforge.net/project/snpeff/databases/v4_3/snpEff_v4_3_hg19.zip
```
on the host filesystem, unzipped it and bound it during the container execution.

```bash
singularity exec -B ./data/:/usr/local/lib/snpEff/data snpEff.simg snpEff -v hg19 myVCF.vcf
```


## Author

* [Sven Fillinger](https://github.com/sven1103)
