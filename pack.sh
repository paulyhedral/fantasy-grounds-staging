#!/bin/bash

set -x
set -e
set -o pipefail

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

dir=$1

pushd "$dir"

source .metadata
pkgname=$(basename "$filename")

zip -9r -x@../../.zipignore "$pkgname" .
open .

popd
