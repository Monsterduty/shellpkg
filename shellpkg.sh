clear

lgreen='\033[;32m'
nc='\033[0m'

    echo -e "${lgreen}"
    echo "=====================>"
    echo " shellpkg"
    echo " version: Beta 0.1"
    echo " usage: shellpkg <flags> <package>"
    echo "==========================================>"
    echo -e "${nc}"

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

}

if [ $1 == "-h" ] || [ $1 == 'help' ];
  then
  help
    exit
fi

if [ $1 == "-i" ] || [ $1 == 'install' ];
  then

  case $2 in
  	i3WM-gaps) echo 'i3WM-gaps FOUND'; echo ;;
  	*) echo 'this pachages does not exist in our data base!'; echo;;
  	esac
  exit
fi

