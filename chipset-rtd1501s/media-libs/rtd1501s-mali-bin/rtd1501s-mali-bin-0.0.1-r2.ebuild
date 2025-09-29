# Copyright (c) 2025 The Realtek Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Mali driver for rtd1501s"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="vulkan"

RDEPEND="
  sys-libs/libstdc++-v3-bin
"

DEPEND="${RDEPEND}"

MALI_P="malig310-r44p0-01eac0-chromium-a64"
S=${WORKDIR}/${MALI_P}

src_unpack() {
  unpack ${FILESDIR}/${MALI_P}.tar.bz2
}

src_install() {
  cp -pPR "${S}"/* "${D}/"
}
