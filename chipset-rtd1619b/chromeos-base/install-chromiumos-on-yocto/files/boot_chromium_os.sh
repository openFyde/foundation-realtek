#!/bin/bash
INSTALL_ROOT=$(dirname "$0")

MOUNTS="/proc /dev /sys /tmp /run /var"

die() {
  echo "Error: $@"
  exit 1
}

mount_config() {
  mkdir -p /run/chromeos-config/v1
  mount ./usr/share/chromeos-config/configfs.img /run/chromeos-config/v1
}

cleanup() {
  local d
  for d in ${MOUNTS}; do
    umount -lf ".${d}"
  done
  umount /run/chromeos-config/v1
}

main() {
	cd "${INSTALL_ROOT}" || exit 1
#  local d
#  trap cleanup EXIT
#  mount_config
#  for d in ${MOUNTS}; do
#    mount -n --bind "${d}" ".${d}"
#    mount --make-slave ".${d}"
#  done
#  chroot
  ./usr/sbin/chromeos-firmwareupdate
  if [ $? -ne 0 ]; then
    die "Failed to update uboot and env"
  fi
  mv /boot/u-boot.bin-rtd1619b_emmc /boot/u-boot.bin-rtd1619b_emmc.bak
  cp boot/u-boot.bin-rtd1619b_emmc /boot
  sync
  read -p "Press Any key to reboot to Chromium OS"
  reboot
}

main $@
