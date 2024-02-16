if [ -z "$BINUTILS_VERSION" ]; then
	echo "binutils version is not specified! (BINUTILS_VERSION)"
	exit 1
fi

if [ -z "$GCC_VERSION" ]; then
	echo "gcc versin is not specified! (GCC_VERSION)"
	exit 1
fi

if [ -z "$INSTALL_PATH" ]; then
	echo "install path is not specified! (INSTALL_PATH)"
	exit 1
fi

if [ -z "$TARGET_ARCH" ]; then
	echo "target architecture is not specified! (TARGET_ARCH)"
	exit 1
fi

#############################################################################

set -e

BINUTILS_TAR_XZ=binutils-$BINUTILS_VERSION.tar.xz

if [ ! -f $BINUTILS_TAR_XZ ]; then
	wget https://ftp.gnu.org/gnu/binutils/$BINUTILS_TAR_XZ
fi

tar -xf $BINUTILS_TAR_XZ

export PREFIX=$(realpath ./$INSTALL_PATH)
export TARGET=$TARGET_ARCH
export PATH=$PATH:$PREFIX/bin

mkdir -p build-binutils
cd build-binutils

../binutils-$BINUTILS_VERSION/configure --target=$TARGET --prefix=$PREFIX --with-sysroot --disable-nls --disable-werror
make -j$(nproc)
make -j$(nproc) install

cd ../

GCC_TAR_XZ=gcc-$GCC_VERSION.tar.xz

if [ ! -f $GCC_TAR_XZ ]; then
	wget https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/$GCC_TAR_XZ
fi

tar -xf $GCC_TAR_XZ

mkdir -p build-gcc
cd build-gcc

../gcc-$GCC_VERSION/configure --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c --without-headers
make -j$(nproc) all-gcc
make -j$(nproc) all-target-libgcc
make -j$(nproc) install-gcc
make -j$(nproc) install-target-libgcc

cd ../

rm -f $BINUTILS_TAR_XZ
rm -f $GCC_TAR_XZ
rm -rf binutils-$BINUTILS_VERSION
rm -rf gcc-$GCC_VERSION
rm -rf build-binutils
rm -rf build-gcc
