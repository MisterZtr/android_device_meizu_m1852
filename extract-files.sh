#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

DEVICE=m1852
VENDOR=meizu

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

AOSP_ROOT="${MY_DIR}/../../.."

HELPER="${AOSP_ROOT}/vendor/aosp/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true
SECTION=
KANG=

while [ "$1" != "" ]; do
    case "$1" in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -k | --kang)            KANG="--kang"
                                ;;
        -s | --section )        shift
                                SECTION="$1"
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC="$1"
                                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC=adb
fi

function blob_fixup() {
    case "${1}" in
    vendor/lib/hw/camera.qcom.so)
        sed -i "s|libssc.so|libSSc.so|g" "${2}"
        ;;
    vendor/lib/libmms_hal_vstab.so | vendor/lib/camera/components/com.inv.node.eis.so | vendor/bin/hw/vendor.qti.hardware.qdutils_disp@1.0-service-qti)
        sed -i "s|libgui.so|libwui.so|g" "${2}"
        ;;
    vendor/lib/hw/audio.primary.sdm710.so | vendor/lib64/hw/audio.primary.sdm710.so)
        if [ -z $(patchelf --print-needed "${2}" | grep "libprocessgroup.so") ]; then
            patchelf --add-needed "libprocessgroup.so" "${2}"
        fi
        ;;
    vendor/lib/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so | vendor/lib64/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so)
        patchelf --remove-needed "libicuuc.so" "${2}"
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${AOSP_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
