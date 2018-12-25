@ECHO OFF

@REM Get DateTime to generate reports and log files 
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%%DTS:~4,2%%DTS:~6,2%-%DTS:~8,2%%DTS:~10,2%%DTS:~12,2%
echo %DateTime%

cd %JMETER_HOME%\\JMeter_Test_Plans\\ResponseFiles
mkdir %DateTime%

