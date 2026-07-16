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
