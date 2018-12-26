@echo off
echo [INFO] 请确认是否配置了codeconfig.xml的配置文件

java -jar %~dp0/code-tools.jar -configfile %~dp0/codeconfig.xml -filetempleate %~dp0/template/

pause