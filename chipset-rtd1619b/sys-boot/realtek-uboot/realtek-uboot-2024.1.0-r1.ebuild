# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

EGIT_REPO_URI="https://source.denx.de/u-boot/u-boot.git"
#EGIT_BRANCH="v2024.01"
EGIT_COMMIT="866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e"

inherit git-r3 toolchain-funcs flag-o-matic cros-sanitizers cros-gcc

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
  sys-boot/realtek-uboot-dep-binary
"

UB_BUILD_DIR="build"
PREBUILT=prebuilt
KEY_DIR=${PREBUILT}/keys

umake() {
  # Add `ARCH=` to reset ARCH env and let U-Boot choose it.
  ARCH="" KEYDIR=${KEY_DIR} KEYNAME="dev" emake "${COMMON_MAKE_FLAGS[@]}" "$@"
}

EXT_HWSETTINGS="
  scs_param/0000/SCS_Params_Area_RTD1619B_hwsetting_BOOT_LPDDR4_32Gb_ddp_s2666.bin
  scs_param/0000/SCS_Params_Area_RTD1619B_hwsetting_BOOT_2DDR4_16Gb_sdp_s2666.bin
  scs_param/0000/SCS_Params_Area_RTD1619B_hwsetting_BOOT_LPDDR4_16Gb_s2666.bin
  scs_param/0000/SCS_Params_Area_RTD1619B_hwsetting_BOOT_2DDR4_8Gb_s2666.bin
"

prepare_keys() {
  if [ -d "${KEY_DIR}" ]; then
    einfo "Create keys..."
    dtc -I dtb -O dts -o ${S}/arch/arm/dts/sign.dtsi ${KEY_DIR}/dummy.dtb
    sed -i "/dts-v1/d" ${S}/arch/arm/dts/sign.dtsi
    sed -i "s/signature/signature: signature/" ${S}/arch/arm/dts/sign.dtsi
    sed -i "s/key-dev/key_dev: key-dev/" ${S}/arch/arm/dts/sign.dtsi
    sed -i "s/conf/invalid/" ${S}/arch/arm/dts/sign.dtsi
  fi
}

src_prepare() {
  default
  eapply ${FILESDIR}/patches/*.patch
  cp -rd ${FILESDIR}/src/* .
  mkdir ${PREBUILT}
  cp -rd ${ROOT}/build/u-boot/rtd1619b/* ${PREBUILT}
  prepare_keys
  ln -s ${S}/${KEY_DIR} keys
}

sign_spl() {
  if [ -d "${KEY_DIR}" ]; then
    einfo "Signing spl image"
    openssl dgst -sha256 -binary build/spl/u-boot-spl.bin_pad > ${PREBUILT}/u-boot-spl.sha
    openssl pkeyutl -inkey ${KEY_DIR}/dev.key -sign -in ${PREBUILT}/u-boot-spl.sha -out ${PREBUILT}/u-boot-spl.sig
    objcopy -I binary -O binary --reverse-bytes=256 ${PREBUILT}/u-boot-spl.sig ${PREBUILT}/u-boot-spl.sig
  fi
}

create_uboot_img() {
 local k=0
 for exthw in  ${EXT_HWSETTINGS}; do
   dd if="${PREBUILT}/${exthw}" of="${PREBUILT}/ext_hwsetting_$k.bin" bs=1 skip=8 count=8192
   k=$(expr $k + 1);
 done
 cp ./build/spl/u-boot-spl.bin_pad ${PREBUILT}/
 cp ./build/u-boot.img ${PREBUILT}/
 for surfix in '' '_4gb'; do
    cc -E -nostdinc -undef -D__DTS__ -x assembler-with-cpp \
        -o ${PREBUILT}/rtd1619b_emmc${surfix}.pp ${PREBUILT}/rtd1619b_emmc_${UBOOT_DDR_TYPE}${surfix}.dts
# cc -E -nostdinc -undef -D__DTS__ -x assembler-with-cpp \
#      -o ${PREBUILT}/rtd1619b_emmc_4gb.pp ${PREBUILT}/rtd1619b_emmc_${UBOOT_DDR_TYPE}_4gb.dts
    dtc -I dts -O dtb -o ${PREBUILT}/rtd1619b_emmc${surfix}.dtb ${PREBUILT}/rtd1619b_emmc${surfix}.pp
# dtc -I dts -O dtb -o ${PREBUILT}/rtd1619b_emmc_4gb.dtb ${PREBUILT}/rtd1619b_emmc_4gb.pp
    tools/binman/binman build --update-fdt -I ./${PREBUILT} --dt ./${PREBUILT}/rtd1619b_emmc${surfix}.dtb -O ${UB_BUILD_DIR}/
# tools/binman/binman build --update-fdt -I ./${PREBUILT} --dt ./${PREBUILT}/rtd1619b_emmc_4gb.dtb -O ${UB_BUILD_DIR}/
 done
}

src_configure() {
  export KEYDIR=${KEY_DIR}
  export KEYNAME="dev"
	cros_use_gcc
	sanitizers-setup-env
	local config
	OUTPUT_BINARY="u-boot.bin"
	CROSS_PREFIX="${CHOST}-"

  COMMON_MAKE_FLAGS=(
    "CROSS_COMPILE=${CROSS_PREFIX}"
    DEV_TREE_SEPARATE=1
    "HOSTCC=${BUILD_CC}"
    HOSTSTRIP=true
    QEMU_ARCH=
    NO_PYTHON=y
  )

  BUILD_FLAGS=(
    "O=${UB_BUILD_DIR}"
  )

  umake "${BUILD_FLAGS[@]}" distclean
  umake "${BUILD_FLAGS[@]}" "${UBOOT_CONFIG}_defconfig"
}

src_compile() {
	umake "${BUILD_FLAGS[@]}" all
  sign_spl
  create_uboot_img
}

src_install() {
  insinto /boot
  newins ${UB_BUILD_DIR}/bind.bin rtd1619b_emmc_bind.bin
  newins ${UB_BUILD_DIR}/bind_4gb.bin rtd1619b_emmc_bind_4gb.bin
  newins ${UB_BUILD_DIR}/u-boot.itb u-boot.bin-rtd1619b_emmc
}
