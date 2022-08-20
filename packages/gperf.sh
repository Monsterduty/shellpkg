files=( "gperf" "gperf.html" "gperf.info" "gperf.1" )

path=( "/usr/local/bin/" "/usr/local/share/doc/" "/usr/local/share/info/" "/usr/local/share/man/man1/" )

CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp

insQuestion(){

	read -p "do you wish install this package?? [yes/no] " a
	
	if [[ $a == [Yy]* ]];
		then
		
		inspkg
	
	else
	
		exit
	
	fi

}

rmpkg(){

	for a in "${files[@]}";
		do
		
			aux="false"
		
			for b in "${path[@]}";
				do
				
					if [ -f $b$a ];
						then
						
						sudo rm -f -r $b$a
						
					fi
				
				done
		
		done
		
		echo
		echo 'gperf uninstalled'
		echo

}

inspkg(){

	wget -nv http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
	if [ -f gperf-3.1.tar.gz ];
		then
		tar -xvf gperf-3.1.tar.gz
		rm gperf-3.1.tar.gz
		mv gperf-3.1 $workSpace
		cd $workSpace/gperf-3.1
		./configure
		make -j $CORES
		sudo make install
		cd $workSpace
		rm -f -r $workSpace/gperf-3.1
		echo
	fi

}

checkFiles(){

	aux="false"
	missing="false"
	installed="false"

	for a in "${files[@]}";
		do
		
			aux="false"
		
			for b in "${path[@]}";
				do
				
					if [ -f $b$a ];
						then

						aux="true"
						installed="true"
						
					fi
				
				done
		
			if [ aux == "false" ];
				then
				
				missing="true"
				
			fi
		
		done

	if [ $installed == "false" ];
		then
		
		echo
		insQuestion
		exit
		
	fi

	if [ $missing == "true" ];
		then
		
		echo
		echo "this package is incomplete"
		echo
		insQuestion
		exit
		
	fi
	
	echo "[ok]-gperf"

}

if [[ $1 == 'uninstall' ]];
	then
	
	rmpkg
	exit
	
fi

	if [[ $1 == 'deps' ]];
		then
		
		inspkg
		exit
		
	fi

checkFiles
