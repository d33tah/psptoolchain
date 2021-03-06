#!/bin/sh
# gcc-stage1.sh by Dan Peori (danpeori@oopo.net) customized by yreeen(yreeen@gmail.com)

 ## set gcc version
 GCC_VERSION=4.6.3
 GMP_VERSION=5.1.0
 MPC_VERSION=1.0.1
 MPFR_VERSION=3.1.1

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2

 ## Download the library source code.
 wget --continue ftp://ftp.gmplib.org/pub/gmp-$GMP_VERSION/gmp-$GMP_VERSION.tar.bz2
 wget --continue http://www.multiprecision.org/mpc/download/mpc-$MPC_VERSION.tar.gz
 wget --continue http://www.mpfr.org/mpfr-$MPFR_VERSION/mpfr-$MPFR_VERSION.tar.bz2

 ## Unpack the source code.
 rm -Rf gcc-$GCC_VERSION
 tar xfj gcc-$GCC_VERSION.tar.bz2

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION
 patch -p1 < ../../patches/gcc-$GCC_VERSION-PSP.patch

 ## Unpack the library source code.
 tar xfj ../gmp-$GMP_VERSION.tar.bz2 && ln -s gmp-$GMP_VERSION gmp
 tar xfz ../mpc-$MPC_VERSION.tar.gz && ln -s mpc-$MPC_VERSION mpc
 tar xfj ../mpfr-$MPFR_VERSION.tar.bz2 && ln -s mpfr-$MPFR_VERSION mpfr

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --enable-languages="c" --enable-lto --with-newlib --with-gmp --with-mpfr --without-headers --disable-libssp

 ## Compile and install.
 make clean
 make $MAKEFLAGS
 make install
 make clean
