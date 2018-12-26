#******database config**********

############################################
##           oracle                       ##
############################################

#driverClassName=oracle.jdbc.driver.OracleDriver
#validationQuery=SELECT 1 FROM DUAL
#quartz.jdbcjobstore=org.quartz.impl.jdbcjobstore.StdJDBCDelegate
#jdbc_url=jdbc:oracle:thin:@192.168.22.78:1521:orcl
#jdbc_username=issp
#jdbc_password=issp
#schema=ISSP
#dbType=oracle

############################################
##           mysql                        ##
############################################

#driverClassName=com.mysql.jdbc.Driver
validationQuery=SELECT 1
jdbc_url=jdbc:mysql://localhost:3306/gzahi?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
jdbc_username=root
jdbc_password=root
schema=gzahi
dbType=mysql



