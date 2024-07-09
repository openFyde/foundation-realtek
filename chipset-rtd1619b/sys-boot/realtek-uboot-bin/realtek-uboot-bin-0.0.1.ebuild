# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Realtek rd1619b u-boot binary"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  insinto /boot
  doins u-boot.bin-rtd1619b_emmc
  doins rtd1619b_emmc_bind.bin
  doins rtd1619b_emmc_bind_4gb.bin
}
