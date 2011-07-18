@ECHO off
TITLE SADB's Installation Tool
color 0B

REM ===========================================================================
:USER_CONFIG
CLS
ECHO.
ECHO		 =======================================================
ECHO		 ==    {{{{{{  Sandshroud Database Development 	}}}}}}==
ECHO		 ==    Place: Trunk			      	      ==
ECHO		 ==    Suported game versions: 3.3.5	              ==
ECHO		 ==    http://www.sandshroud.org/forums               ==
ECHO		 =======================================================
ECHO.
ECHO		Enter MySql server details below...
ECHO. 
ECHO.
ECHO.
REM ===========================================================================
SET /p server= Server address: 
ECHO.
SET /p port= Server port: 
ECHO.
SET /p user= Server username: 
ECHO.
SET /p pass= Server user password: 
ECHO.
SET /p world= World database name: 
ECHO.
SET /p chars= Characters database name: 
ECHO.
SET /p logon= Logon database name: 
REM ===========================================================================
REM =
REM =		DO NOT MODIFY THESE SETTINGS!
REM ===========================================================================
SET mysqlpath=Mysql
SET changesets=Changesets
SET backup=Backups
SET world_path=database
SET custom=extras\custom\
REM ===========================================================================

:menu
cls
ECHO.
ECHO		 =======================================================
ECHO		 ==    {{{{{{  Sandshroud Database Development 	}}}}}}==
ECHO		 ==    Place: Trunk			      	      ==
ECHO		 ==    Suported game versions: 3.3.5	              ==
ECHO		 ==    http://www.sandshroud.org/forums               ==
ECHO		 =======================================================
ECHO.
ECHO		Please type the letter for the option:
ECHO.
ECHO		==============================
ECHO		  I = Import SADB database
ECHO		  C = Import changesets
ECHO		  X = Exit
ECHO		==============================
ECHO		 BW = Backup World database
ECHO		 BC = Backup Characters database
ECHO		 BL = Backup Logon database
ECHO		==============================
ECHO.
SET /p Letter= Enter Letter:


IF %Letter%==* GOTO error

REM World Import
IF %Letter%==i GOTO world_import
IF %Letter%==I GOTO world_import

REM QUIT
IF %Letter%==x GOTO quit_window
IF %Letter%==X GOTO quit_window

REM changesets
IF %Letter%==c GOTO changeset_import
IF %Letter%==C GOTO changeset_import

REM world db backup
IF %Letter%==BW GOTO backup_world
IF %Letter%==bW GOTO backup_world
IF %Letter%==bw GOTO backup_world
IF %Letter%==Bw GOTO backup_world

REM world db backup
IF %Letter%==BC GOTO backup_characters
IF %Letter%==Bc GOTO backup_characters
IF %Letter%==bC GOTO backup_characters
IF %Letter%==bc GOTO backup_characters
GOTO error

:world_import
CLS
ECHO [Importing] Started...
ECHO [Importing] SADB database...
%mysqlpath%\mysql -h %server% --user=%user% --password=%pass% --port=%port% %world% < %world_path%\world.sql
ECHO [Importing] Database import was successful
ECHO.
ECHO [Importing] Changesets
for %%C in (%changesets%\*.sql) do (
	ECHO [Importing] %%~nxC
	%mysqlpath%\mysql -h %server% --user=%user% --password=%pass% --port=%port% %world% < "%%~fC"
)
ECHO Changesets import completed!
ECHO.
ECHO You no need to import any changesets now.
GOTO window_quit
ECHO.
PAUSE
GOTO menu

:changeset_import
CLS
ECHO   Please Write down number of changeset (not the number of rev!!!)
ECHO   Or type in "a" to import all changesets
ECHO.
ECHO.
set /p ch=      Number: 
ECHO.
IF %ch%==a GOTO all_changesets
ECHO      Importing...
IF NOT EXIST "%changesets%\changeset_%ch%.sql" GOTO error2
ECHO.
%mysqlpath%\mysql -h %server% --user=%user% --password=%pass% --port=%port% %world% < %changesets%\changeset_%ch%.sql
ECHO.
ECHO      File changeset_%ch%.sql import completed
ECHO.
PAUSE
GOTO menu

:all_changesets
CLS
ECHO.
ECHO [Importing] Changesets
for %%C in (%changesets%\*.sql) do (
	ECHO [Importing] %%~nxC
	%mysqlpath%\mysql -h %server% --user=%user% --password=%pass% --port=%port% %world% < "%%~fC"
)
ECHO Changesets import completed!
ECHO.
PAUSE   
GOTO menu

:backup_world
CLS
ECHO .
ECHO Creating world database backup
%mysqlpath%\mysqldump -h %server% --user=%user% --password=%pass% --port=%port% %world% --max_allowed_packet=1M >%backup%\world_backup.sql
ECHO Done
ECHO Your world database backup was saved in backups folder
ECHO.
PAUSE
GOTO menu

:backup_characters
CLS
ECHO .
ECHO Creating characters database backup
%mysqlpath%\mysqldump -h %server% --user=%user% --password=%pass% --port=%port% %chars% --max_allowed_packet=1M > %backup%\characters_backup.sql
ECHO Done
ECHO Your characters database backup was saved in backups folder
ECHO.
PAUSE
GOTO menu

:backup_logon
CLS
ECHO .
ECHO Creating logon database backup
%mysqlpath%\mysqldump -h %server% --user=%user% --password=%pass% --port=%port% %logon% --max_allowed_packet=1M > %backup%\logon_backup.sql
ECHO Done
ECHO Your world database backup was saved in backups folder
ECHO.
PAUSE
GOTO menu

:error
CLS
ECHO.
ECHO.
ECHO [ERROR] An error has occured, you will be directed back to the
ECHO [ERROR] main menu.
PAUSE
GOTO menu

:error2
CLS
ECHO.
ECHO.
ECHO [ERROR] You entered wrong mysql server informaton, try again
PAUSE
GOTO window_quit

:window_quit
ECHO Goodbye...
PAUSE