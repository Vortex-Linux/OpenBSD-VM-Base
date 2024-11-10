#!/bin/bash 

echo "Shutting down the OpenBSD VM..." 

echo y | ship --vm shutdown openbsd-vm-base 

echo "Compressing the OpenBSD VM disk image..."

ship --vm compress openbsd-vm-base 

echo "Copying the OpenBSD VM disk image to generate the release package for 'openbsd-vm-base'..."

DISK_IMAGE=$(sudo virsh domblklist openbsd-vm-base | grep .qcow2 | awk '{print $2}')

cp "$DISK_IMAGE" output/openbsd.qcow2

echo "Splitting the copied disk image into two parts..."

split -b $(( $(stat -c%s "output/openbsd.qcow2") / 2 )) -d -a 3 "output/openbsd.qcow2" "output/openbsd.qcow2."

echo "The release package for 'openbsd-vm-base' has been generated and split successfully!"

