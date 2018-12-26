<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:mvc="http://www.springframework.org/schema/mvc" 
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:p="http://www.springframework.org/schema/p" 
	xmlns:context="http://www.springframework.org/schema/context" xsi:schemaLocation="http://www.springframework.org/schema/beans 
	http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
	http://www.springframework.org/schema/context 
	http://www.springframework.org/schema/context/spring-context-3.0.xsd 
	http://www.springframework.org/schema/aop 
	http://www.springframework.org/schema/aop/spring-aop-3.0.xsd
	http://www.springframework.org/schema/mvc 
	http://www.springframework.org/schema/mvc/spring-mvc-3.0.xsd">

	<!-- 自动扫描controller包下的所有类，使其认为spring mvc的控制器 -->
	<context:component-scan base-package="com.jiesai.gzahi.controller" />
	<aop:config proxy-target-class="true"></aop:config>
	<bean class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor">
		<property name="securityManager" ref="securityManager" />
	</bean>
	
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">   
		<property name="messageConverters">   
			<list>
				<bean class="org.springframework.http.converter.ByteArrayHttpMessageConverter"/> 
				<ref bean="mappingJacksonHttpMessageConverter" />   
			</list>   
		</property>   
	</bean> 
	<bean id="mappingJacksonHttpMessageConverter"  
		class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">   
		<property name = "supportedMediaTypes">    
				<list>
					<bean class="org.springframework.http.MediaType">   
					<constructor-arg index="0" value="text"/>   
					<constructor-arg index="1" value="plain"/>   
					<constructor-arg index="2" value="UTF-8"/>   
					</bean>   
					<bean class="org.springframework.http.MediaType">   
					<constructor-arg index="0" value="*"/>   
					<constructor-arg index="1" value="*"/>   
					<constructor-arg index="2" value="UTF-8"/>   
					</bean>   
 					<bean class="org.springframework.http.MediaType">  
					<constructor-arg index="0" value="application" />  
					<constructor-arg index="1" value="json" />  
					<constructor-arg index="2" value="UTF-8" />  
					</bean>  
					<bean class="org.springframework.http.MediaType">  
					<constructor-arg index="0" value="text" />  
					<constructor-arg index="1" value="*" />  
					<constructor-arg index="2" value="UTF-8" />  
					</bean>  
				</list>
		</property>   
	</bean>
	<!-- 避免IE执行AJAX时,返回JSON出现下载文件
	<bean id="mappingJacksonHttpMessageConverter" class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">
		<property name="supportedMediaTypes">
			<list>
				<value>text/html;charset=UTF-8</value>
			</list>
		</property>
	</bean>
 	 -->
	<!-- 启动Spring MVC的注解功能，完成请求和注解POJO的映射 -->
	<bean class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">
		<property name="messageConverters">
			<list>
				<ref bean="mappingJacksonHttpMessageConverter" /><!-- json转换器 -->
			</list>
		</property>
	</bean>

	<!-- 对模型视图名称的解析，即在模型视图名称添加前后缀 -->
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" p:prefix="/" p:suffix=".jsp" />

	<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<property name="defaultEncoding">
			<value>UTF-8</value>
		</property>
		<!-- 指定所上传文件的总大小不能超过501M。注意maxUploadSize属性的限制不是针对单个文件，而是所有文件的容量之和 -->  		
		<property name="maxUploadSize">
			<value>525336576</value><!-- 上传文件大小限制为501M，1025*1024*1024 -->
		</property>
 		<property name="maxInMemorySize">
			<value>4096</value>
		</property>
	</bean>
	
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter"
		p:ignoreDefaultModelOnRedirect="true">
		<property name="messageConverters">
			<list>
				<bean
					class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter"
					p:supportedMediaTypes="*/*" />
			</list>
		</property>
	</bean>
    <bean class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">
		<property name="exceptionMappings">
			<props>
			    <prop key="org.apache.shiro.authz.UnauthorizedException">/common/403error</prop>
				<!-- <prop key="org.springframework.web.bind.MissingServletRequestParameterException">/error/requiredParameter</prop>
 				<prop key="org.springframework.web.bind.ServletRequestBindingException">/error/bindException</prop>
				<prop key="org.springframework.dao.DataIntegrityViolationException">/error/integrityViolation</prop>	 -->	
				<prop key="NoSuchRequestHandlingMethodException">/common/404error</prop>		
				<prop key="java.lang.Throwable">/common/500error</prop>
			</props>
		</property>
		<!-- 设置日志输出级别，不定义则默认不输出警告等错误日志信息 -->
		<property name="warnLogCategory" value="WARN" />
		<property name="defaultErrorView" value="common/500error" />      
     
        <!-- 默认HTTP状态码 -->    
        <property name="defaultStatusCode" value="500" />
    </bean>
    
	<!--对客户端来的URL进行拦截 -->
    <mvc:interceptors>
        <mvc:interceptor>
            <mvc:mapping path="/**ClientController/**"/>
            <bean class="com.jiesai.gzahi.core.interceptor.ClientAuthenticationInterceptor">
                <property name="excludeUrls">
                    <list>
                        <value>/sysUserClientController/login.do</value>   <!-- 登录的地址 -->
                        <value>/sysUserClientController/loginOut.do</value>	  <!-- 登出 的地址，清空cookie-->
                        <value>/sysUserClientController/grantFailed.do</value>   <!-- 未授权的地址 -->
                    </list>
                </property>
            </bean>
        </mvc:interceptor>
    </mvc:interceptors>
    
</beans>