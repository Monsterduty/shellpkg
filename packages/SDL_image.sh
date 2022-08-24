pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp

files=( "SDL_image.h" "SDL2_image.pc" "sdl2_image-config-version.cmake" "sdl2_image-config.cmake" "libSDL2_image.a" "libSDL2_image.la" "libSDL2_image-2.0.so.0.700.0" )

path=( "/usr/local/include/" "/usr/local/include/SDL2/" "/usr/local/lib/" "/usr/local/lib/pkgconfig/" "/usr/local/lib/cmake/" "/usr/local/lib/cmake/SDL2_image/" )

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
	
	if [[ $uninstalled == "true" ]];
		then
		
			echo
			question "this package is uninstalled"
			exit
		
	fi
	
	if [[ $missing == "true" ]];
		then
		
			echo
			question "this package have missing files in your system"
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
	git clone https://github.com/libsdl-org/SDL_image
	cd SDL_image
	./configure
	make -j $CORES
	sudo make install
	cd ..
	rm -r -f SDL_image
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

if [[ $1 == "deps" ]];
	then
	
	inspkg
	exit
	
fi

checkFiles $pkgName


