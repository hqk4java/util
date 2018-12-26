<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="
http://www.springframework.org/schema/beans 
http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
http://www.springframework.org/schema/tx 
http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
http://www.springframework.org/schema/aop 
http://www.springframework.org/schema/aop/spring-aop-3.0.xsd
">
	<!-- 配置数据源 (阿里巴巴druid) -->
	<bean id="dbProperties" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
		<property name="location" value="classpath:config.properties" />
		<!-- Allow other PropertyPlaceholderConfigurer to run as well -->
		<property name="ignoreUnresolvablePlaceholders" value="true" />
	</bean>
	<!-- 数据库类型 -->
	<bean id="dbType" class="java.lang.String" > 
	   <constructor-arg index="0" value="${r'${dbType}'}"/>
	</bean>
	<!-- jdbc template连接 -->
	<bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
		<property name="dataSource" ref="dataSource" />
	</bean>
	<bean name="dataSource" class="com.alibaba.druid.pool.DruidDataSource"
		init-method="init" destroy-method="close">
		<property name="url" value="${r'${jdbc_url}'}" />
		<property name="username" value="${r'${jdbc_username}'}" />
		<property name="password" value="${r'${jdbc_password}'}" />

		<!-- 初始化连接大小 -->
		<property name="initialSize" value="0" />
		<!-- 连接池最大使用连接数量 -->
		<property name="maxActive" value="20" />

		<!-- 连接池最大空闲 -->
		<!-- 此参数已经作废 <property name="maxIdle" value="20" /> -->
		<!-- 连接池最小空闲 -->
		<property name="minIdle" value="0" />
		<!-- 获取连接最大等待时间 -->
		<property name="maxWait" value="60000" />

		<!-- <property name="poolPreparedStatements" value="true" /> <property 
			name="maxPoolPreparedStatementPerConnectionSize" value="33" /> -->

		<property name="validationQuery" value="${r'${validationQuery}'}" />
		<property name="testOnBorrow" value="false" />
		<property name="testOnReturn" value="false" />
		<property name="testWhileIdle" value="true" />

		<!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
		<property name="timeBetweenEvictionRunsMillis" value="60000" />
		<!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
		<property name="minEvictableIdleTimeMillis" value="25200000" />

		<!-- 打开removeAbandoned功能 -->
		<property name="removeAbandoned" value="true" />
		<!-- 1800秒，也就是30分钟 -->
		<property name="removeAbandonedTimeout" value="1800" />
		<!-- 关闭abanded连接时输出错误日志 -->
		<property name="logAbandoned" value="true" />

		<!-- 监控数据库 -->
		<!-- <property name="filters" value="stat" /> -->
		<property name="filters" value="mergeStat" />
	</bean>

	<!-- myBatis文件 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<!-- 自动扫描entity目录, 省掉Configuration.xml里的手工配置 -->
		<property name="configLocation" value="classpath:configuration.xml" />
		<property name="mapperLocations" value="classpath:com/jiesai/gzahi/mapping/*/*.xml" />
	</bean>

	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="com.jiesai.gzahi.dao.mybatis" />
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory" />
	</bean>

	<!-- 配置事务管理器 -->
	<bean id="transactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>

	<!-- 注解方式配置事物 -->
	<!-- <tx:annotation-driven transaction-manager="transactionManager" /> -->

	<!-- 拦截器方式配置事物 -->
	<tx:advice id="transactionAdvice" transaction-manager="transactionManager">
		<tx:attributes>
			<tx:method name="add*" propagation="REQUIRED" />
			<tx:method name="append*" propagation="REQUIRED" />
			<tx:method name="insert*" propagation="REQUIRED" />
			<tx:method name="save*" propagation="REQUIRED" />
			<tx:method name="update*" propagation="REQUIRED" />
			<tx:method name="modify*" propagation="REQUIRED" />
			<tx:method name="edit*" propagation="REQUIRED" />
			<tx:method name="delete*" propagation="REQUIRED" />
			<tx:method name="remove*" propagation="REQUIRED" />
			<tx:method name="repair" propagation="REQUIRED" />
			<tx:method name="delAndRepair" propagation="REQUIRED" />
			<tx:method name="get*" propagation="SUPPORTS" />
			<tx:method name="find*" propagation="SUPPORTS" />
			<tx:method name="load*" propagation="SUPPORTS" />
			<tx:method name="search*" propagation="SUPPORTS" />
			<tx:method name="datagrid*" propagation="SUPPORTS" />
			<tx:method name="*" propagation="SUPPORTS" />
		</tx:attributes>
	</tx:advice>
	<aop:config>
		<aop:pointcut id="transactionPointcut"
			expression="execution(* com.jiesai.gzahi.service..*Impl.*(..))" />
		<aop:advisor pointcut-ref="transactionPointcut"
			advice-ref="transactionAdvice" />
	</aop:config>
	<!-- 配置druid监控spring jdbc -->
	<bean id="druid-stat-interceptor"
		class="com.alibaba.druid.support.spring.stat.DruidStatInterceptor">
	</bean>
	<bean id="druid-stat-pointcut" class="org.springframework.aop.support.JdkRegexpMethodPointcut"
		scope="prototype">
		<property name="patterns">
			<list>
				<value>com.jiesai.gzahi.service.*</value>
			</list>
		</property>
	</bean>
	<aop:config>
		<aop:advisor advice-ref="druid-stat-interceptor"
			pointcut-ref="druid-stat-pointcut" />
	</aop:config>

	<bean id="logInterceptor" class="com.jiesai.gzahi.core.interceptor.LogInterceptor"></bean>
	<!-- <aop:aspectj-autoproxy proxy-target-class="true" /> -->
	<aop:config>
		<!-- <aop:pointcut expression="execution(* com.jiesai.gzahi.controller..*.*(..))" id="myPointcut" /> -->
		<aop:pointcut expression="@annotation(com.jiesai.gzahi.core.interceptor.AspectLog)" id="myPointcut"/> <!-- 配了注解的就拦截 -->
		<aop:aspect ref="logInterceptor">
			<aop:around pointcut-ref="myPointcut" method="around" />
		</aop:aspect>
	</aop:config>
</beans>