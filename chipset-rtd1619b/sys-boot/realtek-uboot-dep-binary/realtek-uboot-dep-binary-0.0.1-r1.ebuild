# Copyright (c) 2024 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="realtek rtd1619 binary for uboot"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=$WORKDIR

src_unpack() {
  unpack ${FILESDIR}/rtd1619b-binary.tar.gz
}

src_compile() {
  openssl req -batch -new -x509 -key rtd1619b/keys/dev.key -out rtd1619b/keys/dev.crt
}

src_install() {
  insinto /build/u-boot
  doins -r rtd1619b
}
