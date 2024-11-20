## Introduction

I've setup a few [installs of Linux Mint Debian Edition (LMDE)](https://www.dwarmstrong.org/lmde-install-expert-mode/) for family, friends, and myself. I really like it! Mint's **Cinnamon** desktop comes with sensible defaults, is easy to customize, and intuitive to use for new and old Linux users alike.

**MintyFresh** is a script to configure a device after a fresh install of **LMDE 6 aka "Faye"**.

Run `mintyfresh.sh -h` for options.

## Summary

* Upgrade system
* Install extra packages
* Auto-remove obsolete kernels and dependencies
* Enable [zram for swap](https://www.dwarmstrong.org/zram-linuxmint/)
* Customize GRUB bootloader

## How does it work?

Sync package repositories and install `git`:

```
$ sudo apt update && sudo apt install git
```

Download:

```
$ git clone https://gitlab.com/dwarmstrong/mintyfresh.git
```

Change directory and run script with your primary username as the sole argument:

```
$ cd mintyfresh
$ sudo ./mintyfresh.sh <your_primary_username>
```

## Author

[Daniel Wayne Armstrong](https://www.dwarmstrong.org)

## License

GPLv3. See [LICENSE](https://gitlab.com/dwarmstrong/MintyFresh/-/blob/main/LICENSE.md) for more details.
