cros_pre_src_prepare_remove_internal() {
  if [ -d ${CHROME_ROOT}/src/google_apis/internal ]; then
    mv ${CHROME_ROOT}/src/google_apis/internal ${CHROME_ROOT}/src/google_apis/internal.bak
  fi

  if [ ${CHROME_ORIGIN} = "LOCAL_SOURCE" ]; then
     echo "don't remove widevine dir"
  else
     echo "remove widevine dir"
     rm -rf ${CHROME_ROOT}/src/third_party/widevine/cdm/chromeos/*
  fi
}

cros_post_src_install_remove_fakefiles() {
  rm -rf "${D_CHROME_DIR}/WidevineCdm/_platform_specific" || true
}

PATCHES=(
  ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/002-workaround-support-two-v4l2-video-devices.patch
  ${CHIPSET_RTD1501S_BASHRC_FILESDIR}/004-add-IsRtkchipAfbc-to-handle-Modeset-flow.patch
)
# Test tablet mode without internal display: add flag '--use-first-display-as-internal' to /etc/chrome_dev.conf
