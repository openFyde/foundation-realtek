# Copyright (c) 2025 The Realtek Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
 unpack ${FILESDIR}/libstdc++.tar.xz
}

src_install() {
  dolib.so lib*so*
}
