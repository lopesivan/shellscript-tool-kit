#!/bin/bash

# CAUTION!!! THIS SCRIPT IS NO WARRANTY!!!

: << _COMMENT_
How to compile libav/x264 binaries for both 32bit and 64bit on Windows

  At first, you should install Git into your Windows.
   1. Download Git from
        http://msysgit.googlecode.com/files/Git-1.7.6-preview20110708.exe
   2. Doubleclick Git-1.7.6-preview20110708.exe
   3. "Welcome to the Git Setup Wizard" : Next>
   4. "Information" (GPLv2 descliption) : Next>
   5. "Select Destination Location" : C:\Git and Next>
   6. "Select Components" : all checks off and Next>
   7. "Select Start Menu Folder" :
        check "Don't create a Start Menu folder" and Next>
   8. "Adjusting your PATH environment" : check "Use Git Bash only" and Next>
   9. "Configuring the line ending conversions" :
         check "Checkout as-is,commit as-is" and Next>

  At second, you have to get latest MSYS, mingw/mingw-w64 binaries, pkg-config,
 subversion, nasm, yasm, and the others.
  I recommend you to use XhmikosR's toolchain.
  You will be able to get almost all latest dependencies at once.
   1. Go to http://xhmikosr.1f0.de/index.php?folder=dG9vbHM=
   2. Download MSYS_MinGW_GCC_***_x86-x64_Full.7z
     * You should download MSYS_MinGW_GCC_***_x86-x64_'Full'.7z because 
      some dependencies are not included in MSYS_MinGW_***_x86-x64.7z(e.g. perl.exe).
   3. extract it with 7zip, and put it on the place that you want (e.g. C:\MSYS).
   4. Doubleclick C:\MSYS\msys.bat
     * If you want to use other MinGW, edit /etc/fstab.

  At third, if you want to build 64bit avplay.exe, you should install
 DirectX SDK into mingw-w64.
   1. Go to http://www.microsoft.com/downloads/details.aspx?FamilyID=529f03be-1339-48c4-bd5a-8506e5acf571&displaylang=en
   2. Download dxsdk_aug2007.exe
   3. Extract dxsdk_aug2007.exe with 7zip
   4. Copy all *.h in dxsdk_aug2007\Include to C:\MSYS\mingw\x86_64-w64-mingw32\include.
       (Overwrite all the overlapping files)

  Now, you finished all the preparations to run this script.
  Save this script into $HOME as 'my_build.sh', and type './my_build.sh' on bash.

_COMMENT_

# ----------------------------------------------------------------------------
ERR_EXIT()
{
    echo $1; exit 1
}

# ---------------------------preparation for git-------------------------------
if test -z "$(git --version 2> /dev/null)" ; then
    cat > /bin/git << _EOF_
#!/bin/bash
exec /c/Git/bin/git.exe \$*
_EOF_
    test "$(git --version 2> /dev/null)" || \
        ERR_EXIT 'there is no git.exe in C:\Git\bin'
fi

# ------------------------- autotools instlation -----------------------------
# I recommend you to use mingw-autotools instead of msys-autotools.
if test -z "$(/mingw/bin/autoreconf --version 2> /dev/null)"; then
    pushd /mingw
    wget http://sourceforge.net/projects/mingw/files/MinGW/autoconf/autoconf2.5/autoconf2.5-2.67-1/autoconf2.5-2.67-1-mingw32-bin.tar.lzma
    wget http://sourceforge.net/projects/mingw/files/MinGW/automake/automake1.11/automake1.11-1.11.1-1/automake1.11-1.11.1-1-mingw32-bin.tar.lzma
    wget http://sourceforge.net/projects/mingw/files/MinGW/libtool/libtool-2.4-1/libltdl-2.4-1-mingw32-dll-7.tar.lzma
    wget http://sourceforge.net/projects/mingw/files/MinGW/libtool/libtool-2.4-1/libtool-2.4-1-mingw32-bin.tar.lzma
    for f in *.lzma; do tar xvf $f --lzma; done
    rm -f *.lzma ; cd bin/
    for f in auto* aclocal* ifname*; do cp $f `echo $f | sed -e "s/-.*//g"`; done
    if test -z "$(/mingw/bin/autoreconf --version 2> /dev/null)"; then
        rm -f auto* aclocal* ifname* libtool* libitdl*
        cd ../share ; rm -rf aclocal*/ auto*/ libtool/
        ERR_EXIT "mingw-autotools instlation failed."
    fi
    popd
fi

