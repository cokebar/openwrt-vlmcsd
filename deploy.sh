#!/bin/bash

cd /tmp/
git clone https://${GH_USER}:${TOKEN}@github.com/${GH_USER}/${GH_REPO}.git --branch gh-pages \
--single-branch gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors
cd gh-pages || exit 1
git config user.name "cokebar"
git config user.email "cokebar@cokebar.info"
cp $TRAVIS_BUILD_DIR/*.ipk .
#$TRAVIS_BUILD_DIR/sdk/$SDK_DIR/scripts/ipkg-make-index.sh . > Packages
#gzip -c Packages > Packages.gz
DATE=$(date "+%Y-%m-%d")
cat > README.md <<EOF
OpenWrt repository for ${PACKAGE}
========
Binaries built from this repository on $DATE can be downloaded from http://${USER}.github.io/${REPO}/tree/gh-pages
EOF
git add -A
#git pull
git commit -a -m "Deploy Travis build $TRAVIS_BUILD_NUMBER to gh-pages"
#git push -fq origin gh-pages:gh-pages > /dev/null 2>&1 || exit 1
git push -fq origin gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors
#git push -f origin gh-pages:gh-pages
echo -e "Uploaded files to gh-pages\n"
cd -
