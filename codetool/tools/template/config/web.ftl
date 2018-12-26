<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
	<display-name>gzahi</display-name>
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:spring.xml,classpath:spring-mybatis.xml,classpath:spring-cxf.xml</param-value>
	</context-param>
	<!-- 登录验证(dengwm) -->
	<!-- <filter>  
    	<filter-name>LoginChkFilter</filter-name>  
    	<filter-class>com.jiesai.gzahi.core.filter.LoginChkFilter</filter-class> 
	</filter> -->
	
	<!-- shiro的filter -->
	<!-- shiro过虑器，DelegatingFilterProxy通过代理模式将spring容器中的bean和filter关联起来 -->
	<filter>
		<filter-name>shiroFilter</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
		<!-- 设置true由servlet容器控制filter的生命周期 -->
		<init-param>
			<param-name>targetFilterLifecycle</param-name>
			<param-value>true</param-value>
		</init-param>
		<!-- 设置spring容器filter的bean id，如果不设置则找与filter-name一致的bean-->
		<init-param>
			<param-name>targetBeanName</param-name>
			<param-value>shiroFilter</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>shiroFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	
	<filter>
		<description>字符集过滤器</description>
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<description>字符集编码</description>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<!-- <filter-mapping>  
    	<filter-name>LoginChkFilter</filter-name>  
    	<url-pattern>/*</url-pattern>  
	</filter-mapping> -->
	<listener>
		<description>spring监听器</description>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<!-- 防止spring内存溢出监听器 -->
	<listener>
		<listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>
	</listener>
	<listener>   
		<listener-class ><!-- 临时文件收集器 , 支持超大附件必须项 -->   
			org.apache.commons.fileupload.servlet.FileCleanerCleanup   
		</listener-class >   
	</listener>  
	<context-param>   
		<param-name>tempXlsPath</param-name><!-- 要上传的目录 -->   
		<param-value>WEB-INF/uploadFiles/</param-value>   
	</context-param> 
	
	<!-- spring mvc servlet -->
	<servlet>
		<description>spring mvc servlet</description>
		<servlet-name>springMvc</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<description>spring mvc 配置文件</description>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:spring-mvc.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>springMvc</servlet-name>
		<url-pattern>*.do</url-pattern>
	</servlet-mapping>
	
	<!--  servlet 配置配置 -->
   	<servlet>
		<servlet-name>CXFServlet</servlet-name>
		<servlet-class>org.apache.cxf.transport.servlet.CXFServlet</servlet-class>
		<load-on-startup>1</load-on-startup>
	</servlet>
	
	<servlet-mapping>
		<servlet-name>CXFServlet</servlet-name>
		<url-pattern>/cxf/*</url-pattern>
	</servlet-mapping>

	<!-- 配置session超时时间，单位分钟 -->
	<session-config>
		<session-timeout>15</session-timeout>
	</session-config>
	
	<!--统一出错页面-->
	<error-page>
		<error-code>403</error-code>
		<location>/common/403error.jsp</location>
	</error-page>

	<error-page>
		<error-code>500</error-code>
		<location>/common/500error.jsp</location>
	</error-page>
	<error-page>
		<exception-type>java.lang.Exception</exception-type>
		<location>/common/500error.jsp</location>
	</error-page>
	<error-page>
		<error-code>404</error-code>
		<location>/common/404error.jsp</location>
	</error-page>
	<error-page>
		<exception-type>java.lang.Throwable</exception-type>
		<location>/common/500error.jsp</location>
	</error-page>
	
	<welcome-file-list>
		<welcome-file>/index.jsp</welcome-file>
	</welcome-file-list>
</web-app>