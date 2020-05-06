#!/bin/bash

# set -x
set -e
set -o pipefail

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pkg=$1
destdir=$2
base=$3
xpath=$4

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
