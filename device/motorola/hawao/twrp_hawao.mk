PRODUCT_RELEASE_NAME := hawao

$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := hawao
PRODUCT_NAME := twrp_hawao
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g42
PRODUCT_MANUFACTURER := motorola

PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.hawao.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.hawao.rc
