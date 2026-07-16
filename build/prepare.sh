echo "Printing Environment Variables"
echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

mkdir -p $LFS/sources

echo "Downloading Build Packages"
while read url
do
    pkg=$(basename $url)

    if ! test -f $LFS/sources/$pkg ; then
        wget $url -O $LFS/sources/$pkg
    fi

done < "$DIST_ROOT/build/pkg-list"


echo "Creating Limited Directory Layout"
mkdir -pv $LFS/{etc,var,lib64,tools} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

if ! test $(id -u lfs) ; then
    echo "Creating Build User"
    groupadd lfs
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs
    passwd lfs

    chown -v lfs $LFS/{usr{,/*},var,etc,tools,lib64,sources}


    home=$(eval echo "~lfs")

cat > $home/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > $home/.bashrc << EOF
set +h
umask 022
LFS=$LFS
export DIST_ROOT=$DIST_ROOT
EOF

cat >> $home/.bashrc << "EOF"
set +h
umask 022
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS="-j$(nproc)"
EOF

fi
