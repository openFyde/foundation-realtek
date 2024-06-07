# Copyright 2013 The ChromiumOS Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Generic ebuild which satisifies virtual/chromeos-bsp-dev.
This is a direct dependency of virtual/target-chromium-os-dev, but is expected
to be overridden in an overlay for each specialized board.  A typical
non-generic implementation will install any board-specific developer only
files and executables which are not suitable for inclusion in a generic board
overlay."
HOMEPAGE="http://src.chromium.org"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
  sys-apps/firmware-log-tools
"
