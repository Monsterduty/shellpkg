pkgName=$( echo $0 | sed 's\./\\' | sed 's\.sh\\' )
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
workSpace=$HOME/.config/shellpkg/tmp

files=( "sdl2-config-version.cmake" "sdl2-config.cmake" "sdl2.pc" "libSDL2_test.a" "libSDL2_test.la" "libSDL2main.a" "libSDL2main.la" "libSDL2.a" "libSDL2-2.0.so.0.2500.0" "libSDL2.la" "SDL_revision.h" "SDL_config.h" "SDL_test_random.h" "SDL_test_memory.h" "SDL_test_md5.h" "SDL_test_log.h" "SDL_test_images.h" "SDL_test_harness.h" "SDL_test_fuzzer.h" "SDL_test_font.h" "SDL_test_crc32.h" "SDL_test_compare.h" "SDL_test_common.h" "SDL_test_assert.h" "SDL_test.h" "close_code.h" "begin_code.h" "SDL_vulkan.h" "SDL_video.h" "SDL_version.h" "SDL_types.h" "SDL_touch.h" "SDL_timer.h" "SDL_thread.h" "SDL_syswm.h" "SDL_system.h" "SDL_surface.h" "SDL_stdinc.h" "SDL_shape.h" "SDL_sensor.h" "SDL_scancode.h" "SDL_rwops.h" "SDL_render.h" "SDL_rect.h" "SDL_quit.h" "SDL_power.h" "SDL_platform.h" "SDL_pixels.h" "SDL_opengles2_khrplatform.h" "SDL_opengles2.h" "SDL_opengles2_gl2platform.h" "SDL_opengles2_gl2.h" "SDL_opengles2_gl2ext.h" "SDL_opengles.h" "SDL_opengl_glext.h" "SDL_opengl.h" "SDL_name.h" "SDL_mutex.h" "SDL_mouse.h" "SDL_misc.h" "SDL_metal.h" "SDL_messagebox.h" "SDL_main.h" "SDL_log.h" "SDL_locale.h" "SDL_loadso.h" "SDL_keycode.h" "SDL_keyboard.h" "SDL_joystick.h" "SDL_hints.h" "SDL_hidapi.h" "SDL_haptic.h" "SDL_guid.h" "SDL_gesture.h" "SDL_gamecontroller.h" "SDL_filesystem.h" "SDL_events.h" "SDL_error.h" "SDL_endian.h" "SDL_egl.h" "SDL_cpuinfo.h" "SDL_clipboard.h" "SDL_blendmode.h" "SDL_bits.h" "SDL_audio.h" "SDL_atomic.h" "SDL_assert.h" "SDL.h" "sdl2-config" "sdl2.m4" )

path=( "/usr/local/lib/" "/usr/local/lib/cmake/" "/usr/local/lib/cmake/SDL2/" "/usr/local/lib/pkgconfig/" "/usr/local/include/" "/usr/local/include/SDL2/" "/usr/local/bin/" "/usr/local/share/" "/usr/local/share/aclocal/" )

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
	
	if [[ $uninstalled == "true" ]];
		then
		
			question "this package is uninstalled"
			exit
		
	fi
	
	if [[ $missing == "true" ]];
		then
		
			question "this package have missing files in your system"
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
	git clone https://github.com/libsdl-org/SDL
	cd SDL
	./configure
	make -j $CORES
	sudo make install
	cd ..
	rm -r -f SDL

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

if [[ $1 == "deps" ]];
	then
	
	inspkg
	exit
	
fi


                                                                                  
echo                                                                         
echo '   SSSSSSSSSSSSSSS DDDDDDDDDDDDD      LLLLLLLLLLL              222222222222222    '
echo ' SS:::::::::::::::SD::::::::::::DDD   L:::::::::L             2:::::::::::::::22  '
echo 'S:::::SSSSSS::::::SD:::::::::::::::DD L:::::::::L             2::::::222222:::::2 '
echo 'S:::::S     SSSSSSSDDD:::::DDDDD:::::DLL:::::::LL             2222222     2:::::2 '
echo 'S:::::S              D:::::D    D:::::D L:::::L                           2:::::2 '
echo 'S:::::S              D:::::D     D:::::DL:::::L                           2:::::2 '
echo ' S::::SSSS           D:::::D     D:::::DL:::::L                        2222::::2  '
echo '  SS::::::SSSSS      D:::::D     D:::::DL:::::L                   22222::::::22   '
echo '    SSS::::::::SS    D:::::D     D:::::DL:::::L                 22::::::::222     '
echo '       SSSSSS::::S   D:::::D     D:::::DL:::::L                2:::::22222        '
echo '            S:::::S  D:::::D     D:::::DL:::::L               2:::::2             '
echo '            S:::::S  D:::::D    D:::::D L:::::L         LLLLLL2:::::2             '
echo 'SSSSSSS     S:::::SDDD:::::DDDDD:::::DLL:::::::LLLLLLLLL:::::L2:::::2       222222'
echo 'S::::::SSSSSS:::::SD:::::::::::::::DD L::::::::::::::::::::::L2::::::2222222:::::2'
echo 'S:::::::::::::::SS D::::::::::::DDD   L::::::::::::::::::::::L2::::::::::::::::::2'
echo ' SSSSSSSSSSSSSSS   DDDDDDDDDDDDD      LLLLLLLLLLLLLLLLLLLLLLLL22222222222222222222'
echo

checkFiles $pkgName


