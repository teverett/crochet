KERNCONF=IMX6
TARGET_ARCH=mips
IMAGE_SIZE=$((1024 * 1000 * 1000))
DIR825_UBOOT_SRC=${TOPDIR}/u-boot-1.1.5

#
# Dir-825 uses U-Boot.
#
dir825_check_uboot ( ) {
	# Crochet needs to build U-Boot.

    	uboot_set_patch_version ${DIR825_UBOOT_SRC} ${WANDBOARD_UBOOT_PATCH_VERSION}

        uboot_test \
            DIR825_UBOOT_SRC \
            "$DIR825_UBOOT_SRC/board/wandboard/Makefile"
        strategy_add $PHASE_BUILD_OTHER uboot_patch ${DIR825_UBOOT_SRC} `uboot_patch_files`
        strategy_add $PHASE_BUILD_OTHER uboot_configure $DIR825_UBOOT_SRC wandboard_quad_config
        strategy_add $PHASE_BUILD_OTHER uboot_build $DIR825_UBOOT_SRC
}
strategy_add $PHASE_CHECK dir825_check_uboot

#
# kernel
#
strategy_add $PHASE_FREEBSD_BOARD_INSTALL board_default_installkernel .
strategy_add $PHASE_FREEBSD_BOARD_INSTALL freebsd_ubldr_copy_ubldr_help boot

#
# Make a /boot/msdos directory so the running image
# can mount the FAT partition.  (See overlay/etc/fstab.)
#
strategy_add $PHASE_FREEBSD_BOARD_INSTALL mkdir boot/msdos


