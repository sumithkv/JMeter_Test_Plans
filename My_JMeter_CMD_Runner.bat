@ECHO OFF

@REM Get DateTime to generate reports and log files 
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%%DTS:~4,2%%DTS:~6,2%-%DTS:~8,2%%DTS:~10,2%%DTS:~12,2%
echo %DateTime%

@REM Running the JMeter test
call %JMETER_HOME%\bin\jmeter.bat -n -t "%JMETER_HOME%\JMeter_Test_Plans\REST API Test Plan.jmx" -JThreadUsers=10 -JLoopCount=20 -l %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl -j %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Log_%DateTime%.log


@REM Different Types of JMeter Reports
java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-csv %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_AggregateReport_%DateTime%.csv --input-jtl %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl --plugin-type AggregateReport

java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-csv %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_SynthesisReport_%DateTime%.csv --input-jtl %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl --plugin-type SynthesisReport

java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-csv %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_TransactionsPerSecond_%DateTime%.csv --input-jtl %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl --plugin-type TransactionsPerSecond

java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-png %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_ResponseTimesOverTime_%DateTime%.png --input-jtl %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl --plugin-type ResponseTimesOverTime

java -jar %JMETER_HOME%\lib\cmdrunner-2.0.jar  --tool Reporter --generate-png %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_ResponseCodesPerSecond_%DateTime%.png --input-jtl %JMETER_HOME%\JMeter_Test_Plans\CMD_Output\Test_Output_%DateTime%.jtl --plugin-type ResponseCodesPerSecond

echo %time%

