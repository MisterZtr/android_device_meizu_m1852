 #----------------------------------------------------------------------
# Copy prebuilt kernel to out directory
#----------------------------------------------------------------------

ifeq ($(TARGET_IGNORE_KERNEL_DEFINITIONS),true)

INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel

$(INSTALLED_KERNEL_TARGET): $(TARGET_PREBUILT_KERNEL)
	cp $(TARGET_PREBUILT_KERNEL) $(PRODUCT_OUT)/kernel

endif
