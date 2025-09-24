#!/bin/bash
modules=(
	governor_simpleondemand
	rtk_fw_remoteproc
	rpmsg_rtk
	rtk_krpc_agent
	rtk_urpc_service
	rtk_rpc_mem
	rtk_fwdbg
	gpu_sched
	panfrost
	drm_kms_helper
	rtk_drm
	rtd_rng
	rtkve1
	rtkve2
	rtk_avcpulog
	8852be
	snd_realtek_notify
)

for module in ${modules[@]}; do
  echo "Install $module"
  modprobe $module
done
