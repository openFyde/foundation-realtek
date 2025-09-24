cros_post_src_prepare_patch_for_realtek() {
  if [ $PV == "9999" ]; then
    return
  fi
  eapply ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/01-add-support-for-realtek-uboot.patch
  eapply ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/02-ignore-clear_tpm_owner_request-error.patch
}
