cd $LFS/sources
tar -xf glibc-2.43.tar.xz
cd glibc-2.43
# /////////////////// #
ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3

patch -Np1 -i ../glibc-fhs-1.patch

mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.4

make
make DESTDIR=$LFS install

echo
echo ////// Testing Glibc //////
sleep 5

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log
grep -B3 "^ $LFS/usr/include" dummy.log
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log

sleep 5

rm -v a.out dummy.log
# /////////////////// #
cd $LFS/sources
rm -rf glibc-2.43
