pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( ".nanorc" "nano" "yaml.nanorc" "xml.nanorc" "texinfo.nanorc" "tex.nanorc" "tcl.nanorc" "sql.nanorc" "sh.nanorc" "rust.nanorc" "ruby.nanorc" "python.nanorc" "po.nanorc" "php.nanorc" "perl.nanorc" "patch.nanorc" "ocaml.nanorc" "objc.nanorc" "nftables.nanorc" "nanorc.nanorc" "nanohelp.nanorc" "markdown.nanorc" "man.nanorc" "makefile.nanorc" "lua.nanorc" "json.nanorc" "javascript.nanorc" "java.nanorc" "html.nanorc" "guile.nanorc" "groff.nanorc" "go.nanorc" "email.nanorc" "elisp.nanorc" "default.nanorc" "css.nanorc" "c.nanorc" "cmake.nanorc" "changelog.nanorc" "awk.nanorc" "autoconf.nanorc" "asm.nanorc" "spec.nanorc" "povray.nanorc" "haskell.nanorc" "fortran.nanorc" "ada.nanorc" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nano.mo" "nanorc.5" "rnano.1" "nano.1" "dir" "nano.info" "nano.html" "faq.html" )

path=( "$HOME/" "/usr/local/bin/" "/usr/local/share/" "/usr/local/share/nano/" "/usr/local/share/nano/extra/" "/usr/local/share/locale/" "/usr/local/share/locale/zh_TW/" "/usr/local/share/locale/zh_TW/LC_MESSAGES/" "/usr/local/share/locale/zh_CN/" "/usr/local/share/locale/zh_CN/LC_MESSAGES/" "/usr/local/share/locale/vi/" "/usr/local/share/locale/vi/LC_MESSAGES/" "/usr/local/share/locale/uk/" "/usr/local/share/locale/uk/LC_MESSAGES/" "/usr/local/share/locale/tr/" "/usr/local/share/locale/tr/LC_MESSAGES/" "/usr/local/share/locale/sv/" "/usr/local/share/locale/sv/LC_MESSAGES/" "/usr/local/share/locale/sr/" "/usr/local/share/locale/sr/LC_MESSAGES/" "/usr/local/share/locale/sq/" "/usr/local/share/locale/sq/LC_MESSAGES/" "/usr/local/share/locale/sl/" "/usr/local/share/locale/sl/LC_MESSAGES/" "/usr/local/share/locale/sk/" "/usr/local/share/locale/sk/LC_MESSAGES/" "/usr/local/share/locale/ru/" "/usr/local/share/locale/ru/LC_MESSAGES/" "/usr/local/share/locale/ro/" "/usr/local/share/locale/ro/LC_MESSAGES/" "/usr/local/share/locale/pt_BR/" "/usr/local/share/locale/pt_BR/LC_MESSAGES/" "/usr/local/share/locale/pt/" "/usr/local/share/locale/pt/LC_MESSAGES/" "/usr/local/share/locale/pl/" "/usr/local/share/locale/pl/LC_MESSAGES/" "/usr/local/share/locale/nl/" "/usr/local/share/locale/nl/LC_MESSAGES/" "/usr/local/share/locale/nb/" "/usr/local/share/locale/nb/LC_MESSAGES/" "/usr/local/share/locale/ms/" "/usr/local/share/locale/ms/LC_MESSAGES/" "/usr/local/share/locale/ko/" "/usr/local/share/locale/ko/LC_MESSAGES/" "/usr/local/share/locale/ja/" "/usr/local/share/locale/ja/LC_MESSAGES/" "/usr/local/share/locale/it/" "/usr/local/share/locale/it/LC_MESSAGES/" "/usr/local/share/locale/is/" "/usr/local/share/locale/is/LC_MESSAGES/" "/usr/local/share/locale/id/" "/usr/local/share/locale/id/LC_MESSAGES/" "/usr/local/share/locale/hu/" "/usr/local/share/locale/hu/LC_MESSAGES/" "/usr/local/share/locale/hr/" "/usr/local/share/locale/hr/LC_MESSAGES/" "/usr/local/share/locale/gl/" "/usr/local/share/locale/gl/LC_MESSAGES/" "/usr/local/share/locale/ga/" "/usr/local/share/locale/ga/LC_MESSAGES/" "/usr/local/share/locale/fr/" "/usr/local/share/locale/fr/LC_MESSAGES/" "/usr/local/share/locale/fi/" "/usr/local/share/locale/fi/LC_MESSAGES/" "/usr/local/share/locale/eu/" "/usr/local/share/locale/eu/LC_MESSAGES/" "/usr/local/share/locale/es/" "/usr/local/share/locale/es/LC_MESSAGES/" "/usr/local/share/locale/eo/" "/usr/local/share/locale/eo/LC_MESSAGES/" "/usr/local/share/locale/de/" "/usr/local/share/locale/de/LC_MESSAGES/" "/usr/local/share/locale/da/" "/usr/local/share/locale/da/LC_MESSAGES/" "/usr/local/share/locale/cs/" "/usr/local/share/locale/cs/LC_MESSAGES/" "/usr/local/share/locale/ca/" "/usr/local/share/locale/ca/LC_MESSAGES/" "/usr/local/share/locale/bg/" "/usr/local/share/locale/bg/LC_MESSAGES/" "/usr/local/share/man/" "/usr/local/share/man/man5/" "/usr/local/share/man/man1/" "/usr/local/share/info/" "/usr/local/share/doc/" "/usr/local/share/doc/nano/" )

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

echo
echo '	                :::                           The                   '
echo '	  iLE88Dj.  :jD88888Dj:                                             '
echo '	.LGitE888D.f8GjjjL8888E;        .d8888b.  888b    888 888     888   '
echo '	iE   :8888Et.     .G8888.      d88P  Y88b 8888b   888 888     888   '
echo '	;i    E888,        ,8888,      888    888 88888b  888 888     888   '
echo '	      D888,        :8888:      888        888Y88b 888 888     888   '
echo '	      D888,        :8888:      888  88888 888 Y88b888 888     888   '
echo '	      D888,        :8888:      888    888 888  Y88888 888     888   '
echo '	      D888,        :8888:      Y88b  d88P 888   Y8888 Y88b. .d88P   '
echo '	      888W,        :8888:       "Y8888P88 888    Y888  "Y88888P"    '
echo '	      W88W,        :8888:                                           '
echo '	      W88W:        :8888:      88888b.   8888b.  88888b.   .d88b.   '
echo '	      DGGD:        :8888:      888 "88b     "88b 888 "88b d88""88b  '
echo '	                   :8888:      888  888 .d888888 888  888 888  888  '
echo '	                   :W888:      888  888 888  888 888  888 Y88..88P  '
echo '	                   :8888:      888  888 "Y888888 888  888  "Y88P"   '
echo '	                    E888i                                           '
echo '	                    tW88D        				    '
echo
echo '       <====================================================================>'
echo
echo "searching for previous packages installed"
echo

	cd $workSpace
	wget https://www.nano-editor.org/dist/v6/nano-6.4.tar.xz
	tar -xvf nano-6.4.tar.xz
	rm nano-6.4.tar.xz
	cd nano-6.4
	./configure
	make -j $CORES --silent
	sudo make install
	cd ..
	rm -f -r nano-6.4
	touch $HOME/.nanorc
	echo include "/usr/local/share/nano/*.nanorc" >> $HOME/.nanorc
echo
echo '============================================================='
echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '============================================================='
echo
echo 'nano was installed succesfully!'
echo

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


