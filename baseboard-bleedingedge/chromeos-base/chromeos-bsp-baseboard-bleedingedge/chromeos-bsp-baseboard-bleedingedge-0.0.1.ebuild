# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="tty_console_ttyS0"

RDEPEND="
  virtual/realtek-boot-files
  sys-kernel/bleedingedge-firmware-bin
"

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  if use tty_console_ttyS0; then
    insinto /etc/init
    doins init/console-ttyS0.override
  fi
  insinto /etc/modprobe.d
  doins modprobe.d/rtk_devices.conf
}
