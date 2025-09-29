#!/bin/bash

modules=(
  rtk_fw_remoteproc
  rtk_rpc_mem
  rtk_krpc_agent
  rtk_drm
  mali_kbase
  rtk_urpc_service
  rtkve
  coda9
  snd_soc_rtk_hifi
  rtk_avcpulog
)

for module in ${modules[@]}; do
  echo "Install $module"
  modprobe $module
done
