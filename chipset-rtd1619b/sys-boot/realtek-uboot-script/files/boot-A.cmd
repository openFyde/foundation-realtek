setenv rootpart 3
setenv fdtfile /boot/realtek/#REALTEK_DTB#
setenv linux_image /boot/Image
setenv linux_image_its /boot/vmlinuz.signed
part uuid ${devtype} ${devnum}:${rootpart} root_uuid
if env exists extra_bootargs; then env print extra_bootargs; else setenv extra_bootargs "loglevel=7"; fi
setenv bootargs "earlycon=uart8250,mmio32,0x98007800 console=ttyS0,460800 uio_pdrv_genirq.of_id=generic-uio firmware_class.path=/lib/firmware/realtek/rtd1619b/ pd_ignore_unused clk_ignore_unused rootfstype=ext2 rootwait ro cros_debug cros_legacy root=PARTUUID=${root_uuid} ${extra_bootargs}"
setenv kernel_addr_c 0x08000000
setenv fdt_addr_r 0x02100000
setenv boot_dev_mode "load ${devtype} ${devnum}:${rootpart} ${kernel_addr_c} ${linux_image}; load ${devtype} ${devnum}:${rootpart} ${fdt_addr_r} ${fdtfile}; booti ${kernel_addr_c} - ${fdt_addr_r}"

setenv boot_normal_mode "load ${devtype} ${devnum}:${rootpart} ${bootmaddr} ${linux_image_its}; bootm ${bootmaddr}"

if env exists dev_mode; then run boot_dev_mode; else run boot_normal_mode; fi
