# Hyper Gallery AI changelog

## v1.3 (4)
- Fix empty gallery (no photos/videos): set `GLOBAL_FIRST_CLEAN_TAG=false` at boot so ScannerEngine starts. CN build runs as international on this ROM, but its Google clean-data step is stubbed and never clears the flag.

## v1.2 (3)
- Re-release to test KernelSU Next OTA update from GitHub (no app changes).

## v1.1 (2)
- Update MiuiGallery.apk to Gallery 4.3.1.16 CN (stock, Xiaomi-signed, target SDK 35).

## v1.0 (1)
- Initial HyperCore-A16 release (Gallery 4.1.0.9 AI).
- Add `updateJson` so KernelSU Next / Magisk / APatch can update the module from the manager.
