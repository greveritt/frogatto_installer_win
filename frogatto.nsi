!define APPNAME "Frogatto & Friends"

# define name of installer
OutFile "setup.exe"

# sets elevation to have proper location of shortcuts
RequestExecutionLevel admin

# define installation directory as a folder within AppData
# This is DANGEROUS and creates risk of virus infection, but I can't avoid this without a) modifying the game's source or b) making this incompatible with XP and lower
InstallDir $APPDATA\FrogattoApp

# start default section
Section
 
    # set the installation directory as the destination for the following actions
    SetOutPath $INSTDIR
 
	# bin and config files
	File /r frogatto_msvc_bin\*
 
    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
 
    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
	CreateDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Uninstall ${APPNAME}.lnk" "$INSTDIR\uninstall.exe"
	CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\frogatto.exe"
	CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME} (fullscreen).lnk" "$INSTDIR\frogatto_fullscreen.bat"
SectionEnd

# uninstaller section start
Section "uninstall"
 
    # first, delete the uninstaller
    Delete "$INSTDIR\uninstall.exe"
 
    # second, remove the links from the start menu
    Delete "$SMPROGRAMS\${APPNAME}\Uninstall ${APPNAME}.lnk"
	Delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
	Delete "$SMPROGRAMS\${APPNAME}\${APPNAME} (fullscreen).lnk"
	RMDir "$SMPROGRAMS\${APPNAME}\"
	
	# back up saves and preferences
	Rename "$INSTDIR\save.cfg" "$TEMP\frogatto_save.cfg"
	Rename "$INSTDIR\preferences.cfg" "$TEMP\frogatto_preferences.cfg"
	
	# now remove actual file(s) and file folders
	Delete "$INSTDIR\*"
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
SectionEnd