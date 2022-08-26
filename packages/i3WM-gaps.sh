pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp
flag=$1

files=( "config" "ipc.h" "i3-sensible-terminal" "i3-sensible-pager" "i3-sensible-editor" "i3-save-tree" "i3-migrate-config-to-v4" "i3-dmenu-desktop" "i3-nagbar" "i3-msg" "i3-input" "i3-dump-log" "i3-config-wizard" "i3bar" "i3" "layout-saving-1.png" "logo-30.png" "refcard_style.css" "refcard.html" "tree-shot4.png" "tree-shot3.png" "tree-shot2.png" "tree-shot1.png" "tree-layout2.png" "tree-layout1.png" "i3-sync.png" "i3-sync-working.png" "keyboard-layer2.png" "keyboard-layer1.png" "wsbar.png" "modes.png" "two_terminals.png" "two_columns.png" "snapping.png" "single_terminal.png" "bigpicture.png" "i3.desktop" "i3-with-shmlog.desktop" "i3.desktop" "config" "config.keycodes" )

path=( "$HOME/.config/i3/" "/usr/local/include/" "/usr/local/include/i3/" "/usr/local/bin/" "/usr/local/share/" "/usr/local/share/doc/" "/usr/local/share/doc/i3/" "/usr/local/share/applications/" "/usr/local/share/xsessions/" "/usr/local/etc/" "/usr/local/etc/i3/" )

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

customResource(){

	i3-config-wizard
	sed -i 's\status_command i3status\status_command i3blocks\' $HOME/.config/i3/config

echo '
set $mode_gaps Gaps: (o)uter, (i)nner, (h)orizontal, (v)ertical, (t)op, (r)ight, (b)ottom, (l)eft
set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_horiz Horizontal Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_verti Vertical Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_top Top Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_right Right Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_bottom Bottom Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_left Left Gaps: +|-|0 (local), Shift + +|-|0 (global)
bindsym $mod+Shift+g mode "$mode_gaps"

mode "$mode_gaps" {
        bindsym o      mode "$mode_gaps_outer"
        bindsym i      mode "$mode_gaps_inner"
        bindsym h      mode "$mode_gaps_horiz"
        bindsym v      mode "$mode_gaps_verti"
        bindsym t      mode "$mode_gaps_top"
        bindsym r      mode "$mode_gaps_right"
        bindsym b      mode "$mode_gaps_bottom"
        bindsym l      mode "$mode_gaps_left"
        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}

mode "$mode_gaps_outer" {
        bindsym plus  gaps outer current plus 5
        bindsym minus gaps outer current minus 5
        bindsym 0     gaps outer current set 0

        bindsym Shift+plus  gaps outer all plus 5
        bindsym Shift+minus gaps outer all minus 5
        bindsym Shift+0     gaps outer all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_inner" {
        bindsym plus  gaps inner current plus 5
        bindsym minus gaps inner current minus 5
        bindsym 0     gaps inner current set 0

        bindsym Shift+plus  gaps inner all plus 5
        bindsym Shift+minus gaps inner all minus 5
        bindsym Shift+0     gaps inner all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_horiz" {
        bindsym plus  gaps horizontal current plus 5
        bindsym minus gaps horizontal current minus 5
        bindsym 0     gaps horizontal current set 0

        bindsym Shift+plus  gaps horizontal all plus 5
        bindsym Shift+minus gaps horizontal all minus 5
        bindsym Shift+0     gaps horizontal all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_verti" {
        bindsym plus  gaps vertical current plus 5
        bindsym minus gaps vertical current minus 5
        bindsym 0     gaps vertical current set 0

        bindsym Shift+plus  gaps vertical all plus 5
        bindsym Shift+minus gaps vertical all minus 5
        bindsym Shift+0     gaps vertical all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_top" {
        bindsym plus  gaps top current plus 5
        bindsym minus gaps top current minus 5
        bindsym 0     gaps top current set 0

        bindsym Shift+plus  gaps top all plus 5
        bindsym Shift+minus gaps top all minus 5
        bindsym Shift+0     gaps top all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_right" {
        bindsym plus  gaps right current plus 5
        bindsym minus gaps right current minus 5
        bindsym 0     gaps right current set 0

        bindsym Shift+plus  gaps right all plus 5
        bindsym Shift+minus gaps right all minus 5
        bindsym Shift+0     gaps right all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_bottom" {
        bindsym plus  gaps bottom current plus 5
        bindsym minus gaps bottom current minus 5
        bindsym 0     gaps bottom current set 0

        bindsym Shift+plus  gaps bottom all plus 5
        bindsym Shift+minus gaps bottom all minus 5
        bindsym Shift+0     gaps bottom all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"
}
mode "$mode_gaps_left" {
        bindsym plus  gaps left current plus 5
        bindsym minus gaps left current minus 5
        bindsym 0     gaps left current set 0

        bindsym Shift+plus  gaps left all plus 5
        bindsym Shift+minus gaps left all minus 5
        bindsym Shift+0     gaps left all set 0

        bindsym Return mode "$mode_gaps"
        bindsym Escape mode "default"

}

gaps inner 14
gaps outer -2

' >> $HOME/.config/i3/config

touch $HOME/.config/shellpkg/tmp/i3.txt
echo "[Desktop Entry]
Name=I3WM-gaps
Type=Application
Comment=i3WM-gaps
TryExec=i3
Exec=i3" >> $HOME/.config/shellpkg/tmp/i3.txt
sudo mv -f $HOME/.config/shellpkg/tmp/i3.txt /usr/share/xsessions/i3.desktop

}

insdeps(){

	mkdir deps
	cd deps
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libiconv.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/gperf.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-render-util.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-image.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-cursor.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libev.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-wm.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/libxcb-keysyms.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/xcb-util-xrm.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/yajl.sh
	wget https://raw.githubusercontent.com/Monsterduty/shellpkg/main/packages/i3blocks.sh
	chmod u+x *
	./libiconv.sh deps
	./gperf.sh deps
	./libxcb-render-util.sh deps
	./libxcb-image.sh deps
	./libxcb-cursor.sh deps
	./libev.sh deps deps
	./libxcb-wm.sh deps
	./libxcb-keysyms.sh deps
	./xcb-util-xrm.sh deps
	./yajl.sh deps
	./i3blocks.sh deps
	cd ..
	rm -r -f deps

}

inspkg(){

	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig:$PKG_CONFIG_PATH
	cd $workSpace
	insdeps
	git clone --recursive https://github.com/Airblader/i3
	cd i3
	mkdir build
	cd build
	meson ..
	ninja -C .
	sudo ninja -C . install
	cd ../..
	rm -r -f i3
	customResource
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


