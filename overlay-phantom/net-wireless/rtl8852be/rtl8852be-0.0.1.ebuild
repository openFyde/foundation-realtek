# Copyright (c) 2025 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

inherit linux-info linux-mod

DESCRIPTION="Kernel driver module for Realtek rtl8852be wireless network controller"

LICENSE="GPL-2"
KEYWORDS="-* arm64"
IUSE=""

RDEPEND="virtual/linux-sources"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

MODULE_NAMES="8852be()"
BUILD_TARGETS="clean modules"
TARGET_PLATFORM="CONFIG_PLATFORM_I386_PC=n CONFIG_PLATFORM_RTK1319=n CONFIG_PLATFORM_RTKSTB=y"
EXTRA_PARAMS="UPSTREAM_KSRC=y PLTFM_VER=0 CONFIG_INIT_STACK_ALL_ZERO="

pkg_setup() {
  export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v6.6"
  export KBUILD_OUTPUT=${ROOT}/usr/src/linux
  export BUILD_PARAMS="ARCH=arm64 M=${S} ${TARGET_PLATFOMR} KSRC=${KERNEL_DIR} O=${KBUILD_OUTPUT} ${EXTRA_PARAMS}"
  linux-mod_pkg_setup
}

src_unpack() {
  unpack ${FILESDIR}/rtl8852be.tar.xz
}

src_compile() {
  cros_allow_gnu_build_tools
  linux-mod_src_compile
}

# there is a bug in linux-mod_pkg_preinst() that stop depmod from generating
pkg_preinst() {
	debug-print-function ${FUNCNAME} $*
	[ -n "${MODULES_OPTIONAL_USE}" ] && use !${MODULES_OPTIONAL_USE} && return

	[ -d "${D}/lib/modules" ] && UPDATE_DEPMOD=true || UPDATE_DEPMOD=false
	[ -d "${D}/lib/modules" ] && UPDATE_MODULEDB=true || UPDATE_MODULEDB=false
}

PATCHES=(
  ${FILESDIR}/001-fix-compiling.patch
)
