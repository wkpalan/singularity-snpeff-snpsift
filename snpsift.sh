#!/bin/bash
#This is required to build the stuff

set -euo pipefail

# Temp dir for downloading and building stuff
TMPDIR=/build

mkdir $TMPDIR
cd $TMPDIR

# the installation directory of snpEff
INSTALLDIR=/usr/local/lib
BINDIR=/usr/local/bin

echo "#!/bin/sh" > $BINDIR/SnpSift

echo "java -jar $INSTALLDIR/snpEff/SnpSift.jar \$*" >> $BINDIR/SnpSift

chmod +x $BINDIR/SnpSift

# Remove tmp snpEff directory
rm -rf $TMPDIR

#Clean up
rm -rf /var/cache/apk/*

cd /
rm -rf /build
