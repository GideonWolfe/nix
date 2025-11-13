#! @crossShell@

set -e

export PATH=/run/current-system/sw/bin/
mkdir -pv /boot/firmware/overlays
mount /boot/firmware

cp -v @fw@/{bootcode.bin,fixup.dat,start.elf,fixup4.dat,start4.elf,fixup4cd.dat,fixup_cd.dat,start4cd.elf,start_cd.elf,bcm2710*dtb,bcm2711*dtb,bcm2712*dtb} /boot/firmware
cat $1/kernel | gzip -9v > /boot/firmware/kernel8.img
cp -vL $1/initrd /boot/firmware/initrd
cp -vL $1/dtbs/overlays/* /boot/firmware/overlays/

echo "init=$1/init $(cat $1/kernel-params)" > /boot/firmware/cmdline.txt
cp -v @config_txt@ /boot/firmware/config.txt
