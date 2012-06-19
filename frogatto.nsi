# define name of installer
outFile "setup.exe"

# define installation directory
installDir $PROGRAMFILES\Frogatto

# start default section
section
 
    # set the installation directory as the destination for the following actions
    setOutPath $INSTDIR
 
	# bin and config files
	File /r frogatto_msvc_bin\*
	
	# game data folders (possibly copied to $INSTDIR?)
	#File frogatto_msvc_bin\data\*
	#File frogatto_msvc_bin\images\*
 
    # create the uninstaller
    writeUninstaller "$INSTDIR\uninstall.exe"
 
    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    createShortCut "$SMPROGRAMS\new shortcut.lnk" "$INSTDIR\uninstall.exe"
sectionEnd

# uninstaller section start
section "uninstall"
 
    # first, delete the uninstaller
    delete "$INSTDIR\uninstall.exe"
 
    # second, remove the link from the start menu
    delete "$SMPROGRAMS\new shortcut.lnk"
	
	# now remove actual file(s)
	# does NOT preserve saved games
	delete "$INSTDIR\*"
 
# uninstaller section end
sectionEnd