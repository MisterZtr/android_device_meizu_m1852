#!/bin/bash

set -e

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."
CLEAN_HEADERS_TOOL="${ANDROID_ROOT}/bionic/libc/kernel/tools/clean_header.py"
SOURCE_DIR="${ANDROID_ROOT}/kernel/meizu/m1852"
OUTPUT_DIR="${MY_DIR}/kernel-headers"

GEN_DIRS_LIST="\
    drm\
    linux\
    media\
    scsi/ufs\
    video"

for dir in ${GEN_DIRS_LIST}
do
    mkdir -p ${OUTPUT_DIR}/${dir}
done

UAPI_HEADERS_LIST="\
    drm/msm_drm.h\
    drm/sde_drm.h\
    drm/drm_fourcc.h\
    linux/ion.h\
    linux/mdss_rotator.h\
    linux/msm_ion.h\
    linux/msm_mdp_ext.h\
    linux/msm_mdp.h\
    linux/videodev2.h\
    linux/msm_ipa.h\
    linux/qseecom.h\
    linux/rmnet_data.h\
    linux/ipa_qmi_service_v01.h\
    linux/rmnet_ipa_fd_ioctl.h\
    linux/netlink.h\
    linux/socket.h\
    media/msm_media_info.h\
    media/msm_sde_rotator.h\
    scsi/ufs/ioctl.h\
    scsi/ufs/ufs.h\
    video/msm_hdmi_modes.h"

EXCLUDE_CLEAN_LIST="\
    media/msm_media_info.h\
    linux/socket.h"

source "${ANDROID_ROOT}/build/envsetup.sh"

for file in ${UAPI_HEADERS_LIST}
do
    if [[ " ${EXCLUDE_CLEAN_LIST} " =~ .*\ ${file}\ .* ]]
    then
        cat ${SOURCE_DIR}/include/uapi/${file} > ${OUTPUT_DIR}/${file}
    else
        ${CLEAN_HEADERS_TOOL} ${SOURCE_DIR}/include/uapi/${file} > ${OUTPUT_DIR}/${file}
    fi
done

sed -i '$ d' ${OUTPUT_DIR}/linux/socket.h
echo "#ifndef __KERNEL__
 #define sockaddr_storage __kernel_sockaddr_storage
#endif
#endif /* _UAPI_LINUX_SOCKET_H */" >> ${OUTPUT_DIR}/linux/socket.h
