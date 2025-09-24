cros_post_src_prepare_env_config_for_realtek() {
  if [ $PV == "9999" ]; then
    return
  fi
 cp ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/fw_env.config tools/env
}
