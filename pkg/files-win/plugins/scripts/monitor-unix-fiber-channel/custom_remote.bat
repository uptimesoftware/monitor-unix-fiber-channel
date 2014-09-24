@echo off
set PHPDIR=..\..\..\apache\php
"%PHPDIR%\php.exe" rcs.php -h=%UPTIME_HOSTNAME% -p=%UPTIME_PORT% -s=%UPTIME_PASSWORD% -c=fc_monitor -a=%UPTIME_ARGS%
