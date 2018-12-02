@ECHO OFF

@REM Get DateTime to generate Reports & Log files
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%%DTS:~4,2%%DTS:~6,2%-%DTS:~8,2%%DTS:~10,2%%DTS:~12,2%
echo %DateTime%

SET /P NoUsers="Please Enter The Number of Users Performing The Test "
echo
echo The Store Manager Test is going to run for %NoUsers% Users...
echo

:StartScript
SET Choice=
SET /P Choice="Please enter 'Y' to Start The Test or 'N' to Quit The Test "
echo
	IF NOT '%Choice%'=='' SET Choice=%Choice:~0,4%
    IF /I '%Choice%'=='Y' GOTO RunTest
	IF /I '%Choice%'=='y' GOTO RunTest
	IF /I '%Choice%'=='N' GOTO QuitTest
	IF /I '%Choice%'=='n' GOTO QuitTest
	ECHO: 
	ECHO: Invalid Input...  Please Try Again...
	ECHO:
	GOTO StartScript

:RunTest
@REM Running the JMeter test
echo Starting The JMeter Test...
call %JMETER_HOME%\bin\jmeter.bat -n -t "%JMETER_HOME%\JMeter_Test_Plans\JMeter_eBOSS_StoreManager\eBOSS_StoreManager_TestPlan.jmx" -JJMeter_Home=%JMETER_HOME% -JTestUsers=%NoUsers% -l %JMETER_HOME%\JMeter_Test_Plans\JMeter_StoreManager_Test_Output_%DateTime%.jtl -j %JMETER_HOME%\JMeter_Test_Plans\JMeter_StoreManager_Test_Log_%DateTime%.log

@REM Generating JMeter Reports
echo Generating The JMeter Test Reports... Please Wait... ... ...
java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-csv %JMETER_HOME%\JMeter_Test_Plans\BOSS_StoreManager_AggregateReport_%DateTime%.csv --input-jtl %JMETER_HOME%\JMeter_Test_Plans\JMeter_StoreManager_Test_Output_%DateTime%.jtl --plugin-type AggregateReport

:QuitTest
echo Bye...
exit