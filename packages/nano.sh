clear
binaries=('nano' 'rnano')
ex='.nanorc'
path=('/usr/bin/' '/usr/local/bin/' '/usr/local/share/nano/')
files=('asm' 'autoconf' 'awk' 'c' 'changelog' 'cmake' 'css' 'default' 'elisp' 'email' 'go' 'groff' 'guile' 'html' 'java' 'javascript' 'json' 'lua' 'makefile' 'man' 'markdown' 'nanohelp' 'nanorc' 'nftables' 'objc' 'ocaml' 'patch' 'perl' 'php' 'po' 'python' 'ruby' 'rust' 'sh'  'sql' 'tcl' 'tex' 'texinfo' 'xml' 'yaml')
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
sleep 3


inspkg(){

CORES=$(cat /proc/cpuinfo | grep processor | wc -l)

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

uninspkg(){

	for a in "${files[@]}";
	do
	
		for b in "${path[@]}";
		do
			
			if [ -f $b$a$ex ]; then
			sudo rm -f -r $b$a$ex
			fi
			
		done
	
	done
	
	for c in "${binaries[@]}";
	do
		for d in "${path[@]}";
		do
			
			if [ -f $d$c ]; then
			sudo rm -f -r $d$c
			fi
			
		done
	done
	
	rm -f $HOME/.nanorc $HOME/nanorc.save
}

question(){

while true; do
    read -p "Do you wish reinstall this packages?? [yes/no] " yn
    case $yn in
        [Yy]* )
        	inspkg ; 
        	echo ;
        	break;;
        [Nn]* ) 
        	echo
        	echo 'tanks for using shellpkg :)'
        	echo
        	exit
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

}

veriFiles(){

vf=0
vn=0

for e in "${files[@]}";
do
verified='no'
vn=$((vn+1))

	for d in "${path[@]}"
	do
	if [ -f $d$e$ex ]; then
	echo '[ok]-'$e$ex
	verified='yes'
	vf=$((vf+1))
	fi
	done

if [ $verified == 'no' ]; then
	echo '[no]-'$e$ex
fi

done

if [ $vn == $vf ]; then
	echo
	echo 'this package is allready installed in the system'
	echo
	question
else
	echo
	echo "there is some files of a previous instalations of this packages"
	question
fi

}

if [[ $1 == uninstall ]]; then

echo "type your password for remove your package"
echo
sudo echo 'uninstalling..'
echo
uninspkg
exit
fi

elements=0
verif=0
for e in "${binaries[@]}";
do
verified='no'
elements=$((elements+1))

	for d in "${path[@]}"
	do
	if [ -f $d$e ]; then
	echo '[ok]-'$e
	verified='yes'
	fi
	done

if [ $verified == 'no' ]; then
echo '[no]-'$e
verif=$((verif+1))
fi
done

if [ $verif == $elements ]; then
	echo
	echo 'dont exist previous packages installed'
	echo
	inspkg
else
	echo
	echo 'there is a previous files of this packages'
	echo
	echo 'verifing instalations'
	echo
	sleep 2
	veriFiles
fi
