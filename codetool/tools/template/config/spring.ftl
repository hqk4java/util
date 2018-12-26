<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx" xmlns:jpa="http://www.springframework.org/schema/data/jpa"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.1.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.1.xsd
		http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.1.xsd
		http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-3.1.xsd
		http://www.springframework.org/schema/data/jpa http://www.springframework.org/schema/data/jpa/spring-jpa-1.0.xsd">

    <import resource="spring-shiro.xml"/> 
   
    
	<!-- 引入属性文件 -->
	<context:property-placeholder location="classpath:config.properties" />

	<!-- 自动扫描(service) -->
	<context:component-scan base-package="com.jiesai.gzahi.service" />
	<!-- 自动扫描(JDBC DAO) -->
	<context:component-scan base-package="com.jiesai.gzahi.dao.jdbc" />
	
	<util:properties id="APP_PROPERTIES" location="classpath:config.properties"
		local-override="true" />

	<!-- spring上下文,可以获取 上下文的Context -->
	<bean id="appUtil" class="com.jiesai.gzahi.core.util.AppUtil" />

	<!-- 配置activiti注解 -->
	<bean id="processEngineConfiguration" class="org.activiti.spring.SpringProcessEngineConfiguration">
		<property name="dataSource" ref="dataSource" />
		<property name="databaseSchema" value="${r'${schema}'}"/> <!-- 指定数据库名，在同一个实例下有多个数据库时才会自动创建表 -->
		<property name="dbIdentityUsed" value="false" />  <!-- 不使用引擎自带的用户模块 -->
		<property name="transactionManager" ref="transactionManager" />
		<property name="databaseSchemaUpdate" value="true" />
		<property name="jobExecutorActivate" value="false" />
	</bean>
	<bean id="processEngine" class="org.activiti.spring.ProcessEngineFactoryBean">
		<property name="processEngineConfiguration" ref="processEngineConfiguration" />
	</bean>
	<bean id="repositoryService" factory-bean="processEngine" factory-method="getRepositoryService" />
	<bean id="runtimeService" factory-bean="processEngine" factory-method="getRuntimeService" />
	<bean id="taskService" factory-bean="processEngine" factory-method="getTaskService" />
	<bean id="historyService" factory-bean="processEngine" factory-method="getHistoryService" />
	<bean id="managementService" factory-bean="processEngine" factory-method="getManagementService" />
	<bean id="identityService" factory-bean="processEngine" factory-method="getIdentityService" />

	<bean id="statusColor" class="java.util.HashMap">
		<constructor-arg>
			<map key-type="java.lang.Short" value-type="java.lang.String">
				<entry key="1" value="#00FF00"></entry>
				<entry key="0" value="#FFA500"></entry>
				<entry key="-1" value="#FF0000"></entry>
				<entry key="2" value="#0000FF"></entry>
				<entry key="3" value="#8A0902"></entry>
				<entry key="4" value="#023B62"></entry>
				<entry key="17" value="#338848"></entry>
				<entry key="11" value="#82B7D7"></entry>
				<entry key="9" value="#EBEFF0"></entry>
				<entry key="14" value="#EEAF97"></entry>
				<entry key="33" value="#F89800"></entry>
				<entry key="34" value="#FFE76E"></entry>
				<entry key="37" value="#C33A1F"></entry>
			</map>
		</constructor-arg>
	</bean>
    <import resource="spring-redis.xml"/> 
</beans>