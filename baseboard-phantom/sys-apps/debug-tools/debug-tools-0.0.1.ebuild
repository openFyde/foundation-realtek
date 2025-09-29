# Copyright (c) 2025 The Realtek Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Put prebuilt binary for development purpose"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${WORKDIR}

RESTRICT="strip"

src_install() {
  exeinto /usr/bin
  doexe ${FILESDIR}/reg_uio.uio0
}
