echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

if ! test $(whoami) == "lfs" ; then
    echo "Must be run as lfs user!"
    exit -l
fi