# ----------------------set valuables------------------------
MYBUILD=$(pwd)/mybuild
CP32="i686-pc-mingw32"; INST32="/mingw/${CP32}"
CP64="x86_64-w64-mingw32"; INST64="/mingw/${CP64}"

for p in $CP32 $CP64; do
    test -x /mingw/bin/${p}-gcc || ERR_EXIT "invalid prefix $p"
    cp /bin/pkg-config.exe /bin/${p}-pkg-config.exe
done

#If your machine isn't capable sse2, remove '-msse2' from the following lines.
CF32="-s -Os -march=i686 -mfpmath=sse -ffast-math -msse2 -fno-strict-aliasing"
CF64="-s -Os -mfpmath=sse -ffast-math -msse2 -fno-strict-aliasing"

cat > corenum.c << _EOF_
#include <stdio.h>
#include <windows.h>
#include <winbase.h>
int main(void) {SYSTEM_INFO info;GetSystemInfo(&info);
printf("%lu",info.dwNumberOfProcessors);return 0;}
_EOF_

${CP64}-gcc $CF64 -o corenum corenum.c || ERR_EXIT "invalid CFLAGS $CF64"
${CP32}-gcc $CF32 -o corenum corenum.c || ERR_EXIT "invalid CFLAGS $CF32"

CORENUM=$(corenum.exe 2>&1)
rm -f corenum.c corenum.exe
expr $CORENUM + 0 > /dev/null 2>&1 || ERR_EXIT "your gcc didn't work correctry"
test $CORENUM -gt 4 && CORENUM=4 ; CORENUM="-j${CORENUM}"
echo use $CORENUM to make.

# -----------------download source codes------------------
mkdir -p $MYBUILD/{32bit-bin,64bit-bin}
cd $MYBUILD

test -d libav || \
    git clone git://git.libav.org/libav.git libav
test -d x264_32bit || \
    git clone git://git.videolan.org/x264.git x264_32bit
test -d vo-aacenc || \
    git clone git://github.com/mstorsjo/vo-aacenc.git
test -d vo-amrwbenc || \
    git clone git://github.com/mstorsjo/vo-amrwbenc.git
test -d lame || \
    git clone git://github.com/chikuzen/lame-mingw.git lame
test -d xvidcore || \
    git clone git://github.com/chikuzen/xvidcore-mingw-w64.git xvidcore
test -d SDL || \
    git clone git://github.com/chikuzen/SDL-1.2.14-msys-mingw64.git SDL
test -d rtmpdump || \
    git clone git://github.com/chikuzen/rtmpdump.git
test -d openjpeg_32bit || \
    git clone git://github.com/chikuzen/openjpeg-mingw.git openjpeg_32bit
test -d ffms2 || \
    svn co http://ffmpegsource.googlecode.com/svn/trunk/ ffms2
test -d libogg-1.3.0 || \
    wget -O - http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz | tar zxf -
test -d libvorbis-1.3.2 || \
    wget -O - http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.bz2 | tar jxf -
test -d libtheora-1.1.1 || \
    wget -O - http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2 | tar jxf -
test -d speex-1.2rc1 || \
    wget -O - http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz | tar xvf -
test -d opencore-amr-0.1.2 || \
    wget -O - http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/0.1.2/opencore-amr-0.1.2.tar.gz | tar zxf -
test -d faac-1.28 || \
    wget -O - http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.bz2 | tar jxf -
test -d freetype-2.4.6 || \
    wget -O - http://sourceforge.net/projects/freetype/files/freetype2/2.4.6/freetype-2.4.6.tar.bz2 | tar jxf -
test -d polarssl-1.0.0 || \
    wget -O - http://polarssl.org/code/releases/polarssl-1.0.0-gpl.tgz | tar zxf -
test -d libvpx-v0.9.7-p1 || \
    wget -O - http://webm.googlecode.com/files/libvpx-v0.9.7-p1.tar.bz2 | tar jxf -
test -d x264_64bit || cp -r x264_32bit x264_64bit
test -d openjpeg_64bit || cp -r openjpeg_32bit openjpeg_64bit

for dir in libav x264_32bit x264_64bit vo-aacenc vo-amrwbenc lame xvidcore SDL rtmpdump openjpeg_32bit openjpeg_64bit ffms2 libogg-1.3.0 libvorbis-1.3.2 libtheora-1.1.1 speex-1.2rc1 opencore-amr-0.1.2 faac-1.28 freetype-2.4.6 polarssl-1.0.0 libvpx-v0.9.7-p1; do
    test -d $dir || ERR_EXIT "coudn't find sourcecode ... $dir"
