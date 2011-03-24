PATH=$PWD/oe-core/scripts:$PWD/bitbake/bin:$PATH
export PATH

# Used by poky-qemu, scripts/bitbake
export BUILDDIR=$PWD

export BB_ENV_EXTRAWHITE="PSEUDO_DISABLED PSEUDO_BUILD $BB_ENV_EXTRAWHITE"
