pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "picom.conf" "compton.svg" "compton.png" "picom.desktop" "compton.desktop" "picom-trans" "picom" )

path=( "$HOME/.config/picom/" "/usr/local/share/" "/usr/local/share/icons/" "/usr/local/share/icons/hicolor/" "/usr/local/share/icons/hicolor/scalable/" "/usr/local/share/icons/hicolor/scalable/apps/" "/usr/local/share/icons/hicolor/48x48/" "/usr/local/share/icons/hicolor/48x48/apps/" "/usr/local/share/applications/" "/usr/local/bin/" )

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

	mkdir deps
	cd deps
	prefix="https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/"
	deps=( "libconfig.sh" "libxcb-render-util.sh" "libxcb-image.sh" "libxcb-cursor.sh" "libev.sh" "uthash.sh" )
	for a in "${deps[@]}";
		do

			wget $prefix$a

		done
	chmod u+x *

	for a in "${deps[@]}";
		do

			./$a deps

		done
	cd ..
	rm -r -f deps

}

inspkg(){

	cd $workSpace
	insdeps
	git clone --recursive https://github.com/sdhand/picom
	cd picom
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig:$PKG_CONFIG_PATH
	meson --buildtype=release build
	cd build
	ninja
	sudo ninja install
	cd ..
	mkdir $HOME/.config/picom
	cp picom.sample.conf $HOME/.config/picom/picom.conf
	sed -i 's\vsync = true\vsync = false\' $HOME/.config/picom/picom.conf
	cd ..
	rm -r -f picom
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


