path=("/usr/local/include/xcb/" "/usr/local/lib/" "/usr/local/lib/pkgconfig/")

files=("xcb_renderutil.h" "libxcb-render-util.a" "libxcb-render-util.so" "libxcb-render-util.so.0.0.0" "libxcb-render-util.la" "libxcb-render-util.so.0" "xcb-renderutil.pc")

CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
temp=$HOME/.config/shellpkg/tmp

uninstall(){

    for a in "${files[@]}";
        do

            for b in "${path[@]}";
                do

                    if [ -f $b$a ];
                        then

                        sudo rm -r -f $b$a          

                    fi

                done

        done
}

checkFiles(){

    aux="false"
    missing="false"

    for a in "${files[@]}";
        do

            for b in "${path[@]}";
                do

                    if [ -f $b$a ];
                        then

                        aux="true"          

                    fi

                done

			if [ $aux == "false" ];
				then
				missing="true"
			fi

        done

    if [ $aux == "false" ];
        then

        echo "this dependencie is not installed"
        echo
        return

    fi

    if [ $missing == "true" ];
        then

        echo "this packages is incomplete"
        echo
		return

    fi

	echo "[ok]-libxcb-render-util"
	exit
}

if [[ $1 == "uninstall" ]];
	then

	uninstall
	echo "libxcb-render-util was uninstalled succesfuly"
	echo
	exit

fi

checkFiles

if [[ $1 != 'deps' ]];
    then

    read -p "do you wish install this packages?? [yes/no] " a

    if [[ $a == [Nn]* ]];
        then
        exit
    fi

fi



fail="0"

echo "render-util"
git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util.git
if [ -d libxcb-render-util ];
	then
	mv libxcb-render-util $temp
else
	fail="1"
	echo "libxcb-render-util could not be cloned!"
	if [ -f $HOME/.config/shellpkg/tmp/error.txt ];
		then
		echo "libxcb-render-util" >> $HOME/.config/shellpkg/tmp/error.txt

	fi
	exit
fi

cd $temp
libxcb-render-util/autogen.sh
make -j $CORES
sudo make install
sudo rm -r -f $temp/libxcb-render-util
echo
