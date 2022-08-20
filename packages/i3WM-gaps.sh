#script made by Monsterduty

MY_DIRECTORY=$(realpath .)
echo
echo "============================================================"
echo "wellcome to the instalation wizard of i3WM-gaps for porteus!"
echo "============================================================"
echo

echo
fail="0"
echo "creating workspace directory"
mkdir i3src
echo
echo "[ok]-workspace"
echo
echo "    ╔═ downloading source dependencies ═╗";
echo "    ║                                   ║"
echo "    ║                                   ║"
echo "    ¥                                   ¥"
echo
if [ f $HOME/.config/shellpkg/tmp/error.txt ];
	then

	rm $HOME/.config/shellpkg/tmp/error.txt

fi

touch $HOME/.config/shellpkg/tmp/error.txt

workSpace=$HOME/.config/shellpkg/tmp

echo "GNU/gperf"
wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
if [ -f gperf-3.1.tar.gz ];
then
tar -xvf gperf-3.1.tar.gz
rm gperf-3.1.tar.gz
mv gperf-3.1 i3src/
echo "[ok]-GNU/gperf";
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo " 	GNU/gperf could not be downloaded!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "libxcb-cursor"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git
if [ -d libxcb-cursor ];
then
mv libxcb-cursor i3src
echo "[ok]-libxcb-cursor"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	libxbc-could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "libxcb-image"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-image.git
if [ -d libxcb-image ];
then
mv libxcb-image i3src
echo "[ok]-libxcb-image"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	libxcb-image could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-render-util.sh
	chmod u+x libxcb-render-util.sh
	mv libxcb-render-util.sh $workSpace
	$workSpace/libxcb-render-util.sh
	rm -f -r $workSpace/libxcb-render-util.sh
echo
echo "libxcb-wm"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git
if [ -d libxcb-wm ];
then
mv libxcb-wm i3src
echo "[ok]-libxcb-wm"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	libxcb-wm could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "libxcb-keysyms"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms.git
if [ -d libxcb-keysyms ];
then
mv libxcb-keysyms i3src
echo "[ok]-libxcb-keysyms"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	libxcb-keysyms could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "xcb-util-xrm"
git clone --recursive https://github.com/Airblader/xcb-util-xrm
if [ -d xcb-util-xrm ];
then
mv xcb-util-xrm i3src
echo "[ok]-xcb-util-xrm"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	xcb-util-xrm could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "libev"
git clone --recursive https://github.com/rinetd/libev
if [ -d libev ];
then
mv libev i3src
echo "[ok]-libev"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	libev could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "yajl"
git clone --recursive https://github.com/lloyd/yajl
if [ -d yajl ];
then
mv yajl i3src
echo "[ok]-yajl"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	yajl could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "i3WM-gaps"
git clone --recursive https://github.com/Airblader/i3
if [ -d i3 ];
then
mv i3 i3src
echo "[ok]-i3WM-gaps"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	i3WM could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo
echo "i3blocks"
git clone --recursive https://github.com/vivien/i3blocks
if [ -d i3blocks ];
then
mv i3blocks i3src
echo "[ok]i3blocks"
else
fail="1"
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "	i3blocks could not be cloned!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
fi
echo

aux=$(cat $HOME/.config/shellpkg/tmp/error.txt)

if [ $aux != "" ];
	then
