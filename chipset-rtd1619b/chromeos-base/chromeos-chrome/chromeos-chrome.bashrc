cros_pre_src_prepare_remove_internal() {
  if [ -d ${CHROME_ROOT}/src/google_apis/internal ]; then
    mv ${CHROME_ROOT}/src/google_apis/internal ${CHROME_ROOT}/src/google_apis/internal.bak
  fi
}

PATCHES=(
  ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/001-disalbe-fieldtrial-testing-config.patch
  ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/002-add-support-for-av1.patch
  ${CHIPSET_RTD1619B_BASHRC_FILESDIR}/003-add-libwidevinecdm-info.patch
)
