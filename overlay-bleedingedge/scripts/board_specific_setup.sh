BOARD_UBOOT="u-boot.bin-rtd1619b_emmc"

install_realtek_boot_scr() {
  local image="$1"
  local efi_offset_sectors=$(partoffset "$1" 12)
  local efi_size_sectors=$(partsize "$1" 12)
  local efi_offset=$((efi_offset_sectors * 512))
  local efi_size=$((efi_size_sectors * 512))
  local efi_dir=$(mktemp -d)
	info "Copy u-boot for ${FLAGS_board}"
	sudo dd if=${ROOT}/boot/${BOARD_UBOOT} of=$image seek=$((0x280)) conv=notrunc,fdatasync
	if [ $? -ne 0 ]; then
		die "failed to transfer ${BOARD_UBOOT} to ${image} offset:$((0x280))"
  fi
  info "Mounting EFI partition"
  sudo mount -o loop,offset=${efi_offset},sizelimit=${efi_size} "$1" \
    "${efi_dir}"

  info "Copying /boot/boot.scr.uimg"
  if [ ! -d "${efi_dir}/boot" ]; then
    sudo mkdir ${efi_dir}/boot
  fi
  sudo cp "${ROOT}/boot/boot-A.scr.uimg" "${efi_dir}/boot/boot.scr.uimg"
  sudo umount "${efi_dir}"
  rmdir "${efi_dir}"

  info "Installed /boot/boot.scr.uimg"

}

board_setup() {
  install_realtek_boot_scr "$1"
}
