@echo off
:Start
setlocal enabledelayedexpansion
set list= Create Update Delete Exit
set len=0
(for %%a in (%list%) do ( 
   set /a len+=1
))

cls
echo "Which Account?"
set Acc=0
(for %%a in (%list%) do (
set /a Acc+=1
echo !Acc!. %%a
))
set choice=
set /p choice=Enter Your Choice:

if not '%choice%'=='' set choice=%choice:~0,1%
set i=0
(for %%a in (%list%) do ( 
   SET /A i+=1
   set topic[!i!]=%%a
))
for /l %%n in (0,1,%len%) do ( 
   if '%choice%'=='%%n' goto !topic[%%n]!
)

:Exit
cls
exit /b 1

:End
pause
echo|set /p=""|clip
cls
GOTO Start


:Create
cls

echo "Enter Account Name"
set /p AccType=Account Name:

echo "Enter Username For The Account"
set /p Usr=Username:

echo "Enter Password For The Account"
set /p Pass=Password:

echo. >> ACCT.bat
echo :%AccType% >> ACCT.bat
echo cls >> ACCT.bat
SET /P AREYOUSURE=Enable Timer? (Y/[N])?

IF /I "%AREYOUSURE%" EQU "Y" GOTO SETTIMER
IF /I "%AREYOUSURE%" EQU "N" GOTO REGULAR

:SETTIMER

SET /P TIMEEXEC=How Much Delay (in seconds)?:

echo echo "COPIED USERNAME" >> ACCT.bat
echo echo ^| set /p="%Usr%" ^| clip >> ACCT.bat
echo timeout %TIMEEXEC% >> ACCT.bat
echo cls >> ACCT.bat
echo echo "COPIED PASSWORD" >> ACCT.bat
echo echo ^| set /p="%Pass%" ^| clip >> ACCT.bat
echo GOTO END >> ACCT.bat

"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "((Get-Content -path ACCT.bat -Raw) -replace ' Create Update Delete Exit',' %ACCTYPE% Create Update Delete Exit') | Set-Content -Path ACCT.bat"

GOTO End

:REGULAR

echo echo "COPIED USERNAME" >> ACCT.bat
echo echo ^| set /p="%Usr%" ^| clip >> ACCT.bat
echo pause >> ACCT.bat
echo cls >> ACCT.bat
echo echo "COPIED PASSWORD" >> ACCT.bat
echo echo ^| set /p="%Pass%" ^| clip >> ACCT.bat
echo GOTO END >> ACCT.bat

"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "((Get-Content -path ACCT.bat -Raw) -replace ' Create Update Delete Exit',' %ACCTYPE% Create Update Delete Exit') | Set-Content -Path ACCT.bat"

GOTO End


:Update

cls

echo "Enter Account Name You Want To Edit"
set /p ACCUPD=Account Name:
echo.
echo "Enter New Username"
set /p Usr=Username:
echo "Enter New Password"
set /p Pass=Password:

echo :%ACCUPD% >> ACCT.bat
echo cls >> ACCT.bat

cscript.exe rp1.vbs ACCT.bat ":%ACCUPD%" "

"
cscript.exe rp2.vbs ACCT.bat ":%ACCUPD%" " 

"
cscript.exe rp3.vbs ACCT.bat "%ACCUPD%" " "
pause

GOTO Confirmation

:Confirmation
cls
SET /P AREYOUSURE=Enable Timer? (Y/[N])?

IF /I "%AREYOUSURE%" EQU "Y" GOTO SETTIMER
IF /I "%AREYOUSURE%" EQU "N" GOTO REGULAR

GOTO End

:Delete

cls

echo "Enter The Name Of The Account (CASE SENSITIVE)"
set /p ACCDEL=Account Name:
echo.
SET /P DELETENOW=Are You Sure? (Y/[N])?

IF /I "%DELETENOW%" EQU "Y" GOTO DeleteAcc
IF /I "%DELETENOW%" EQU "N" GOTO END

:DeleteAcc

cscript.exe rp1.vbs ACCT.bat ":%ACCDEL%" " "
cscript.exe rp2.vbs ACCT.bat ":%ACCDEL%" " "
cscript.exe rp3.vbs ACCT.bat "%ACCDEL%" " "

echo "Account" | %ACCDEL% | "Deleted"

pause

GOTO End


 

 
    

