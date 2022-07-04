# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.audio.sdk.fluencetype=none \
    vendor.audio.offload.track.enable=true \
    vendor.audio_hal.period_size=192 \

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    persist.benchmarkconfig.enable=false \
    ro.product.perf.config=M1852_base \
    ro.vendor.qti.sys.fw.bg_apps_limit=32 \

# Meizu
PRODUCT_PROPERTY_OVERRIDES += \
    ro.meizu.build.branch=M1852_QOF8_mp1 \
    ro.meizu.build.devowner=wentai \
    ro.meizu.carrier.model=M852Q \
