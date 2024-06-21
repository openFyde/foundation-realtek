# Copyright 2010 The ChromiumOS Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for OpenGLES implementations"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="*"
IUSE="panfrost"

RDEPEND="
 !panfrost? ( media-libs/rtd1619b-mali-bin )
 panfrost? ( media-libs/mesa-panfrost )"
DEPEND=""
