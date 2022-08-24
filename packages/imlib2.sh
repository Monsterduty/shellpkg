pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "imlib2_grab" "imlib2_view" "imlib2_colorspace" "imlib2_poly" "imlib2_bumpmap" "imlib2_test" "imlib2_show" "imlib2_load" "imlib2_conv" "Imlib2.h" "imlib2.pc" "colormod.la" "colormod.so" "bumpmap.la" "bumpmap.so" "testfilter.la" "testfilter.so" "zlib.la" "zlib.so" "lzma.la" "lzma.so" "bz2.la" "bz2.so" "webp.la" "webp.so" "tiff.la" "tiff.so" "svg.la" "svg.so" "png.la" "png.so" "j2k.la" "j2k.so" "jpeg.la" "jpeg.so" "gif.la" "gif.so" "xpm.la" "xpm.so" "xbm.la" "xbm.so" "tga.la" "tga.so" "pnm.la" "pnm.so" "lbm.la" "lbm.so" "ico.la" "ico.so" "ff.la" "ff.so" "bmp.la" "bmp.so" "argb.la" "argb.so" "libImlib2.a" "libImlib2.la" "libImlib2.so.1.9.1" "tnt.png" "stop.png" "sh3.png" "sh2.png" "sh1.png" "paper.png" "mush.png" "menu.png" "mail.png" "lock.png" "imlib2.png" "globe.png" "folder.png" "calc.png" "cal.png" "bulb.png" "bg.png" "audio.png" "notepad.ttf" "morpheus.ttf" "grunge.ttf" "cinema.ttf" )

path=( "/usr/local/bin/" "/usr/local/include/" "/usr/local/lib/" "/usr/local/lib/pkgconfig/" "/usr/local/lib/imlib2/" "/usr/local/lib/imlib2/filters/" "/usr/local/lib/imlib2/loaders/" "/usr/local/share/" "/usr/local/share/imlib2/" "/usr/local/share/imlib2/data/" "/usr/local/share/imlib2/data/images/" "/usr/local/share/imlib2/data/fonts/" )

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
	wget https://downloads.sourceforge.net/enlightenment/imlib2-1.9.1.tar.xz
	tar -xvf imlib2-1.9.1.tar.xz
	rm imlib2-1.9.1.tar.xz
	cd imlib2-1.9.1
	./configure
	make -j $CORES
	sudo make install
	cd ..
	rm -r -f imlib2-1.9.1
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


