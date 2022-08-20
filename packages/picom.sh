fail="0"
echo "creating workspace directory"
mkdir picomsrc
echo "[ok] workspace"
echo
echo "downloading source dependencies...";
echo
echo "libxcb-cursor"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git
if [ -d libxcb-cursor ];
then
mv libxcb-cursor picomsrc
echo "[ok]-libxcb-cursor"
else
fail="1"
echo "libxbc-could not be cloned!"
fi
echo
echo "libxcb-image"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-image.git
if [ -d libxcb-image ];
then
mv libxcb-image picomsrc
echo "[ok]-libxcb-image"
else
fail="1"
echo "libxcb-image could not be cloned!"
fi
echo
echo "render-util"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util.git
if [ -d libxcb-render-util ];
then
mv libxcb-render-util picomsrc
echo "[ok]-libxcb-render-util";
else
fail="1"
echo "libxcb-render-util could not be cloned!"
fi
echo
echo "libev"
git clone --recursive https://github.com/rinetd/libev
if [ -d libev ];
then
mv libev picomsrc
echo "[ok]-libev"
else
fail="1"
echo "libev could not be cloned!"
fi
echo
echo echo "libconfig"
git clone --recursive https://github.com/hyperrealm/libconfig
if [ -d libconfig ];
then
mv libconfig picomsrc
echo "[ok]-libconfig"
else
fail="1"
echo "libconfig could not be cloned!"
fi
echo
echo "uthash"
git clone --recursive https://github.com/troydhanson/uthash
if [ -d uthash ];
then
mv uthash picomsrc
echo "[ok]-uthash"
else
fail="1"
echo "uthash could not be cloned!"
fi
echo
echo "picom"
git clone --recursive https://github.com/yshui/picom
if [ -d picom ];
then
mv picom picomsrc
echo "[ok]-picom"
else
fail="1"
echo "picom could not be cloned!"
fi
if [ $fail = "1" ];
then
echo
echo "some dependencies packages could not be downloaded"
exit
fi
echo
echo "-----------------------------------------------"
echo "dependencies packages are downloaded correctly!"
echo "-----------------------------------------------"
echo
echo "STARTING COMPILING PROCCESS.."
echo

./picomsrc/libxcb-render-util/autogen.sh
sudo make install
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
sudo rm -r -f Makefile  config.h config.log  config.status libtool  renderutil/  stamp-h1

./picomsrc/libxcb-image/autogen.sh
sudo make install
sudo rm -r -f Makefile config.h config.log config.status libtool  stamp-h1 image/ test/

picomsrc/libev/configure
sudo make install
sudo rm -f -r Makefile config.h config.log config.status ev.3 ev.lo ev.o event.lo event.o libev.la libtool stamp-h1

sudo cp picomsrc/uthash/src/* /usr/include

MY_DIRECTORY=$(realpath .)
autoreconf $MY_DIRECTORY/picomsrc/libconfig
$MY_DIRECTORY/picomsrc/libconfig/configure
sudo make install
sudo rm -r -f Makefile ac_config.h config.log config.status doc examples/ lib libconfig.spec libtool stamp-h1 tests/ tinytest/

echo
echo "--------------------------------------------"
echo "dependencies has been compiled and installed"
echo "--------------------------------------------"
echo
echo "<=========================>"
echo " now we can compile picom!"
echo "<=========================>"
sleep 3
echo

meson --buildtype=release $MY_DIRECTORY/picomsrc/picom/ build --prefix=/usr
ninja -C build
sudo ninja -C build install
mkdir $HOME/.config/picom
cp picomsrc/picom/picom.sample.conf $HOME/.config/picom/picom.conf
rm -r -f build
echo
echo export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig/ >> $HOME/.bashrc
echo export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH >> $HOME/.bashrc
source $HOME/.bashrc
rm -r -f picomsrc
touch $HOME/.config/picom/picom.config
echo
echo "please type: source $HOME/.bashrc"
echo
