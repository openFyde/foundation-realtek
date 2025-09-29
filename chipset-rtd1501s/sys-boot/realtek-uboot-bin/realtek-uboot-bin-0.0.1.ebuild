# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Realtek rtd1501s u-boot binary"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  insinto /boot
  doins "${FILESDIR}"/u-boot.bin-rtd1501s_emmc
  doins "${FILESDIR}"/rtd1501s_emmc_bind.bin
}
