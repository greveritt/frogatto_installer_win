!define APPNAME "Frogatto & Friends"
!define ICONNAME "frogatto.ico"

# define name of installer
OutFile "FrogattoSetup.exe"

# sets elevation to have proper location of shortcuts
RequestExecutionLevel admin

# define installation directory as a folder within AppData
# This is DANGEROUS and creates risk of virus infection, but I can't avoid this without a) modifying the game's source or b) making this incompatible with XP and lower
InstallDir $APPDATA\FrogattoApp

# start default section
Section

    # set the installation directory as the destination for the following actions
    SetOutPath $INSTDIR

    # file to be installed
    File /r frogatto_msvc_bin\*    # bin and config files
    File frogatto.ico    # icon file for shortcuts

    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"

    # Installer registry info
    WriteRegStr HKCU "Software\Frogatto" "" $INSTDIR

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Frogatto" \
    "DisplayName" "Frogatto & Friends for Windows (Unofficial)"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Frogatto" \
    "DisplayVersion" "1.2"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Frogatto" \
    "Publisher" "Gregory R. Everitt"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Frogatto" \
    "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
 
    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    CreateDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Uninstall ${APPNAME}.lnk" "$INSTDIR\uninstall.exe"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\frogatto.exe" "" "$INSTDIR\${ICONNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME} (fullscreen).lnk" "$INSTDIR\frogatto_fullscreen.bat" "" "$INSTDIR\${ICONNAME}"
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
    RMDir /r "$INSTDIR\utils"


    # restore saves and preferences
    Rename "$TEMP\frogatto_save.cfg" "$INSTDIR\save.cfg"
    Rename "$TEMP\frogatto_preferences.cfg" "$INSTDIR\preferences.cfg"

    # delete registry keys
    DeleteRegKey /ifempty HKCU "Software\Frogatto"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Frogatto"
    

# uninstaller section end
SectionEnd