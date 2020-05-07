#!/bin/bash

# set -x
set -e
set -o pipefail

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pkg=$1
destdir=$2
base=$3
xpath=$4

if [ -z "$pkg" -o -z "$destdir" -o -z "$base" -o -z "$xpath" ]; then
    echo "Usage: $0 <package-path> <dest-dir> <xml-base-filename> <xpath>"
    echo "          <package-path> is the path and filename of the package to unpack"
    echo "          <dest-dir> is the location to unpack it, such as 'extensions', 'modules', 'rulesets'"
    echo "          <xml-base-filename> is the basename of the XML file for the package"
    echo "          <xpath> is the XPath query to the name of the package"
    exit 1
fi

echo "Unpacking $pkg to $destdir ..."
tmpdir=$(mktemp -d)
unzip -qq "$pkg" -d "$tmpdir"

# name=pkg-$$
name=$(xml sel -t -v $xpath "$tmpdir/$base.xml")
safename=$(echo "$name" | tr -s ' ' | tr ' ' '_' | tr -dC '[:alnum:]_')
mkdir -p "$destdir/$safename"

cp -Rp "$tmpdir/" "$destdir/$safename"
cat > "$destdir/$safename/.metadata" <<EOF
filename="$pkg"
name="$name"
EOF

rm -rf "$tmpdir"