done

# ----------------compiling external libraries for libav----------------------
# *I don't care about OpenCV/Frei0r/schroedinger.

#Compiling libpolarssl (librtmp requires this)
# note:
# PolarSSL's executable programs are using functions of UNIX-LIMITATION.
# Thus, you can't compile them for windows (except cygwin-gcc?) at now.
# you can only compile libraries.
cd $MYBUILD/polarssl-* && cp -r library 32bit && cp -r library 64bit
make -C 32bit CC=gcc AR=ar OFLAGS="$CF32" || \
    ERR_EXIT "32bit PolarSSL compilation failed."
make -C 64bit CC=$CP64-gcc AR=$CP64-ar OFLAGS="$CF64" || \
    ERR_EXIT "64bit PolarSSL compilation failed."
cp -r include/polarssl $INST32/include/
cp -r include/polarssl $INST64/include/
cp 32bit/libpolarssl.a $INST32/lib/
cp 64bit/libpolarssl.a $INST64/lib/

#Compiling librtmp
cd $MYBUILD/rtmpdump && git checkout patched && git pull
cp -r librtmp 32bit && cp -r librtmp 64bit
make -C 32bit prefix=$INST32 SYS=mingw CRYPTO=POLARSSL \
    XCFLAGS="$CF32" install_base || ERR_EXIT "32bit librtmp compilation failed."
make -C 64bit prefix=$INST64 CROSS_COMPILE=$CP64- SYS=mingw CRYPTO=POLARSSL \
    XCFLAGS="$CF64" install_base || ERR_EXIT "64bit librtmp compilation failed."

#Compiling freetype2
cd $MYBUILD/freetype-*; mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install || ERR_EXIT "32bit freetype2 compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host="$CP64" --prefix=$INST64 --disable-shared
make $CORENUM install || ERR_EXIT "64bit freetype2 compilation failed."

#Compiling SDL (avplay requires this as renderer)
cd $MYBUILD/SDL; mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" CXXFLAGS="$CF32" ../configure --prefix=$INST32
make $CORENUM install || ERR_EXIT "SDL-32bit compilation failed."
cp $INST32/bin/SDL.dll $MYBUILD/32bit-bin/
#Did you install DirectX SDK into the correct place?
if test -f $INST64/include/audiodefs.h; then
    cd  ../64bit
    CFLAGS="$CF64" CXXFLAGS="$CF64" ../configure --host="$CP64" --prefix=$INST64
    make $CORENUM install || ERR_EXIT "SDL-64bit compilation failed."
    cp $INST64/bin/SDL.dll $MYBUILD/64bit-bin/
else
    echo DirectX SDK is not installed. Skip
fi

#Compiling xvidcore
cd $MYBUILD/xvidcore/build/generic
CFLAGS="$CF32" ./configure --prefix=$INST32
make $CORENUM BUILD_DIR=32bit ; make BUILD_DIR=32bit install || \
    ERR_EXIT "32bit xvidcore compilation failed."
make distclean
CFLAGS="$CF64" ./configure --host=$CP64 --prefix=$INST64
make $CORENUM BUILD_DIR=64bit ; make BUILD_DIR=64bit install || \
    ERR_EXIT "64bit xvidcore compilation failed."
mv $INST32/lib/libxvidcore.dll $INST32/bin/
mv $INST64/lib/libxvidcore.dll $INST64/bin/
#if you want to use xvidcore as shared library, enable the following two lines.
#cp 32bit/libxvidcore.dll.a $INST32/lib/
#cp 64bit/libxvidcore.dll.a $INST64/lib/

#Compiling libmp3lame
cd $MYBUILD/lame && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure \
    --prefix=$INST32 --disable-shared --disable-frontend --enable-nasm
make -j1 install-strip || ERR_EXIT "32bit lame compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure \
    --host=$CP64 --prefix=$INST64 --disable-shared \
    --disable-frontend --enable-nasm CFLAGS="$CF64"
make -j1 install-strip || ERR_EXIT "64bit lame compilation failed."

#Compiling faac
# note:
# faac binary is incompatible with GPL/LGPL.
cd $MYBUILD/faac-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared --without-mp4v2
make $CORENUM install-strip || ERR_EXIT "32bit faac compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure \
    --host=$CP64 --prefix=$INST64 --disable-shared --without-mp4v2
make $CORENUM install-strip || ERR_EXIT "64bit faac compilation failed."

