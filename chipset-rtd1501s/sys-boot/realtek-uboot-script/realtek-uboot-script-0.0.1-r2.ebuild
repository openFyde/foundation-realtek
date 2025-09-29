# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
  sys-boot/realtek-uboot-dep-binary"

S=${WORKDIR}

src_compile() {
  if [ -z "${CHROMEOS_DTBS}" ]; then
    die "Need set REALTEK_DTB in make.conf"
  fi
  for slot in A B; do
    cat ${FILESDIR}/boot-${slot}.cmd | sed -e "s/#REALTEK_DTB#/${CHROMEOS_DTBS}/g" > boot-${slot}.cmd
    cp ${FILESDIR}/boot-${slot}.its .
    mkimage -f boot-${slot}.its -k ${ROOT}/build/u-boot/rtd1625/keys -g dev -o sha256,rsa2048 boot-${slot}.scr.uimg
  done
}

src_install() {
  insinto /boot
  doins *.scr.uimg
}
