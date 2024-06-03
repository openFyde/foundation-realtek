cros_pre_src_prepare_chipset_rtd1619b_patches() {
  if [ ${PV} != "9999" ]; then
    eapply -p1 ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/001-add-realtek-drm.patch
  fi
}
