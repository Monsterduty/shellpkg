clear
workSpace=$HOME/.config/shellpkg/tmp
systemArch=$(arch)
lgreen='\033[;32m'
nc='\033[0m'
binaries=( "/usr/bin/" "/usr/sbin" "/usr/local/bin" )

    echo -e "${lgreen}"
    echo "=====================>"
    echo " shellpkg"
    echo " version: Beta 0.1"
    echo " usage: shellpkg <flags> <package>"
    echo "==========================================>"
    echo -e "${nc}"

editor(){

	executable="false"
	read -p 'shellpkg will use: ' file

	for a in "${binaries[@]}";
		do

		if [ -f $a$file ]; then executable="true"; fi;

		done

	if [[ $executable == "false" ]];
		then

			echo "this editor does not exist in your system!"
			echo "please chose another"
			echo
			editor

	fi

	read -p "are you sure to use $file ?? [yes/no]: " confirm

	if [[ $confirm == [Yy]*  ]];
		then
			touch $HOME/.config/shellpkg/editor.txt
			echo $file >> $HOME/.config/shellpkg/editor.txt
			return
	fi
	editor
}


insDevTools(){

	read -p "do you wish install the develoment package?? [yes/no]: " a

	if [[ $a != [Yy]* ]]; then exit; fi;

	cd $workSpace
	files=( "https://download944.mediafire.com/7uwoxcf4uwog/my79kkhpy2m8sl5/devel-x86_64.tar.xz" "https://download1501.mediafire.com/t85ertacfaug/0sbsgu0a3kfowjy/devel-i686.tar.xz" )

	for a in "${files[@]}";
		do
			if [[ $(echo $a | grep $systemArch) != '' ]];
				then

				wget $a

			fi
		done

	if [ ! -f devel-$systemArch.tar.xz ]; then echo "download has been failed!"; return; fi;
	mkdir devel
	tar -xvf devel-$systemArch.tar.xz -C devel
	rm devel-$systemArch.tar.xz
	sudo cp -r devel/* /
	rm -r -f devel
	touch $HOME/.config/shellpkg/develFlag
	echo "devel pkg installed succesfully!"
	echo

}

help(){

echo "FLAGS

  -s search  => search the following packages
  -r remove  => remove the following packages
  -i install => install the following packages
  -h help    => show this help

EXAMPLE:

  shellpkg.sh install nano axel
"


}

search(){

        if [[ $1 != '' ]];
                then

        	        wget -q https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packagesList.txt
                	mv packagesList.txt $workSpace
                	cat $workSpace/packagesList.txt | grep $1
                	rm $workSpace/packagesList.txt

        fi

}

inspkg(){

	prefix="https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/"
	pkg=$2.sh
        wget -q $prefix$2.sh
	if [ ! -f $pkg ]; then echo "this packages [ $pkg ]  does not exist in our data base!"; exit;  fi;
	echo $pkg "FOUND"
        chmod u+x $pkg
        mv $pkg $workSpace
	cd $workSpace
        if [ $1 == "remove" ] || [ $1 == '-r' ]
                then
                ./$pkg uninstall
        else
                ./$pkg
        fi
	cd $HOME
        sudo rm -r -f $workSpace/$pkg
        echo

}

checkFlags(){

	aux="false"

	prefix=( "-h" "help" "-i" "install" "-r" "remove" "-s" "search")

	for a in "${prefix[@]}";
		do

			if [[ $1 == $a ]]; then return; fi;

		done

	echo "the flag [ $1 ] don't exist!"
	exit

}

if [ ! -d $HOME/.config/shellpkg ];
	then

	mkdir $HOME/.config/shellpkg
	mkdir $HOME/.config/shellpkg/tmp

fi

if [ ! -f $HOME/.config/shellpkg/develFlag ]; then insDevTools; fi

if [ ! -f $HOME/.config/shellpkg/editor.txt ]; then editor; fi

if [ $# -eq 0 ]; then exit; fi

checkFlags $1

if [ $1 == "-h" ] || [ $1 == 'help' ]; then help; exit; fi

if [[ $2 == '' ]]; then echo "nothing to do"; exit; fi

if [ $1 == "-s" ] || [ $1 == "search" ];
	then

	echo "packages available: "
	echo
		for a in "$@";
			do

				if [ $a != $1 ]; then search $a; fi

			done

	exit

fi

if [ $1 == "-i" ] || [ $1 == 'install' ] || [ $1 == "-r" ] ||  [ $1 == "remove" ];
  then

	for a in "$@";
		do

			if [ $a != $1 ]; then inspkg $1 $a; fi

		done

  exit
fi

