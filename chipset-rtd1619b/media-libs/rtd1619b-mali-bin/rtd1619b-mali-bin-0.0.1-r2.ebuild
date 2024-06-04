# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Mali driver for rtd1619b"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="vulkan"

RDEPEND="
  sys-libs/libstdc++-v3-bin
"

DEPEND="${RDEPEND}"

MALI_P="malig57-r42p0-01eac0-chromium-a64"
S=${WORKDIR}/${MALI_P}

src_unpack() {
  unpack ${FILESDIR}/${MALI_P}.tar.bz2
}

src_install() {
  rm usr/lib/pkgconfig/{gbm,wayland-egl}.pc
  insinto /usr/lib64
  doins -r usr/lib/*
  if use vulkan; then
    insinto /usr/share/vulkan/icd.d
    doins ${FILESDIR}/mali_ICD.json
  fi
}
