#!/bin/bash
#This is required to build the stuff

set -euo pipefail

#Add here what kind of dependencies you need in general
#Check for packages here: https://pkgs.alpinelinux.org/packages
apk --update add wget curl build-base git ca-certificates openjdk8-jre unzip bash

# Temp dir for downloading and building stuff
TMPDIR=/build

mkdir $TMPDIR
cd $TMPDIR

# the installation directory of snpEff
INSTALLDIR=/usr/local/lib
BINDIR=/usr/local/bin

# Download snpEff version 4.3p
wget -P $TMPDIR http://sourceforge.net/projects/snpeff/files/snpEff_v4_3t_core.zip

# Unzip snpEff archive
ls $TMPDIR | xargs -i unzip "$TMPDIR/{}" -d $INSTALLDIR

echo "#!/bin/sh" > $BINDIR/snpEff

echo "java -jar $INSTALLDIR/snpEff/snpEff.jar \$*" >> $BINDIR/snpEff

chmod +x $BINDIR/snpEff

# snpEff needs a data directory to which it can write
# (Downloading reference genomes for example)
mkdir $INSTALLDIR/snpEff/data
chmod 777 -R $INSTALLDIR/snpEff/data

# Remove tmp snpEff directory
rm -rf $TMPDIR

#Clean up
rm -rf /var/cache/apk/*

cd /
rm -rf /build