echo
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
echo "some dependencies packages could not be downloaded!!!"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>"
exit
fi
echo
echo "-----------------------------------------------"
echo "dependencies packages are downloaded correctry!"
echo "-----------------------------------------------"
echo
echo "STARTING COMPILING PROCCESS.."
echo

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
sudo rm -r -f Makefile  config.h config.log  config.status libtool  renderutil/  stamp-h1
i3src/libxcb-image/autogen.sh
sudo make install
sudo rm -r -f Makefile config.h config.log config.status libtool  stamp-h1 image/ test/
./i3src/gperf-3.1/configure
sudo make install
sudo rm -r -f Makefile config.log config.status doc/ lib/ src/ tests/
./i3src/libxcb-cursor/autogen.sh
sudo make install
sudo rm -r -f Makefile config.log config.status cursor/ libtool xcb_util_intro
./i3src/libxcb-wm/autogen.sh
sudo make install
sudo rm -r -f Makefile config.h config.log config.status ewmh/ icccm/ libtool stamp-h1
./i3src/libxcb-keysyms/autogen.sh
sudo make install
sudo rm -r -f Makefile config.log config.status keysyms/ libtool
./i3src/xcb-util-xrm/autogen.sh
sudo make install
sudo rm -r -f Makefile config.log config.status libtoollibxcb-xrm.la src/ tests/ xcb-xrm.pc xcb_xrm_intro libtool libxcb-xrm.la
i3src/libev/configure
sudo make install
sudo rm -f -r Makefile config.h config.log config.status ev.3 ev.lo ev.o event.lo event.o libev.la libtool stamp-h1
cp -r i3src/yajl/* .
./configure
sudo make install
sudo rm -r -f BUILDING BUILDING.win32 CMakeLists.txt COPYING ChangeLog Makefile README TODO YAJLDoc.cmake build/ configure example/ perf/ reformatter/ src/ test/ verify/
cd i3src/i3blocks
./autogen.sh
./autogen.sh
./configure
make
sudo make install
cd $MY_DIRECTORY

echo export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig/ >> $HOME/.bashrc
echo export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH >> $HOME/.bashrc
source $HOME/.bashrc
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc

echo
echo "----------------------------------------------------"
echo "all the dependencies have been installed succesfully"
echo "----------------------------------------------------"
echo
echo "         <==============================>"
echo "          STARTING I3WM-GAPS COMPILATION "
echo "         <==============================>"
echo
sleep 10

cd $MY_DIRECTORY/i3src/i3
mkdir build
cd build
meson ..
ninja -C $MY_DIRECTORY/i3src/i3/build
sudo ninja -C $MY_DIRECTORY/i3src/i3/build install
cd $MY_DIRECTORY
rm -r -f build i3src
echo
if [ -f /usr/local/bin/i3 ];
then
echo "		<================================================>"
echo "		I3WM-GAPS WAS INSTALLED SUCCESFULLY!!	  "
echo "		<================================================>"
else
echo "xxxxxxxxxxxxxxxxxxxxxxxx>"
echo "failed instalation..."
echo "xxxxxxxxxxxxxxxxxxxxxxxx>"
echo
exit
fi
echo "--------------------------------------------------------------------"
echo "INSTRUCTIONS TO CONTINUE"
echo
echo "now must be appear a i3WM configuration window"
echo "configure it as you want"
echo "---------------------------------------------------------------------"
echo
echo
sleep 3
i3-config-wizard
echo 
touch /tmp/example.txt

echo 'set $mode_gaps Gaps: (o)uter, (i)nner, (h)orizontal, (v)ertical, (t)op, (r)ight, (b)ottom, (l)eft
set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_horiz Horizontal Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_verti Vertical Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_top Top Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_right Right Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_bottom Bottom Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_left Left Gaps: +|-|0 (local), Shift + +|-|0 (global)
bindsym $mod+Shift+g mode "$mode_gaps"

mode "$mode_gaps" {
        bindsym o      mode "$mode_gaps_outer"
        bindsym i      mode "$mode_gaps_inner"
        bindsym h      mode "$mode_gaps_horiz"
        bindsym v      mode "$mode_gaps_verti"
        bindsym t      mode "$mode_gaps_top"
        bindsym r      mode "$mode_gaps_right"
        bindsym b      mode "$mode_gaps_bottom"
        bindsym l      mode "$mode_gaps_left"
        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}

mode "$mode_gaps_outer" {
        bindsym plus  gaps outer current plus 5
        bindsym minus gaps outer current minus 5
        bindsym 0     gaps outer current set 0

        bindsym Shift+plus  gaps outer all plus 5
        bindsym Shift+minus gaps outer all minus 5
        bindsym Shift+0     gaps outer all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_inner" {
        bindsym plus  gaps inner current plus 5
        bindsym minus gaps inner current minus 5
        bindsym 0     gaps inner current set 0

        bindsym Shift+plus  gaps inner all plus 5
        bindsym Shift+minus gaps inner all minus 5
        bindsym Shift+0     gaps inner all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_horiz" {
        bindsym plus  gaps horizontal current plus 5
        bindsym minus gaps horizontal current minus 5
        bindsym 0     gaps horizontal current set 0

        bindsym Shift+plus  gaps horizontal all plus 5
        bindsym Shift+minus gaps horizontal all minus 5
        bindsym Shift+0     gaps horizontal all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_verti" {
        bindsym plus  gaps vertical current plus 5
        bindsym minus gaps vertical current minus 5
        bindsym 0     gaps vertical current set 0

        bindsym Shift+plus  gaps vertical all plus 5
        bindsym Shift+minus gaps vertical all minus 5
        bindsym Shift+0     gaps vertical all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_top" {
        bindsym plus  gaps top current plus 5
        bindsym minus gaps top current minus 5
        bindsym 0     gaps top current set 0

        bindsym Shift+plus  gaps top all plus 5
        bindsym Shift+minus gaps top all minus 5
        bindsym Shift+0     gaps top all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_right" {
        bindsym plus  gaps right current plus 5
        bindsym minus gaps right current minus 5
        bindsym 0     gaps right current set 0

        bindsym Shift+plus  gaps right all plus 5
        bindsym Shift+minus gaps right all minus 5
        bindsym Shift+0     gaps right all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_bottom" {
        bindsym plus  gaps bottom current plus 5
        bindsym minus gaps bottom current minus 5
        bindsym 0     gaps bottom current set 0

        bindsym Shift+plus  gaps bottom all plus 5
        bindsym Shift+minus gaps bottom all minus 5
        bindsym Shift+0     gaps bottom all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_left" {
        bindsym plus  gaps left current plus 5
        bindsym minus gaps left current minus 5
        bindsym 0     gaps left current set 0

        bindsym Shift+plus  gaps left all plus 5
        bindsym Shift+minus gaps left all minus 5
        bindsym Shift+0     gaps left all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}' >> /tmp/example.txt

touch $HOME/.config/shellpkg/tmp/i3.txt
echo "[Desktop Entry]
Name=I3WM-gaps
Type=Application
Comment=i3WM-gaps
TryExec=i3
Exec=i3" >> $HOME/.config/shellpkg/tmp/i3.txt
sudo mv -f $HOME/.config/shellpkg/tmp/i3.txt /usr/share/xsessions/i3.desktop

echo
echo "----------------------------------------------------------------------"
echo "exelent"
echo 
echo "now will appear the config file that whas created by i3WM-instalation-wizard,"
echo "an example to use the gaps mode, and your new .xinitrc"
echo "go to last line of the i3WM config file to find the bar configuration and change"
echo "i3status with i3blocks, then copy all the text of the example.txt"
echo " and paste in the end of your i3WM config file."
echo
echo "optionaly, in the .xinitrc you can change your window manager by default"
echo "with i3 an then when you execute the command startx i3 will appear instead"
echo '----------------------------------------------------------------------'

sleep 10

textEditor=$(cat $HOME/.config/shellpkg/editor.txt)

$textEditor $HOME/.config/i3/config /tmp/example.txt $HOME/.xinitrc

echo "      | please type: source $HOME/.bashrc |"

#script made by Monsterduty
