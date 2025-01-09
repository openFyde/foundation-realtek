_cros-kernel_emit_its_script() {
  local its_out=${1}
  local kernel_dir=${2}
  local dtb=${3}
  local its_template=${CHIPSET_RTD1619B_BASHRC_FILESDIR}/image.its
  kernel_bin_path="${kernel_dir}/$(_cros-kernel_get_compressed_path)"
  cat ${its_template} | sed "s#BOOT_IMG#${kernel_bin_path}#g" | \
    sed "s#BOARD_DTB#${dtb}#g" > $its_out
  wait
}

cros_post_src_install_add_rawimage_dtbs() {
  local install_prefix=/boot
  local install_dir="${D}${install_prefix}"
  local kernel_dir="$(cros-workon_get_build_dir)"
  local kernel_arch=${CHROMEOS_KERNEL_ARCH:-$(tc-arch-kernel)}
  local dtb_dir="${kernel_dir}/arch/${kernel_arch}/boot/dts"
  local version=$(kernelrelease)
  local boot_dir="${kernel_dir}/arch/${kernel_arch}/boot"
  einfo "rtd1619 post install ${SYSROOT}${install_prefix}"
  insinto ${install_prefix}
  newins ${boot_dir}/Image Image-${version}
  dosym Image-${version} /boot/Image
  insinto ${install_prefix}/realtek
  doins $dtb_dir/realtek/rtd1619b*.dtb
  if [[ -d "${dtb_dir}"/realtek/overlay ]] ; then
    insinto ${install_prefix}/realtek/overlay
    doins "${dtb_dir}"/realtek/overlay/*.dtbo || die
  fi
  local kernel_bin="${install_dir}/vmlinuz-${version}.signed"
  local its_script="${kernel_dir}/its_script"
  mkimage -D "-I dts -O dtb -p 2048" -f "${its_script}" \
      -k ${ROOT}/build/u-boot/rtd1619b/keys  -g dev -o sha256,rsa2048 "${kernel_bin}" || die
  ln -sf vmlinuz-${version}.signed ${install_dir}/vmlinuz.signed
}

cros_post_src_prepare_add_additional_patches() {
  if [[ ${PV} == "9999" ]]; then
    return
  fi
  if use panfrost; then
    einfo "apply patches for panfrost"
    eapply ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/panfrost/*.patch
  fi
}
