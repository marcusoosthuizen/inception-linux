set -e

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

if ! test $(whoami) == "lfs" ; then
    echo "Must be run as lfs user!"
    exit -l
fi

echo "Creating Build Environment"
cd $DIST_ROOT/build

bash -e build-scripts/binutils-pass-1.sh
bash -e build-scripts/gcc-pass-1.sh
bash -e build-scripts/linux-headers.sh
bash -e build-scripts/glibc.sh
bash -e build-scripts/libstdcpp.sh
bash -e build-scripts/m4.sh
bash -e build-scripts/ncurses.sh
bash -e build-scripts/bash.sh
bash -e build-scripts/coreutils.sh
bash -e build-scripts/diffutils.sh
bash -e build-scripts/file.sh
bash -e build-scripts/findutils.sh
bash -e build-scripts/gawk.sh
bash -e build-scripts/grep.sh
bash -e build-scripts/gzip.sh
bash -e build-scripts/make.sh
bash -e build-scripts/patch.sh
bash -e build-scripts/sed.sh
bash -e build-scripts/tar.sh
bash -e build-scripts/xz.sh
bash -e build-scripts/binutils-pass-2.sh
bash -e build-scripts/gcc-pass-2.sh
