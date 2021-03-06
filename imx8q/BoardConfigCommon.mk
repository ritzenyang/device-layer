#
# SoC-specific compile-time definitions.
#

BOARD_HAVE_VPU := true
BOARD_VPU_TYPE := malone
FSL_VPU_OMX_ONLY := true
HAVE_FSL_IMX_GPU2D := true
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_IPU := false
HAVE_FSL_IMX_PXP := false
BOARD_KERNEL_BASE := 0x80200000
TARGET_GRALLOC_VERSION := v3
TARGET_HIGH_PERFORMANCE := true
TARGET_USES_HWC2 := true
TARGET_HWCOMPOSER_VERSION = v2.0
USE_OPENGL_RENDERER := true
TARGET_HAVE_VULKAN := true
ENABLE_CFI=false

#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := imx

SOONG_CONFIG_NAMESPACES += IMXPLUGIN
SOONG_CONFIG_IMXPLUGIN += BOARD_PLATFORM \
IMX_CAR \
NUM_FRAMEBUFFER_SURFACE_BUFFERS \
BOARD_HAVE_IMX_EVS \
BOARD_USE_SENSOR_FUSION \
BOARD_SOC_TYPE \
BOARD_SOC_CLASS \
HAVE_FSL_IMX_GPU3D \
TARGET_HWCOMPOSER_VERSION \
TARGET_GRALLOC_VERSION \
BOARD_USE_SENSOR_PEDOMETER \
HAVE_FSL_IMX_IPU \
BOARD_USE_LEGACY_SENSOR \
PREBUILT_FSL_IMX_GPU \
PRODUCT_MANUFACTURER \
BOARD_HAVE_VPU \
BOARD_VPU_TYPE \
BOARD_VPU_ONLY

SOONG_CONFIG_IMXPLUGIN_BOARD_PLATFORM = imx8
SOONG_CONFIG_IMXPLUGIN_NUM_FRAMEBUFFER_SURFACE_BUFFERS = 3
SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_IMX_EVS = true
SOONG_CONFIG_IMXPLUGIN_BOARD_USE_SENSOR_FUSION = true
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_TYPE = IMX8Q
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_CLASS = IMX8
SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_GPU3D = true
SOONG_CONFIG_IMXPLUGIN_TARGET_HWCOMPOSER_VERSION = v2.0
SOONG_CONFIG_IMXPLUGIN_TARGET_GRALLOC_VERSION = v3
SOONG_CONFIG_IMXPLUGIN_BOARD_USE_SENSOR_PEDOMETER = false
SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_IPU = false
SOONG_CONFIG_IMXPLUGIN_PRODUCT_MANUFACTURER = freescale
SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_VPU = true
SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_TYPE = malone
SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_ONLY = false

ifeq ($(IMX8_BUILD_32BIT_ROOTFS),true)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a9
TARGET_USES_64_BIT_BINDER := true
else
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9
endif

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
TARGET_NO_RADIOIMAGE := true

BOARD_SOC_CLASS := IMX8

BOARD_KERNEL_OFFSET := 0x00080000
BOARD_RAMDISK_OFFSET := 0x06200000
BOARD_BOOTIMG_HEADER_VERSION := 1

BOARD_MKBOOTIMG_ARGS = --base $(BOARD_KERNEL_BASE) --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

#BOARD_USES_GENERIC_AUDIO := true
BOARD_USES_ALSA_AUDIO := true
BOARD_HAVE_BLUETOOTH := true
USE_CAMERA_STUB := false

BOARD_HAVE_IMX_CAMERA := true
BOARD_HAVE_USB_CAMERA := false
BOARD_HAVE_USB_MJPEG_CAMERA := false

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
   ifeq ($(TARGET_BUILD_VARIANT),user)
	ifeq ($(WITH_DEXPREOPT),)
	    WITH_DEXPREOPT := true
	endif
   endif
endif

PREBUILT_FSL_IMX_OMX := false
PREBUILT_FSL_IMX_GPU := true
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = true

# override some prebuilt setting if DISABLE_FSL_PREBUILT is define
ifeq ($(DISABLE_FSL_PREBUILT),GPU)
PREBUILT_FSL_IMX_GPU := false
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = false
else ifeq ($(DISABLE_FSL_PREBUILT),ALL)
PREBUILT_FSL_IMX_GPU := false
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = false
endif

# Indicate use vivante drm based egl and gralloc
BOARD_GPU_DRIVERS := vivante

# Indicate use NXP libdrm-imx or Android external/libdrm
BOARD_GPU_LIBDRM := libdrm_imx

# for kernel/user space split
# comment out for 1g/3g space split
# TARGET_KERNEL_2G := true

AB_OTA_UPDATER := true
ifeq ($(IMX_NO_PRODUCT_PARTITION),true)
AB_OTA_PARTITIONS += dtbo boot system vendor vbmeta
else
AB_OTA_PARTITIONS += dtbo boot system vendor vbmeta product
endif
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

BOARD_DTBOIMG_PARTITION_SIZE := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE = ext4
TARGET_COPY_OUT_VENDOR := vendor

ifneq ($(IMX_NO_PRODUCT_PARTITION),true)
  BOARD_USES_PRODUCTIMAGE := true
  BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
  TARGET_COPY_OUT_PRODUCT := product
endif

BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_RECOVERY_UI_LIB := librecovery_ui_imx


ifeq ($(TARGET_USE_DYNAMIC_PARTITIONS),true)
  BOARD_SUPER_PARTITION_GROUPS := nxp_dynamic_partitions
  ifeq ($(TARGET_USE_RETROFIT_DYNAMIC_PARTITION),true)
    ifeq ($(IMX_NO_PRODUCT_PARTITION),true)
      BOARD_SUPER_PARTITION_SIZE := 3489660928
      BOARD_NXP_DYNAMIC_PARTITIONS_SIZE := 3487563776
    else
      BOARD_SUPER_PARTITION_SIZE := 4026531840
      BOARD_NXP_DYNAMIC_PARTITIONS_SIZE := 4024434688
    endif
  else
    BOARD_SUPER_PARTITION_SIZE := 7516192768
    BOARD_NXP_DYNAMIC_PARTITIONS_SIZE := 3747610624
  endif
  ifeq ($(IMX_NO_PRODUCT_PARTITION),true)
    BOARD_NXP_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor
  else
    BOARD_NXP_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product

  endif
else
  BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
  BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912
  ifeq ($(IMX_NO_PRODUCT_PARTITION),true)
    BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2952790016
  else
    BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736

    BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1879048192
  endif
endif

# kernel module's copy to vendor need this folder setting
KERNEL_OUT ?= $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/obj/KERNEL_OBJ

PRODUCT_COPY_FILES += \
    $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/$(KERNEL_NAME):kernel

ifneq ($(BOARD_OTA_BOOTLOADERIMAGE),)
  PRODUCT_COPY_FILES += \
      $(BOARD_OTA_BOOTLOADERIMAGE):bootloader.img
endif

-include $(FSL_RESTRICTED_CODEC_PATH)/fsl-restricted-codec/fsl_ms_codec/BoardConfig.mk
-include $(FSL_RESTRICTED_CODEC_PATH)/fsl-restricted-codec/fsl_real_dec/BoardConfig.mk
