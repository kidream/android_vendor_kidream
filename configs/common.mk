# compile KiDream packages
PRODUCT_PACKAGES += \
    ControlCenter \
    xdelta3 \
    su

# APN list
PRODUCT_COPY_FILES += \
    vendor/kidream/prebuilt/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0

ifndef KD_BUILDTYPE
ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^KD_||g')
        KD_BUILDTYPE := $(RELEASE_TYPE)
endif

endif

ifeq ($(filter RELEASE NIGHTLY EXPERIMENTAL,$(KD_BUILDTYPE)),)
    KD_BUILDTYPE :=
endif

ifdef KD_BUILDTYPE
 ifdef KD_EXTRAVERSION
            KD_BUILDTYPE := TEST
else
            KD_EXTRAVERSION := $(shell echo $(KD_EXTRAVERSION) | sed 's/-//')
            KD_EXTRAVERSION := -$(KD_EXTRAVERSION)
endif
else
    KD_BUILDTYPE := NIGHTLY
    KD_EXTRAVERSION :=
endif

ifeq ($(KD_BUILDTYPE), RELEASE)
    KD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)
else
ifeq ($(PRODUCT_VERSION_MINOR),0)
        KD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d-%H%M)-$(KD_BUILDTYPE)$(KD_EXTRAVERSION)
else
        KD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d-%H%M)-$(KD_BUILDTYPE)$(KD_EXTRAVERSION)
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.kd.version=$(KD_VERSION) \
  ro.modversion=$(KD_VERSION)
