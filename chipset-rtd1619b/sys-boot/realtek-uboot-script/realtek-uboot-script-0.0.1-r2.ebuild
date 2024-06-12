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

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_compile() {
  if [ -z "${CHROMEOS_DTBS}" ]; then
    die "Need set REALTEK_DTB in make.conf"
  fi
  for slot in A B; do
    cat ${FILESDIR}/boot-${slot}.cmd | sed -e "s/#REALTEK_DTB#/${CHROMEOS_DTBS}/g" > boot-${slot}.cmd
    mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
      -n "boot" -d boot-${slot}.cmd boot-${slot}.scr.uimg || die
  done
}

src_install() {
  insinto /boot
  doins *.scr.uimg
}
