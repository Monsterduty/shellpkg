pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "libevdev-tweak-device" "mouse-dpi-tool" "touchpad-edge-detector" "libevdev-uinput.h" "libevdev.h" "libevdev.pc" "libevdev.a" "libevdev.la" "libevdev.so.2.3.0" "touchpad-edge-detector.1" "mouse-dpi-tool.1" "libevdev-tweak-device.1" "libevdev.3" )

path=( "/usr/local/bin/" "/usr/local/include/" "/usr/local/include/libevdev-1.0/" "/usr/local/include/libevdev-1.0/libevdev/" "/usr/local/lib/" "/usr/local/lib/pkgconfig/" "/usr/local/share/" "/usr/local/share/man/" "/usr/local/share/man/man1/" "/usr/local/share/man/man3/" )

checkFiles(){

	aux="false"
	missing="false"
	uninstalled="true"

	for a in "${files[@]}";
		do

			aux="false"
		
			for b in "${path[@]}";
				do

					if [ -f $b$a ];
						then
							
						aux="true"
						uninstalled="false"
						
					fi
				
				done

				if [[ $aux == "false" ]];
					then
					
						missing="true"
					
				fi
		
		done
	
	if [[ $uninstalled == "true" ]] && [[ $flag == "" ]];
		then
		
			echo
			question "this package is uninstalled"
			exit
		
	fi
	
	if [[ $missing == "true" ]] && [[ $flag == "" ]];
		then
			
			echo
			question "this package have missing files in your system"
			exit
		
	fi

	if [[ $uninstalled == "true" ]] && [[ $flag == "deps" ]] || [[ $missing == "true" ]] && [[ $flag == "deps" ]];
		then
		
		inspkg
		exit
		
	fi

	echo "[ok]-"$1

}

question(){

	if [[ $1 != "" ]];
		then
		
			echo $1
			echo
			read -p "do you with install this package?? [yes/no] " a
			if [[ $a == [Yy]* ]];
				then
				
				inspkg
				exit
				
			fi
			
			exit
		
	fi 

}

insdeps(){

	echo "if this package need some dependencies use this!"

}

inspkg(){

	cd $workSpace
	git clone https://github.com/freedesktop/libevdev
	cd libevdev
	./autogen.sh
	./configure
	make -j $CORES
	sudo make install
	cd ..
	rm -r -f libevdev
	exit

}

rmpkg(){

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

if [[ $1 == "uninstall" ]];
	then
	
	rmpkg
	exit
	
fi

checkFiles $pkgName


