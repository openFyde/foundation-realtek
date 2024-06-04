#!/bin/bash
modules=(
  rtk_fw_remoteproc
  rpmsg_rtk
  rtk_rpc_mem
  rtk_krpc_agent
  rtk_urpc_service
  rtk_drm
  governor_simpleondemand
  mali_kbase
  snd_soc_hifi_realtek
  snd_soc_realtek
)

for module in ${modules[@]}; do
  echo "Install $module"
  modprobe $module
done
