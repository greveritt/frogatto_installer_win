# define name of installer
outFile "setup.exe"

# define installation directory as a folder within AppData
# This is DANGEROUS and creates risk of virus infection, but I can't avoid this without a) modifying the game's source or b) making this incompatible with XP and lower
installDir $APPDATA\FrogattoApp

# start default section
section
 
    # set the installation directory as the destination for the following actions
    setOutPath $INSTDIR
 
	# The commented code below this was part of an attempt to get the save files to go into My Documents\My Games via symlink. Unfortunately, symlinks are only supported on Vista and up, so for the time being this feature is abandoned.
	## get location of My Documents folder... hopefully
	## ReadRegStr $0 HKCU "Software\Microsoft\Windows\Explorer\User Shell Folders" "Personal"
 
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
	
	# back up saves and preferences
	Rename "$INSTDIR\save.cfg" "$TEMP\frogatto_save.cfg"
	Rename "$INSTDIR\preferences.cfg" "$TEMP\frogatto_preferences.cfg"
	
	# now remove actual file(s) and file folders
	delete "$INSTDIR\*"
	RMDir /r "$INSTDIR\data"
	RMDir /r "$INSTDIR\images"
	RMDir /r "$INSTDIR\locale"
	RMDir /r "$INSTDIR\music"
	RMDir /r "$INSTDIR\music_aac"
	RMDir /r "$INSTDIR\music_aac_mini"
	RMDir /r "$INSTDIR\po"
	RMDir /r "$INSTDIR\sounds"
	RMDir /r "$INSTDIR\sounds_wav"
	RMDir /r "$INSTDIR\stats"
	RMDir /r "$INSTDIR\utils"
	
	
	# restore saves and preferences
	Rename "$TEMP\frogatto_save.cfg" "$INSTDIR\save.cfg" 
	Rename "$TEMP\frogatto_preferences.cfg" "$INSTDIR\preferences.cfg" 
 
# uninstaller section end
sectionEnd