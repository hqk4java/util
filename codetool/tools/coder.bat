@echo off
echo [INFO] ��ȷ���Ƿ�������codeconfig.xml�������ļ�

java -jar %~dp0/code-tools.jar -configfile %~dp0/codeconfig.xml -filetempleate %~dp0/template/

pause