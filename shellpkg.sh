clear
systemArch=$(arch)
lgreen='\033[;32m'
nc='\033[0m'

    echo -e "${lgreen}"
    echo "=====================>"
    echo " shellpkg"
    echo " version: Beta 0.1"
    echo " usage: shellpkg <flags> <package>"
    echo "==========================================>"
    echo -e "${nc}"
    
    
    
	editor(){
		read -p 'shellpkg will use: ' file
		
	save=$file
		
		read -p "are you sure to use $file ?? [yes/no]: " confirm
		
		if [[ $confirm == [Yy]*  ]];
		then
			touch $HOME/.config/shellpkg/editor.txt
			echo $file >> $HOME/.config/shellpkg/editor.txt
		else
		editor
		fi
	}

if [ -f $HOME/.config/shellpkg/develFlag ]; then
	echo	
else
#mkdir $HOME/.config/shellpkg/tmp
	echo "starting initial config.."
	echo
while true; do
    read -p "Do you wish install porteus develop package first? [yes/no] " yn
    case $yn in
        [Yy]* )
		echo;
		if [ $systemArch == "x86_64" ]; then

	        	wget http://ftp.vim.org/ftp/os/Linux/distr/porteus/x86_64/Porteus-v5.0/kernel/05-devel.xzm;
        		unsquashfs 05-devel.xzm;
        		echo;
        		echo "please isert your pasword for continue with the instalations of the packages";
        		echo;
        		sudo cp -r squashfs-root/* / ;
        		echo;
        		mkdir $HOME/.config/shellpkg
				touch $HOME/.config/shellpkg/develFlag
        		rm -f -r 05-devel.xzm squashfs-root/;
        		echo "porteus development packages was successfully installed!";
			echo;
		fi

		if [ $systemArch == "i686" ] || [ $systemArch == "i586" ]; then

	        	wget http://ftp.vim.org/ftp/os/Linux/distr/porteus/i586/Porteus-v5.0/kernel/05-devel.xzm;
        		unsquashfs 05-devel.xzm;
        		echo;
        		echo "please isert your pasword for continue with the instalations of the packages";
        		echo;
        		sudo cp -r squashfs-root/* / ;
        		echo;
        		mkdir $HOME/.config/shellpkg
				touch $HOME/.config/shellpkg/develFlag
        		rm -f -r 05-devel.xzm squashfs-root/;
        		echo "porteus development packages was successfully installed!";
			echo;
		fi
		mkdir $HOME/.config/shellpkg/tmp
		break;;
        [Nn]* ) 
		break;;
        * )
		echo "Please answer yes or no.";;
    esac
done

fi

if [ -f $HOME/.config/shellpkg/editor.txt ]; then
	echo;
else
echo
echo "which text editor can use shellpkg??"
echo
echo "for example featherpad or nano"
echo

	editor
fi


    if [ $# -eq 0 ]; then
    exit
    fi

    if [ $1 != '-h' ] && [ $1 != 'help' ] && [ $1 != '-i' ] && [ $1 != 'install' ]; then
    echo "the flag [ "$1" ] does not exist"
    echo
    exit
    fi

help(){

echo "FLAGS:"
echo
echo '  -s search  => search and show available packages.'
echo '  -i install => install the folowing packages.'
echo '  -h help    => show this help'
echo
echo 'EXAMPLE:'
echo
echo '	shellpkg install test'
echo

}

if [ $1 == "-h" ] || [ $1 == 'help' ];
  then
  help
    exit
fi

if [ $1 == "-i" ] || [ $1 == 'install' ];
  then

  workSpace=$HOME/.config/shellpkg/tmp

  case $2 in
  
  	i3WM-gaps)
  		echo 'i3WM-gaps FOUND';
		wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/i3WM-gaps.sh;
		chmod u+x i3WM-gaps.sh
		mv i3WM-gaps.sh $workSpace;
		$workSpace/i3WM-gaps.sh;
		sudo rm -r -f $workSpace/i3WM-gaps.sh;
		echo;;
		
	test)
		echo 'downloading packages for testing';
		wget -q https://raw.githubusercontent.com/profsucrose/bash-hello-world/master/hello_world.sh;
		chmod u+x hello_world.sh;
		./hello_world.sh ;;
		
	picom)
		wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/picom.sh;
		chmod u+x picom.sh;
		mv picom.sh $workSpace;
		$workSpace/picom.sh;
		sudo rm -r -f $workspace/picom.sh;
		echo;;
		
	nano)
		wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/nano.sh;
		chmod u+x nano.sh
		mv nano.sh $workSpace;
		$workSpace/nano.sh;
		sudo rm -r -f $workSpace/nano.sh;
		echo;;
		
	libxcb-render-util)
		wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-render-util.sh;
		chmod u+x libxcb-render-util.sh
		mv libxcb-render-util.sh $workSpace;
		$workSpace/libxcb-render-util.sh;
		rm -r -f $workSpace/libxcb-render-util.sh;
		echo;;
	
  	*) 
  		echo 'this packages does not exist in our data base!'; echo;;
  	esac
  exit
fi

