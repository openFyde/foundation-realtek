# Copyright (c) 2025 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

inherit udev

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="tty_console_ttyS0 panfrost"

RDEPEND="
  virtual/realtek-boot-files
  sys-kernel/phantom-firmware-bin
"

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  # Override default CPU clock speed governor.
  insinto "/etc"
  doins "${FILESDIR}/cpufreq.conf"

  insinto /etc/init
  doins init/load-rtd1501s-modules.conf
  doins init/net-acc.conf
  doins init/ipa-controller.conf
  if use tty_console_ttyS0; then
    doins init/console-ttyS0.override
  fi
  insinto /etc/modprobe.d
  doins modprobe.d/rtk_devices.conf
  exeinto /usr/sbin
  doexe sbin/ipa_controller
  if use panfrost; then
    newexe sbin/loadmodules.sh.panfrost loadmodules.sh
  else
    doexe sbin/loadmodules.sh
  fi
  udev_dorules rules/50-media.rules
  udev_dorules rules/50-thermal.rules
  insinto /usr/share/alsa/ucm
  doins -r ucm/*
}
