cros_post_src_prepare_chipset_rtd1501s_patches() {
  if [ ${PV} == '9999' ]; then
    return
  fi
  eapply ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/001-fix-crashing-after-resume.patch
}
