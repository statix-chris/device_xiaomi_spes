# Copyright (C) 2023 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# API Level
BOARD_SHIPPING_API_LEVEL := 30

SHIPPING_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

# AB
TARGET_IS_VAB := true
PRODUCT_VIRTUAL_AB_OTA := true

# Audio
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.audio.spk.stereo=true \
    ro.vendor.audio.us.proximity=true

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_idp_india.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Camera
PRODUCT_PACKAGES += \
    libcamera_provider_shim \
    libpiex_shim

# Consumer IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.qti.display_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.display_boot.sh

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_display_power_timer_ms=1000 \
    ro.surface_flinger.set_idle_timer_ms=1100 \
    ro.surface_flinger.set_touch_timer_ms=200 \
    ro.surface_flinger.use_content_detection_for_refresh_rate=true

PRODUCT_VENDOR_PROPERTIES += \
    vendor.display.override_doze_mode=1

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi \
    com.fingerprints.extension@1.0.vendor \
    libvendor.goodix.hardware.biometrics.fingerprint@2.1.vendor \
    vendor.xiaomi.hardware.fingerprintextension@1.0.vendor

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.fp.sideCap=true

# Health
TARGET_USE_HIDL_QTI_HEALTH := true

# Kernel
TARGET_KERNEL_VERSION := 4.19
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)-kernel/kernel

PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)-kernel/vendor-modules,$(TARGET_COPY_OUT_VENDOR)/lib/modules)

PRODUCT_VENDOR_KERNEL_HEADERS += $(LOCAL_PATH)-kernel/kernel-headers

# Media
PRODUCT_ODM_PROPERTIES += \
    media.settings.xml=/vendor/etc/media_profiles_khaje.xml

# NFC
$(call inherit-product, hardware/st/nfc/nfc_vendor_product.mk)
ODM_MANIFEST_SKUS += $(TARGET_NFC_SKU)
ODM_MANIFEST_K7TN_FILES := hardware/st/nfc/aidl/nfc-service-default.xml
TARGET_USES_ST_AIDL_NFC := true
TARGET_NFC_SKU := k7tn

PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    libchrome.vendor \
    NfcNci \
    SecureElement \
    Tag

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf

PRODUCT_SYSTEM_PROPERTIES += \
    ro.nfc.port=I2C

# Overlays
PRODUCT_PACKAGES += \
    AOSPASpesFrameworksOverlay \
    SpesFrameworksOverlay \
    SpesSettingsOverlay \
    SpesSystemUIOverlay \
    SpesWifiOverlay \
    SpesWifiMainline \
    SettingsProvider2201117TGOverlay \
    SettingsProvider2201117TIOverlay \
    SettingsProvider2201117TYOverlay

# Parts
PRODUCT_PACKAGES += \
    SpesParts

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/parts/privapp-permissions-spes-parts.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-spes-parts.xml \
    $(LOCAL_PATH)/parts/init.spesxiaomiparts.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.spesxiaomiparts.rc

# Rootdir / Init files
PRODUCT_PACKAGES += \
    init.device.rc

# Sensors
PRODUCT_PACKAGES += \
    sensors.xiaomi

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/spes/spes-vendor.mk)

# Inherit from sm6225-common
$(call inherit-product, device/xiaomi/sm6225-common/common.mk)
