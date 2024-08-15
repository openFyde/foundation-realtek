cros_post_src_prepare_chipset_rtd1619b_patches() {
  if [ ${PV} == '9999' ]; then
    return
  fi
  eapply ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/001-fix-crashing-after-resume.patch
}