#Compiling opencore-amr
# note:
# opencore-amr's license(Apache 2.0) is compatible with GPLv3 or later.
cd $MYBUILD/opencore-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install-strip || ERR_EXIT "32bit opencore-amr compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host=$CP64 --prefix=$INST64 --disable-shared
make $CORENUM install-strip || ERR_EXIT "64bit opencore-amr compilation failed."

#Compiling vo-aacenc
# note:
# vo-aacenc's license(Apache 2.0) is compatible with GPLv3 or later.
cd $MYBUILD/vo-aacenc && mkdir 32bit 64bit
autoreconf -fiv || ERR_EXIT "vo-aacenc ..generate configure."
cd 32bit
../configure --prefix=$INST32 --disable-shared CFLAGS="$CF32"
make $CORENUM install-strip || ERR_EXIT "32bit vo-aacenc compilation failed."
cd ../64bit
../configure --host=$CP64 --prefix=$INST64 --disable-shared CFLAGS="$CF64"
make $CORENUM install-strip || ERR_EXIT "64bit vo-aacenc compilation failed."

#Compiling vo-amrwbenc
# note:
# vo-amrwbenc's license(Apache 2.0) is compatible with GPLv3 or later.
cd $MYBUILD/vo-amrwbenc
autoreconf -fiv || ERR_EXIT "vo-amrwbenc configure generation failed."
mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install-strip || ERR_EXIT "32bit vo-amrwbenc compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host=$CP64 --prefix=$INST64 --disable-shared
make $CORENUM install-strip || ERR_EXIT "64bit vo-amrwbenc compilation failed."

#Compiling libogg (libtheora/libvorbis/speex requires this)
cd $MYBUILD/libogg-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install-strip || ERR_EXIT "32bit libogg compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host=$CP64 --prefix=$INST64 --disable-shared
make $CORENUM install-strip || ERR_EXIT "64bit libogg compilation failed."

#Compiling libtheora
cd $MYBUILD/libtheora-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install-strip || ERR_EXIT "32bit libtheora compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host=$CP64 --prefix=$INST64 --disable-shared
make $CORENUM install-strip || ERR_EXIT "64bit libtheora compilation failed."

#Compiling libvorbis
cd $MYBUILD/libvorbis-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared
make $CORENUM install-strip || ERR_EXIT "32bit libvorbis compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure --host=$CP64 --prefix=$INST64 --disable-shared
make $CORENUM install-strip || ERR_EXIT "64bit libvorbis compilation failed."

#Compiling speex
cd $MYBUILD/speex-* && mkdir 32bit 64bit
cd 32bit
CFLAGS="$CF32" ../configure --prefix=$INST32 --disable-shared --enable-sse
make $CORENUM install-strip || ERR_EXIT "32bit speex compilation failed."
cd ../64bit
CFLAGS="$CF64" ../configure \
    --host=$CP64 --prefix=$INST64 --disable-shared --enable-sse
make $CORENUM install-strip || ERR_EXIT "64bit speex compilation failed."

#Compiling openjpeg
cd $MYBUILD/openjpeg_32bit
CFLAGS="$CF32" ./configure --prefix=$INST32 --disable-shared
make -j1 install-strip || ERR_EXIT "32bit openjpeg compilation failed."
cd $MYBUILD/openjpeg_64bit
CFLAGS="$CF64" ./configure --prefix=$INST64 --host=$CP64 --disable-shared
make -j1 install-strip || ERR_EXIT "64bit openjpeg compilation failed."

#Compiling libx264
cd $MYBUILD/x264_32bit
./configure --prefix=$INST32 --disable-cli --enable-static --disable-gpac \
    --disable-swscale --enable-win32thread --enable-strip
make $CORENUM install || ERR_EXIT "32bit libx264 compilation failed."
cd $MYBUILD/x264_64bit
./configure --prefix=$INST64 --host=$CP64 --cross-prefix=$CP64- \
    --disable-cli --enable-static --disable-gpac --disable-swscale \
    --enable-win32thread --enable-strip
make $CORENUM install || ERR_EXIT "64bit libx264 compilation failed."

#Compiling libvpx
# note:
# only 32bit
cd $MYBUILD/libvpx-* && mkdir 32bit && cd 32bit
../configure --target=x86-win32-gcc --cpu=i686 --disable-examples \
    --enable-runtime-cpu-detect
