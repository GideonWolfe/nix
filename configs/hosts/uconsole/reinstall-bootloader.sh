#! @crossShell@

set -e

DEST=${DEST:-/boot/}

export PATH=/run/current-system/sw/bin/:$PATH
mkdir -pv ${DEST}firmware/overlays

mount ${DEST}firmware || true

cp -v @fw@/{bootcode.bin,fixup.dat,start.elf,fixup4.dat,start4.elf,fixup4cd.dat,fixup_cd.dat,start4cd.elf,start_cd.elf} ${DEST}firmware

cp -v ${1}/dtbs/overlays/*.dtbo ${DEST}firmware/overlays
cp -v ${1}/dtbs/broadcom/{bcm2710*dtb,bcm2711*dtb,bcm2712*dtb} ${DEST}firmware

cat $1/kernel | gzip -9v > ${DEST}firmware/kernel8.img
cp -vL $1/initrd ${DEST}firmware/initrd

echo "init=$1/init $(cat $1/kernel-params)" > ${DEST}firmware/cmdline.txt
cp -v @config_txt@ ${DEST}firmware/config.txt
