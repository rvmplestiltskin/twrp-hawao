# TWRP Device Tree for Motorola Moto G42 (hawao)

## Disclaimer

Your warranty is now void. I am not responsible for bricked devices, dead SD cards, thermonuclear war, or you getting fired because the alarm app failed. Please do some research if you have any concerns about features included in this ROM before flashing it! YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.

## Device Specifications

| Feature | Specification |
|---|---|
| Codename | hawao |
| SoC | Qualcomm SM6225 Snapdragon 680 (bengal) |
| Architecture | arm64 |
| CPU | Kryo 265 (Cortex-A76 / Cortex-A55) |
| Boot Header | Version 3 |
| Partition Scheme | Virtual A/B, Dynamic Partitions (super) |
| Recovery | Recovery-as-boot |
| Encryption | FBE with metadata encryption (wrappedkey_v0) |
| Display | AMOLED, 1080x2400 |
| Touch Panel | Focaltech FT3519 (Visionox) |

See full specs at https://m.gsmarena.com/motorola_moto_g42-11608.php

## What Works

- Boot
- Touch screen
- FBE Decryption (PIN/pattern)
- ADB in recovery
- Brightness control
- USB OTG
- External SD
- Flashing ZIPs (Magisk, ROMs, etc.)

## Known Issues

- Unmounting /data and remounting causes decryption keys to be lost. Reboot into recovery to re-decrypt. Avoid unmounting /data unless strictly necessary.

## Build

### Prerequisites

- Kernel and modules must come from the same ROM (LineageOS 23 recommended) to match vermagic.

### Kernel

This tree uses a prebuilt kernel extracted from LineageOS 23. To extract your own:

```bash
adb pull /dev/block/bootdevice/by-name/boot_a boot.img
unpackbootimg --boot_img boot.img --out unpacked
gzip -9 -k unpacked/kernel
cp unpacked/kernel.gz device/motorola/hawao/prebuilt/kernel
```

### Modules

Extract from a running LineageOS 23 device:

```bash
adb pull /vendor/lib/modules/ modules/
```

Place the `.ko` files in `recovery/root/vendor/lib/modules/1.1/`.

### Touch Firmware

Extract from a running LineageOS 23 device:

```bash
adb pull /vendor/firmware/ firmware/
```

Place the `focaltech-*.bin` files in `recovery/root/vendor/firmware/`.

### GitHub Actions

The easiest way to build is via GitHub Actions:

1. Fork this repository
2. Go to Actions > "Build TWRP for Moto G42" > Run workflow
3. Download the `boot.img` artifact when the build completes

### Local Build

```bash
mkdir ~/twrp && cd ~/twrp
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags
# Copy device tree to device/motorola/hawao/
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_hawao-eng
mka bootimage -j$(nproc)
```

Output: `out/target/product/hawao/boot.img`

## Installation

> **Important:** Since this device uses recovery-as-boot, TWRP is flashed to the boot partition, not recovery.

1. Boot into bootloader: `adb reboot bootloader`
2. Temporarily boot TWRP: `fastboot boot boot.img`
3. Inside TWRP: Install > flash current (makes TWRP permanent)
4. Inside TWRP: Install > Magisk.apk (installs root)
5. Reboot to system
6. Open Magisk app > Direct Install > Reboot

Do **not** attempt to patch `boot.img` with Magisk before flashing. Install Magisk from within TWRP.

## Credits

- [HemanthJabalpuri](https://github.com/HemanthJabalpuri) - Base device tree
- [TeamWin](https://github.com/TeamWin) - TWRP
- [LineageOS](https://github.com/LineageOS) - Kernel and modules
