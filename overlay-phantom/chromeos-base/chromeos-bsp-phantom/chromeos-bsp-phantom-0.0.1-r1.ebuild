# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
  chromeos-base/chromeos-bsp-baseboard-phantom
  chromeos-base/device-appid
  app-i18n/chromeos-keyboards
  net-wireless/rtl8852be
"

DEPEND="${RDEPEND}"

S=${FILESDIR}
