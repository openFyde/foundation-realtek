# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="update_uboot_spl"

RDEPEND="
  dev-embedded/u-boot-tools[envtools]
"

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  exeinto /usr/sbin
  doexe script/chromeos-firmwareupdate
  if use update_uboot_spl; then
    insinto /root
    newins force_update_firmware .force_update_firmware
  fi
}
