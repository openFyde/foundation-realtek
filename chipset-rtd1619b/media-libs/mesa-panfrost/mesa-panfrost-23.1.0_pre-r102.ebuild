# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CROS_WORKON_COMMIT="5fd04290b27641489b5aee7983ed139a393b38b2"
CROS_WORKON_TREE="2c7747863f511d867a24f67d9f3637ebd82b4cd1"
CROS_WORKON_PROJECT="chromiumos/third_party/mesa"
CROS_WORKON_LOCALNAME="mesa-freedreno"

KEYWORDS="*"

inherit meson flag-o-matic cros-workon

DESCRIPTION="The Mesa 3D Graphics Library"
HOMEPAGE="http://mesa3d.org/"

# Most of the code is MIT/X11.
# GLES[2]/gl[2]{,ext,platform}.h are SGI-B-2.0
LICENSE="MIT SGI-B-2.0"

IUSE="debug libglvnd vulkan zstd"

COMMON_DEPEND="
	dev-libs/expat:=
	>=x11-libs/libdrm-2.4.94:=
"

RDEPEND="${COMMON_DEPEND}
	libglvnd? ( media-libs/libglvnd )
	!libglvnd? ( !media-libs/libglvnd )
	zstd? ( app-arch/zstd )
  chromeos-base/libchromeos-use-flags[disable_explicit_dma_fences]
"

DEPEND="${COMMON_DEPEND}
"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

src_configure() {
	emesonargs+=(
		-Dexecmem=false
		-Dglvnd=$(usex libglvnd true false)
		-Dllvm=disabled
		-Ddri3=disabled
		-Dshader-cache=disabled
		-Dglx=disabled
		-Degl=enabled
		-Dgbm=disabled
		-Dgles1=disabled
		-Dgles2=enabled
		-Dshared-glapi=enabled
		-Dgallium-drivers=panfrost,kmsro
		-Dgallium-vdpau=disabled
		-Dgallium-xa=disabled
		$(meson_feature zstd)
		-Dplatforms=
		-Dtools=panfrost
		--buildtype $(usex debug debug release)
		-Dvulkan-drivers=$(usex vulkan panfrost '')
	)

	meson_src_configure
}

src_install() {
	meson_src_install
  find "${ED}" -name '*kgsl*' -exec rm -f {} +
	rm -v -rf "${ED}/usr/include"
  insinto /etc
  doins ${FILESDIR}/drirc
}

PATCHES=(
  ${FILESDIR}/23.1.0/001-dri-add-realtek_dri-support.patch
)
