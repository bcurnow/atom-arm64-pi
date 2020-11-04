# atom-arm64-pi

# Installation Instructions
* Run the docker container (see `docker.sh` for a convieniece script)
* Edit `/opt/atom/build/atom/script/package.json` and change the minidump dependency to 0.19.0 or higher (0.9.0 would not correctly compile on ARM64
* From the `/opt/atom/build/atom` directory, run `script/build --compress-artifacts --create-debian-package --create-rpm-package` (this will take a while)
