<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
PUBLIC "-//ibatis.apache.org//DTD Config 3.0//EN"
"http://ibatis.apache.org/dtd/ibatis-3-config.dtd">
<configuration>
	<settings>
		<setting name="cacheEnabled" value="true"/>
	</settings>
	<plugins>
		<plugin interceptor="com.jiesai.gzahi.core.interceptor.OffsetLimitInterceptor">
		    <property name="mysql" value="com.jiesai.gzahi.dao.base.MySQLDialect"/>
			<!-- <property name="oracle" value="com.jiesai.gzahi.dao.base.OracleDialect"/> -->
			<!-- <property name="mssql" value="com.hotent.core.mybatis.dialect.SQLServer2005Dialect"/>
			<property name="db2" value="com.hotent.core.mybatis.dialect.DB2Dialect"/>
			<property name="h2" value="com.hotent.core.mybatis.dialect.H2Dialect"/>
			<property name="dm" value="com.hotent.core.mybatis.dialect.DmDialect"/> -->
			<property name="pageSqlId" value=".*Page$" />	
		</plugin>
	</plugins>

  
    
</configuration>