# Device supports 64-bit
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Use full-featured configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Launched with API 27
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# m1852 configuration
$(call inherit-product, device/meizu/m1852/m1852.mk)
TARGET_BOOT_ANIMATION_RES := 1080

# LineageOS configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Sakura Flags
SAKURA_MAINTAINER := MisterZtr

# Credits to XiNGRZ

PRODUCT_NAME := lineage_m1852
PRODUCT_BRAND := Meizu
PRODUCT_DEVICE := m1852
PRODUCT_MANUFACTURER := Meizu
PRODUCT_MODEL := meizu X8

PRODUCT_GMS_CLIENTID_BASE := android-meizu

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="M1852" \
    PRODUCT_NAME="meizu_M1852_CN" \
    PRIVATE_BUILD_DESC="meizu_M1852_CN-user 8.1.0 OPM1.171019.026 1592244368 release-keys"

BUILD_FINGERPRINT := Meizu/meizu_M1852_CN/M1852:8.1.0/OPM1.171019.026/1592244368:user/release-keys
