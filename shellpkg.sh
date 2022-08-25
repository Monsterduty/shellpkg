clear
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
		read -p 'shellpkg will use: ' file
		
	save=$file
	executable="false"

		for a in "${binaries[@]}";
			do
			
			if [ -f $a$file ];
				then
				
				executable="true"
				
			fi
			
		done
		
		if [[ $executable == "false" ]];
			then
			
			echo "this editor does not exist in your sistem!"
			echo "please chose another"
			echo
			editor
			
		fi
		
		read -p "are you sure to use $file ?? [yes/no]: " confirm
		
		if [[ $confirm == [Yy]*  ]];
		then
			touch $HOME/.config/shellpkg/editor.txt
			echo $file >> $HOME/.config/shellpkg/editor.txt
		else
		editor
		fi
	}

if [ -f $HOME/.config/shellpkg/develFlag ];
	then
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
        		rm 05-devel.xzm
        		echo;
        		echo "please isert your pasword for continue with the instalations of the packages";
        		echo;
        		sudo cp -r squashfs-root/* / ;
        		echo;
        		mkdir $HOME/.config/shellpkg
				touch $HOME/.config/shellpkg/develFlag
        		rm -f -r squashfs-root/;
        		echo "porteus development packages was successfully installed!";
			echo;
		fi

		if [ $systemArch == "i686" ] || [ $systemArch == "i586" ]; then

	        	wget http://ftp.vim.org/ftp/os/Linux/distr/porteus/i586/Porteus-v5.0/kernel/05-devel.xzm;
        		unsquashfs 05-devel.xzm;
        		rm 05-devel.xzm
        		echo;
        		echo "please isert your pasword for continue with the instalations of the packages";
        		echo;
        		sudo cp -r squashfs-root/* / ;
        		echo;
        		mkdir $HOME/.config/shellpkg
				touch $HOME/.config/shellpkg/develFlag
        		rm -f -r squashfs-root/;
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

if [ -f $HOME/.config/shellpkg/editor.txt ];
	then
	echo;
else
	echo
	echo "which text editor can use shellpkg??"
	echo
	echo "for example featherpad or nano"
	echo

	editor
fi


    if [ $# -eq 0 ]; 
    	then
    	exit
    fi

    if [ $1 != '-h' ] && [ $1 != 'help' ] && [ $1 != '-i' ] && [ $1 != 'install' ] && [ $1 != '-s' ] && [ $1 != 'search' ] && [ $1 != "-r" ] && [ $1 != "remove" ]; then
    echo "the flag [ "$1" ] does not exist"
    echo
    exit
    fi

help(){

echo "FLAGS:"
echo
echo '  -s search  => search and show available packages.'
echo '  -i install => install the following package.'
echo '	-r remove  => uninstall the following package.'
echo '  -h help    => show this help.'
echo
echo 'EXAMPLE:'
echo
echo '	shellpkg install test'
echo

}

 workSpace=$HOME/.config/shellpkg/tmp

if [ $1 == "-h" ] || [ $1 == 'help' ];
  then
  help
    exit
fi

if [ $1 == "-s" ] || [ $1 == "search" ];
	then

	if [[ $2 != '' ]];
		then
	
		wget -q https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packagesList.txt
		mv packagesList.txt $workSpace
		echo
		echo "packages availables:"
		echo
		cat $workSpace/packagesList.txt | grep $2
		rm $workSpace/packagesList.txt
		echo
	
	else
	
		echo "there's no package to search!"
		echo
	
	fi

	exit

fi

if [ $1 == "-i" ] || [ $1 == 'install' ] || [ $1 == "-r" ] ||  [ $1 == "remove" ];
  then

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
		if [ $1 == "remove" ] || [ $1 == '-r' ];
			then
			$workSpace/libxcb-render-util.sh uninstall;
		else
			$workSpace/libxcb-render-util.sh;
		fi;
		rm -r -f $workSpace/libxcb-render-util.sh;
		echo;;
		
		gperf)
			wget -nv https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/gperf.sh;
			chmod u+x gperf.sh;
			mv gperf.sh $workSpace;
			if [ $1 == "remove" ] || [ $1 == '-r' ];
				then
				$workSpace/gperf.sh uninstall;
			else
				$workSpace/gperf.sh;
			fi;
			rm -r -f $workSpace/gperf.sh;
			echo;;

		feh)
			wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/feh.sh;
			chmod u+x feh.sh;
			mv feh.sh $workSpace;
			if [ $1 == "remove" ] || [ $1 == '-r' ];
				then

				$workSpace/feh.sh uninstall;
			else
				$workSpace/feh.sh;
			fi;
			rm -r -f $workSpace/feh.sh;
			echo;;
	
  		*) 
  			echo 'this packages does not exist in our data base!'; echo;;
  	esac
  exit
fi

