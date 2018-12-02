ECHO off
echo creating CVS file to create 50 user 
SET eBOSS_USERS=C:\eBoss-performance\eBOSS_USER.CSV
FOR /L %%G IN (1,1,50) DO echo USER_ID%%G >> %eBOSS_USERS%