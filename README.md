# Hyper Gallery AI Module

## DISCLAIMER
- Miui apps are owned by Xiaomi™.
- The MIT license specified here is for the Magisk Module only, not for Miui apps.

## Descriptions
Gallery app by Xiaomi Inc. ported and integrated as a Magisk Module for all supported and rooted devices with Magisk

## Sources
- https://apkmirror.com com.miui.gallery by Xiaomi Inc.
- libmagiskpolicy.so: Magisk (stable) 30.7 (30700)

## Changelog

v1.1 (mbenanaya)
- Update MiuiGallery.apk to v4.3.1.16 CN (stock Xiaomi-signed build)

v1.0 (mbenanaya)
- Ported to HyperCore-A16 (`id=HyperCoreA16`, v1.1+) instead of Miui Core Magisk Module
- Renamed module id to HyperGalleryAI
- arm64-v8a only, minimum SDK 34
- Removes conflicting MiuiGallery / MIUIGallery / HyperGallery modules (same com.miui.gallery package)
- Checks for Hyper Gallery Editor instead of Miui Gallery Editor

v0.4
- Prepare /storage/emulated/"$UID"/Android/data/com.miui.gallery/files/mounted & com.miui.gallery/cache
- Update libmagiskpolicy.so from Magisk (stable) 30.7 (30700)
- Resets module folders/files permissions at post-fs-data
- Move _uninstall.log to /data/adb/logs/

v0.3
- Modify MiuiGallery.apk to fix crashes and System UI visibility
- Using ro.gallery.device and ro.gallery.manufacturer instead of ro.product.device and ro.product.manufacturer

v0.2
- Add Action button to clear app caches
- Fix architecture detection in some weird ROMs
- Fix bug in uninstall.sh
- Update MiuiGallery.apk to v4.1.0.9-ai

v0.1
- Initial release

## Requirements
- HyperCore-A16 v1.1+ installed first (provides com.miui.core, com.miui.system, com.miui.rom, micloud-sdk, security-device-credential-sdk.jar)
- arm64-v8a architecture
- Android 14 (SDK 34) and up
- Magisk or Kitsune Mask or KernelSU or Apatch installed

## Installation Guide & Download Link
- If you are using KernelSU, you need to disable Unmount Modules by Default in KernelSU app settings and install https://github.com/KernelSU-Modules-Repo/meta-overlayfs or https://github.com/KernelSU-Modules-Repo/magic_mount_rs or https://github.com/KernelSU-Modules-Repo/hybrid_mount or https://github.com/maxsteeel/nomount first depending on ROM compatibility
- Install HyperCore-A16 v1.1+ first and reboot
- Install this module via Magisk app or Kitsune Mask app or KernelSU app or Apatch app or Recovery if Magisk or Kitsune Mask installed
- Install Hyper Gallery Editor module first (HyperGalleryEditor)
- Reboot
- If you are using KernelSU, you need to allow superuser list manually all package name listed in package.txt (and your home launcher app also) (enable show system apps) and reboot afterwards
- If you are using SUList, you need to allow list manually your home launcher app (enable show system apps) and reboot afterwards
- Go to app info of Gallery and Gallery Editor app and allow the network access to be able to download the online features

## Known Issue
- The apk is the stock CN build, unpatched, so it may crash on non-HyperOS ROMs

## Support & Bug Report
- https://github.com/mben25/HyperGalleryAI/issues

## Credits and Contributors
- HyperCore-A16 port: mbenanaya
