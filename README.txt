This should eventually be a fully functional package of Frogatto 1.2 for Windows. So far, it can install and uninstall the game, but only to a folder within AppData. Yeah, I know.

Not yet implemented:
* Shortcut icons
* Application registration/uninstall entry
* user rights check
* graphics
* name that's less generic than "setup.exe"
* letting users choose install directory
* making directory removal safe (in case user picks a vital directory to store files, like Program Files or System32)
* whatever else I think of!

To get this to work, you must have a folder in the installer directory named "frogatto_msvc_bin" (without the quotes), and that folder must include all the files to be installed. I may include this folder in the repository at some point.