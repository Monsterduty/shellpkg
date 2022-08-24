pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "axel" "axel.1" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" "axel.mo" )

path=( "/usr/local/bin/" "/usr/local/share/" "/usr/local/share/man/" "/usr/local/share/man/man1/" "/usr/local/share/locale/" "/usr/local/share/locale/zh_CN/" "/usr/local/share/locale/zh_CN/LC_MESSAGES/" "/usr/local/share/locale/tr/" "/usr/local/share/locale/tr/LC_MESSAGES/" "/usr/local/share/locale/ru/" "/usr/local/share/locale/ru/LC_MESSAGES/" "/usr/local/share/locale/pt_BR/" "/usr/local/share/locale/pt_BR/LC_MESSAGES/" "/usr/local/share/locale/nl/" "/usr/local/share/locale/nl/LC_MESSAGES/" "/usr/local/share/locale/ja/" "/usr/local/share/locale/ja/LC_MESSAGES/" "/usr/local/share/locale/it/" "/usr/local/share/locale/it/LC_MESSAGES/" "/usr/local/share/locale/id_ID/" "/usr/local/share/locale/id_ID/LC_MESSAGES/" "/usr/local/share/locale/es/" "/usr/local/share/locale/es/LC_MESSAGES/" "/usr/local/share/locale/de/" "/usr/local/share/locale/de/LC_MESSAGES/" )

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
	wget https://github.com/axel-download-accelerator/axel/releases/download/v2.17.11/axel-2.17.11.tar.gz
	tar -xvf axel-2.17.11.tar.gz
	rm axel-2.17.11.tar.gz
	cd axel-2.17.11
	./configure
	make -j $CORES
	sudo make install
	cd ..
	rm -f -r axel-2.17.11
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


