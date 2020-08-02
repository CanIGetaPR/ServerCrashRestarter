# ServerCrashRestarter
Originally used to restart downed eo servers trapped by windows error reporting (WerFault.exe) on Windows Vista through Windows 8.1. (Not tested on Windows 10.)

**This script will restart any program for you if it closes or crashes, and keep a log of restart occurrences with the time they took place.**

This script was created in 2014 or earlier for a server called Journey of Heroes, ah those were the days!

The script now supports any program/server you need by editing line 13:

set server=MyProgramName.ext

To use this script, 

1. Place it in the same folder as your server program. 
2. Change the line mentioned above to the name of the program.

If you are unsure how to edit the line in step 2, this commit shows the line being changed from one program name to another.
https://github.com/CanIGetaPR/ServerCrashRestarter/commit/6c05651238751c82bdf3d7cee7be1194e695cfbb
