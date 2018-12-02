echo off

echo "db2 connect to boss"
db2 connect to boss


SET /a counter=0

:LOOP
IF %counter% GEQ 50 GOTO END
echo This is iteration %counter%.
set /a store_num = %counter%*10+%counter%+1 
echo %store_num%
SET /a counter=%counter%+1


call db2 INSERT INTO SCS.B_USER (STORE_NUM, USER_ID, CHANGE_PASSWORD, ACTIVE, LOGIN_ATTEMPTS, FIRST_NAME, INITIAL, LAST_NAME, PROFILE_ID, TIMESTAMP) VALUES(%store_num%, 'USER_ID%counter%',  1, 1, 0, 'USER_ID%counter%', 'j', 'jmeter', 'profile_admin', CURRENT TIMESTAMP)

call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossShopAssist')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossSecMaint')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossReports')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossQuickLookup')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossAdmin')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossCashTracking')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_ConfigureMTS')
call db2  INSERT INTO SCS.B_USER_ATTRIBUTE_VALUE(STORE_NUM, USER_ID, ATTRIBUTE) VALUES (%store_num%, 'USER_ID%counter%', 'attribute_BossHome')

REM Creating JMETER user for testing
net user USER_ID%counter% Passw0rd /add /FULLNAME:"JMETER TEST USER%counter%" /COMMENT:"JMETER TEST USER"

REM net user USER_ID%counter% /DELETE

GOTO LOOP

:END
echo "db2 connect reset"
db2 connect reset


