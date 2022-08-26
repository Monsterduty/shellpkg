pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "iconv" "iconv.h" "localcharset.h" "libcharset.h" "libiconv.so.2.6.1" "libiconv.la" "libcharset.a" "libcharset.so.1.0.0" "libcharset.la" "iconvctl.3.html" "iconv_open_into.3.html" "iconv_open.3.html" "iconv_close.3.html" "iconv.3.html" "iconv.1.html" "iconvctl.3" "iconv_open_into.3" "iconv_open.3" "iconv_close.3" "iconv.3" "iconv.1" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" "libiconv.mo" )

path=( "/usr/local/bin/" "/usr/local/include/" "/usr/local/lib/" "/usr/local/share/" "/usr/local/share/doc/" "/usr/local/share/man/" "/usr/local/share/man/man3/" "/usr/local/share/man/man1/" "/usr/local/share/locale/" "/usr/local/share/locale/zh_TW/" "/usr/local/share/locale/zh_TW/LC_MESSAGES/" "/usr/local/share/locale/zh_CN/" "/usr/local/share/locale/zh_CN/LC_MESSAGES/" "/usr/local/share/locale/wa/" "/usr/local/share/locale/wa/LC_MESSAGES/" "/usr/local/share/locale/vi/" "/usr/local/share/locale/vi/LC_MESSAGES/" "/usr/local/share/locale/uk/" "/usr/local/share/locale/uk/LC_MESSAGES/" "/usr/local/share/locale/tr/" "/usr/local/share/locale/tr/LC_MESSAGES/" "/usr/local/share/locale/sv/" "/usr/local/share/locale/sv/LC_MESSAGES/" "/usr/local/share/locale/sr/" "/usr/local/share/locale/sr/LC_MESSAGES/" "/usr/local/share/locale/sq/" "/usr/local/share/locale/sq/LC_MESSAGES/" "/usr/local/share/locale/sl/" "/usr/local/share/locale/sl/LC_MESSAGES/" "/usr/local/share/locale/sk/" "/usr/local/share/locale/sk/LC_MESSAGES/" "/usr/local/share/locale/ru/" "/usr/local/share/locale/ru/LC_MESSAGES/" "/usr/local/share/locale/ro/" "/usr/local/share/locale/ro/LC_MESSAGES/" "/usr/local/share/locale/rm/" "/usr/local/share/locale/rm/LC_MESSAGES/" "/usr/local/share/locale/pt_BR/" "/usr/local/share/locale/pt_BR/LC_MESSAGES/" "/usr/local/share/locale/pl/" "/usr/local/share/locale/pl/LC_MESSAGES/" "/usr/local/share/locale/nl/" "/usr/local/share/locale/nl/LC_MESSAGES/" "/usr/local/share/locale/lt/" "/usr/local/share/locale/lt/LC_MESSAGES/" "/usr/local/share/locale/ko/" "/usr/local/share/locale/ko/LC_MESSAGES/" "/usr/local/share/locale/ja/" "/usr/local/share/locale/ja/LC_MESSAGES/" "/usr/local/share/locale/it/" "/usr/local/share/locale/it/LC_MESSAGES/" "/usr/local/share/locale/id/" "/usr/local/share/locale/id/LC_MESSAGES/" "/usr/local/share/locale/hu/" "/usr/local/share/locale/hu/LC_MESSAGES/" "/usr/local/share/locale/hr/" "/usr/local/share/locale/hr/LC_MESSAGES/" "/usr/local/share/locale/gl/" "/usr/local/share/locale/gl/LC_MESSAGES/" "/usr/local/share/locale/ga/" "/usr/local/share/locale/ga/LC_MESSAGES/" "/usr/local/share/locale/fr/" "/usr/local/share/locale/fr/LC_MESSAGES/" "/usr/local/share/locale/fi/" "/usr/local/share/locale/fi/LC_MESSAGES/" "/usr/local/share/locale/et/" "/usr/local/share/locale/et/LC_MESSAGES/" "/usr/local/share/locale/es/" "/usr/local/share/locale/es/LC_MESSAGES/" "/usr/local/share/locale/eo/" "/usr/local/share/locale/eo/LC_MESSAGES/" "/usr/local/share/locale/el/" "/usr/local/share/locale/el/LC_MESSAGES/" "/usr/local/share/locale/de/" "/usr/local/share/locale/de/LC_MESSAGES/" "/usr/local/share/locale/da/" "/usr/local/share/locale/da/LC_MESSAGES/" "/usr/local/share/locale/cs/" "/usr/local/share/locale/cs/LC_MESSAGES/" "/usr/local/share/locale/ca/" "/usr/local/share/locale/ca/LC_MESSAGES/" "/usr/local/share/locale/bg/" "/usr/local/share/locale/bg/LC_MESSAGES/" "/usr/local/share/locale/af/" "/usr/local/share/locale/af/LC_MESSAGES/" )

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
	wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz
	tar -xvf libiconv-1.17.tar.gz
	rm libiconv-1.17.tar.gz
	cd libiconv-1.17
	./configure
	make -j $CORES
	sudo make install
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


