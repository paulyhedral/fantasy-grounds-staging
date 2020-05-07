#!/bin/bash

set -x
set -e
set -o pipefail

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pkgpath=$1
if [ -z "$pkgpath" ]; then
    echo "Usage: $0 <package-path>"
    exit 1
fi

"${scriptdir}/unpack.sh" "$pkgpath" "$scriptdir/Modules" definition '/root/name'
