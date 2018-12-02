@ECHO OFF
@REM Get DateTime, to generate log file ending with date-time 
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%%DTS:~4,2%%DTS:~6,2%-%DTS:~8,2%%DTS:~10,2%%DTS:~12,2%

echo %DateTime%

@REM Calling jmeter batch script and passing arguments  
@REM -n -- Flag for non GUI mode.
@REM -t -- path of eboss jmeter script. 
@REM -l -- output file
@REM -j -- log file

call C:\apache-jmeter-3.0\bin\jmeter.bat -n -t eBOSS_PERF_JMETER_TEST_SCRIPT.jmx -l eBOSS_TEST_PLAN_REPORT_%DateTime%.csv -j eBOSS_TEST_PLAN_LOG_%DateTime%.log

java -jar C:\apache-jmeter-3.0\lib\ext\CMDRunner.jar  --tool Reporter --generate-csv eBOSS_Aggregate_REPORT_%DateTime%.csv --input-jtl eBOSS_TEST_PLAN_REPORT_%DateTime%.csv --plugin-type AggregateReport


echo %time%