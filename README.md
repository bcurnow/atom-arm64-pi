# atom-arm64-pi

Wouldn't it be nice if this worked? I got fairly far with the process of building a Docker container on my Raspberry Pi 4 to build Atom. What ultimately stopped me was electron-mksnapshot which, despite what the documentation may say, does not have an ARM64 compatible distribution as of 11/3/2020. I did follow the instructions but it appears the only way to build Atom for the ARM64 is to cross-compile on an X64 box. I'm going to look into this approach next but I thought I'd make this public in case electron-mksnapshot provides ARM64 compatibility or just for folks to see how I did it.

# Installation Instructions
* Run the docker container (see `docker.sh` for a convieniece script)
* Edit `/opt/atom/build/atom/script/package.json` and change the minidump dependency to 0.19.0 or higher (0.9.0 would not correctly compile on ARM64
* From the `/opt/atom/build/atom` directory, run `script/build --compress-artifacts --create-debian-package --create-rpm-package` (this will take a while)
