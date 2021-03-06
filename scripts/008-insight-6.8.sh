#!/bin/sh
# insight-6.8.sh by Dan Peori (danpeori@oopo.net)
exit;

 ## Exit on errors
 set -e

 ## Download the source code.
 wget --continue ftp://sourceware.org/pub/insight/releases/insight-6.8.tar.bz2

 ## Unpack the source code.
 rm -Rf insight-6.8
 tar xfj insight-6.8.tar.bz2

 ## Enter the source directory and patch the source code.
 cd insight-6.8
 patch -p1 < ../../patches/insight-6.8-PSP.patch

 ## Create and enter the build directory.
 mkdir build-psp
 cd build-psp

 ## Configure the build.
 CFLAGS="$CFLAGS -I/opt/local/include" CPPFLAGS="$CPPFLAGS -I/opt/local/include" LDFLAGS="$LDFLAGS -L/opt/local/lib" ../configure --prefix="$PSPDEV" --target="psp" --disable-nls --disable-werror

 ## Compile and install.
 make clean
 make $MAKEFLAGS
 make install
 make clean
