cros_pre_src_prepare_remove_internal() {
  if [ -d ${CHROME_ROOT}/src/google_apis/internal ]; then
    mv ${CHROME_ROOT}/src/google_apis/internal ${CHROME_ROOT}/src/google_apis/internal.bak
  fi
}
