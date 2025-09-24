# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="firmware for phantom"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  insinto /lib/firmware/realtek/
  doins -r rtd1625
  insinto /lib/firmware
  doins -r rtw89
  insinto /lib/firmware
  doins -r rtl_bt
  insinto /lib/firmware/arm/mali/arch10.12
  doins mali_csffw.bin
}
