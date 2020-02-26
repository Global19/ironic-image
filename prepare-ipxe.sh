#!/bin/bash
#
# prepare-ipxe copies the right images to /tftpboot, later when the
# shared volume is created, rundnsmasq will copy them there to
# /shared/tftpboot. We do this as a two-step operation to ensure all
# the expected images are available at build-time. Otherwise the CI
# jobs that build these images could succeed, but provisioning
# will actually fail without the images present.

set -ex

mkdir -p /tftpboot

cp /usr/share/ipxe/undionly.kpxe /tftpboot/
cp /usr/share/ipxe/ipxe-snponly-x86_64.efi /tftpboot/snponly.efi

if [ -f "/usr/share/ipxe/ipxe.efi" ]; then
    cp /usr/share/ipxe/ipxe.efi /tftpboot/ipxe.efi
elif [ -f "/usr/share/ipxe/ipxe-x86_64.efi" ]; then
    cp  /usr/share/ipxe/ipxe-x86_64.efi /tftpboot/ipxe.efi
else
    echo "Fatal Error - Failed to find ipxe binary"
    exit 1
fi
