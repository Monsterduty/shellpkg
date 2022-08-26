pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "xcb_cursor.h" "xcb-cursor.pc" "libxcb-cursor.a" "libxcb-cursor.la" "libxcb-cursor.so.0.0.0" )

path=( "/usr/local/include/" "/usr/local/include/xcb/" "/usr/local/lib/" "/usr/local/lib/pkgconfig/" )

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

	cd $workSpace
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/gperf.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-render-util.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-image.sh
	chmod u+x *
	./gperf.sh deps
	./libxcb-render-util.sh deps
	./libxcb-image.sh deps
	rm *

}

inspkg(){

	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
	insdeps
	cd $workSpace
	git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git
	cd libxcb-cursor
	./autogen.sh
	make -j $CORES
	sudo make install
	cd ..
	rm -r -f libxcb-cursor
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


