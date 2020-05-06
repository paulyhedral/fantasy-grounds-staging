#!/bin/bash

# set -x
set -e
set -o pipefail

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

fgdir=$1
if [ -z "$fgdir" ]; then
    echo "Usage: $0 <fantasy-grounds-dir>"
    exit 1
fi

pushd "$fgdir/extensions"
    for f in *.ext; do
        echo "Package: $f"
        # destdir=$(echo "${f:0:1}" | tr a-z A-Z)${f:1}
        "${scriptdir}/unpack.sh" "$fgdir/extensions/$f" "$scriptdir/Extensions" extension '/root/properties/name'
    done
popd

pushd "$fgdir/modules"
    for f in *.mod; do
        echo "Package: $f"
        # destdir=$(echo "${f:0:1}" | tr a-z A-Z)${f:1}
        "${scriptdir}/unpack.sh" "$fgdir/modules/$f" "$scriptdir/Modules" definition '/root/name'
    done
popd

pushd "$fgdir/rulesets"
    for f in *.pak; do
        echo "Package: $f"
        # destdir=$(echo "${f:0:1}" | tr a-z A-Z)${f:1}
        "${scriptdir}/unpack.sh" "$fgdir/rulesets/$f" "$scriptdir/Rulesets" base '/root/description/text'
    done
popd
