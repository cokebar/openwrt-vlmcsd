#filename:deploy.sh
#!/bin/bash
# Deploy binaries built with travis-ci to GitHub Pages,
# where they can be accessed by OpenWrt opkg directly
cd /tmp/
git clone https://${USER}:${TOKEN}@github.com/${USER}/${REPO}.git --branch gh-pages \
--single-branch gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors
cd gh-pages || exit 1
git config user.name "cokebar"
git config user.email "cokebar@cokebar.info"
mkdir -p ${OSVER}
pushd $OSVER
cp $TRAVIS_BUILD_DIR/*.ipk .
$TRAVIS_BUILD_DIR/sdk/$SDK_DIR/scripts/ipkg-make-index.sh . > Packages
gzip -c Packages > Packages.gz
cat > index.html <<EOF
<html><body><pre>
echo "src/gz announce http://${USER}.github.io/${REPO}/${OSVER}" >> /etc/opkg.conf
opkg update
opkg install ${PACKAGE}
</pre></body></html>
EOF
DATE=$(date "+%Y-%m-%d")
cat > README.md <<EOF
OpenWrt repository for ${PACKAGE}
========
Binaries built from this repository on $DATE can be downloaded from http://${USER}.github.io/${REPO}/.
To install the ${PACKAGE} package, run
\`\`\`
echo "src/gz announce http://${USER}.github.io/${REPO}/${OSVER}" >> /etc/opkg.conf
opkg update
opkg install ${PACKAGE}
\`\`\`
EOF
git add -A
popd
#git pull
git commit -a -m "Deploy Travis build $TRAVIS_BUILD_NUMBER to gh-pages"
#git push -fq origin gh-pages:gh-pages > /dev/null 2>&1 || exit 1
git push -fq origin gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors
#git push -f origin gh-pages:gh-pages
echo -e "Uploaded files to gh-pages\n"
cd -