make $CORNUM || ERR_EXIT "libvpx compilation failed."
cp libvpx.a $INST32/lib/
mkdir -p $INST32/include/vpx && cp ../vpx/*.h $INST32/include/vpx/

# ------------compiling libav binaries ----------------
# note:
#  If you want to redistribute your libav binaries,
# delete '--enable-nonfree' and '--enable-libfaac' from following configures.
cd $MYBUILD/libav
mkdir 32bit 64bit ; cd 32bit
PKG_CONFIG_PATH=$INST32/lib/pkgconfig ../configure \
    --prefix=$INST32 \
    --disable-doc \
    --enable-runtime-cpudetect \
    --cpu=i686 \
    --enable-memalign-hack --disable-dxva2 \
    --enable-w32threads \
    --enable-avisynth \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopenjpeg \
    --enable-libspeex \
    --enable-libtheora \
    --enable-libvorbis --disable-encoder=vorbis \
    --enable-libvpx --disable-decoder=libvpx \
    --enable-nonfree --enable-libfaac \
    --enable-gpl \
    --enable-libx264 \
    --enable-libxvid \
    --enable-librtmp --extra-libs="-lpolarssl -lws2_32 -lwinmm -lgdi32" \
    --enable-version3 \
    --enable-libopencore-amrnb --disable-decoder=amrnb \
    --enable-libopencore-amrwb --disable-decoder=amrwb \
    --enable-libvo-aacenc \
    --enable-libvo-amrwbenc \
    --disable-debug --extra-cflags="-s -fno-strict-aliasing"
make $CORENUM install || ERR_EXIT "32bit libav compilation failed."
cp *.exe $MYBUILD/32bit-bin/

cd $MYBUILD/libav/32bit
cd ../64bit
PKG_CONFIG_PATH=$INST64/lib/pkgconfig ../configure \
    --prefix=$INST64 \
    --cross-prefix=$CP64- --target-os=mingw32 --arch=x86_64 \
    --enable-cross-compile \
    --disable-doc \
    --enable-w32threads \
    --enable-runtime-cpudetect \
    --cpu=x86_64 \
    --enable-memalign-hack --disable-dxva2 \
    --enable-avisynth \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopenjpeg \
    --enable-libspeex \
    --enable-libtheora \
    --enable-libvorbis --disable-encoder=vorbis \
    --enable-nonfree --enable-libfaac \
    --enable-gpl \
    --enable-libx264 \
    --enable-libxvid \
    --enable-librtmp --extra-libs="-lpolarssl -lws2_32 -lwinmm -lgdi32" \
    --enable-version3 \
    --enable-libopencore-amrnb --disable-decoder=amrnb \
    --enable-libopencore-amrwb --disable-decoder=amrwb \
    --enable-libvo-aacenc \
    --enable-libvo-amrwbenc \
    --disable-debug --extra-cflags="-s -fno-strict-aliasing"
make $CORENUM install || ERR_EXIT "64bit libav compilation failed."
cp *.exe $MYBUILD/64bit-bin/

# ------------compiling 32bit and 64bit x264cli with lavf/ffms input---------

#Compiling ffms2
cd $MYBUILD/ffms2
mkdir 32bit 64bit ; cd 32bit
PKG_CONFIG_PATH=$INST32/lib/pkgconfig CFLAGS="$CF32" CXXFLAGS="$CF32" \
    ../configure --prefix=$INST32
make $CORENUM install-strip || ERR_EXIT "32bit ffms2 compilation failed."
cd ../64bit
PKG_CONFIG_PATH=$INST64/lib/pkgconfig CFLAGS="$CF64" CXXFLAGS="$CF64" \
    ../configure --prefix=$INST64 --host=$CP64
make $CORENUM install-strip || ERR_EXIT "64bit ffms2 compilation failed."

#Compiling x264cli with lavf/ffms input
cd $MYBUILD/x264_32bit && make distclean
PKG_CONFIG_PATH=$INST32/lib/pkgconfig ./configure \
    --prefix=$INST32 --system-libx264 --enable-strip
make $CORENUM || ERR_EXIT "32bit x264cli compilation failed."
cp x264.exe $MYBUILD/32bit-bin/
cd $MYBUILD/x264_64bit && make distclean
PKG_CONFIG_PATH=$INST64/lib/pkgconfig ./configure \
    --prefix=$INST64 --host=$CP64 --cross-prefix=$CP64- \
    --system-libx264 --enable-strip
make $CORENUM || ERR_EXIT "64bit x264cli compilation failed."
cp x264.exe $MYBUILD/64bit-bin/

echo
echo "-----------------------------------------------------"
echo "                  F I N I S H"
echo "-----------------------------------------------------"
exit
# Now, you got your own av* and x264 in /home/user/{32bit-bin, 64bit-bin}
# Enjoy!