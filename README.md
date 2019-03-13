# ServerCrashRestarter
Originally used to restart downed EoSource servers trapped by windows error reporting (WerFault.exe) on windows vista+

**This script will restart any program for you if it closes or crashes, and keep a log of restart occurrences with the time they took place.**

This script was created in 2014 or earlier for a server called Journey of Heroes, ah those were the days!

The script now supports any program/server you need by editing the line

set server=eoserv.exe

To use this script, 

1. Place it in the same folder as your server program. 
2. Change the line mentioned above to the name of the program.

In most cases 2. won't be required if you're using this for eoserv.


If you are still unsure which line to edit, this commit shows the line being changed from EOSOURCE.exe to eoserv.exe 
https://github.com/CanIGetaPR/ServerCrashRestarter/commit/6c05651238751c82bdf3d7cee7be1194e695cfbb