<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-3.2.xsd 
		http://www.springframework.org/schema/mvc 
		http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd 
		http://www.springframework.org/schema/context 
		http://www.springframework.org/schema/context/spring-context-3.2.xsd 
		http://www.springframework.org/schema/aop 
		http://www.springframework.org/schema/aop/spring-aop-3.2.xsd 
		http://www.springframework.org/schema/tx 
		http://www.springframework.org/schema/tx/spring-tx-3.2.xsd ">

<!-- Shiro 的Web过滤器 -->
	<bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
		<property name="securityManager" ref="securityManager" />
		<!-- loginUrl认证提交地址，如果没有认证将会请求此地址进行认证，请求此地址将由formAuthenticationFilter进行表单认证 -->
		<property name="loginUrl" value="/login.do" />
		<!-- 认证成功统一跳转的页面，shiro认证成功自动到上一个请求路径 -->
		<property name="successUrl" value="/loadAuthorization/pass.do"/>
		<!-- 通过unauthorizedUrl指定没有权限操作时跳转页面-->
		<property name="unauthorizedUrl" value="/common/403error.jsp" />
		<!-- 自定义filter配置 -->
		<property name="filters">
			<map>
				<!-- 将自定义 的FormAuthenticationFilter注入shiroFilter中-->
				<entry key="authc" value-ref="formAuthenticationFilter" />
			</map>
		</property>
		
		<!-- 过虑器链定义，从上向下顺序执行，一般将/**放在最下边 -->
		<property name="filterChainDefinitions">
			<value>
				<!-- 对静态资源设置匿名访问 -->
				/common/** = anon
				/images/** = anon
				/js/** = anon
				/jslib/** = anon
				/supcan = anon
				/css/** = anon
				/jsp/report/** = anon
				/cxf/** = anon
				/file/** = anon
				<!-- 验证码，可匿名访问 -->
				/loadPasskey.do = anon
				<!-- 注册，可匿名访问 -->
				/quarSupervisionInfoController/toSingUp.do = anon
				/quarSupervisionInfoController/singUp.do = anon
				/quarMetaTypeController/getPlace.do = anon
				/sysAreaController/getProvince.do = anon
				/sysAreaController/getSubArea.do = anon
				/sysDepartmentController/loadTree.do = anon
				/sysDepartmentController/loadCheckTree.do = anon
				/quarSupervisionInfoController/findSupervisionByIdNumber.do = anon
				/quarSupervisionInfoController/isUserRegAccountExisted.do = anon
				/**ClientController/**=anon
				<!-- 退出地址，shiro去清除session-->
				/logout.do = logout
				<!-- 配置记住我或认证通过可以访问的地址 -->
				<!-- /loadAuthorization/pass.do  = user -->
				<!-- /** = authc 所有url都必须认证通过才可以访问-->
				/** = authc
				
			</value>
		</property>
	</bean>

	<!-- securityManager安全管理器 -->
	<bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
			<property name="realm" ref="customRealm" />
			<!-- 注入缓存管理器 -->
			<property name="cacheManager" ref="cacheManager"/> 
			<!-- 注入session管理器 -->
			<property name="sessionManager" ref="sessionManager" />
			<!-- 记住我 -->
			<property name="rememberMeManager" ref="rememberMeManager"/>
		</bean>
	
	<!-- realm -->
	<bean id="customRealm" class="com.jiesai.gzahi.core.shiro.CustomRealm">
		<!-- 将凭证匹配器设置到realm中，realm按照凭证匹配器的要求进行散列 -->
		<property name="credentialsMatcher" ref="credentialsMatcher"/>
	</bean>
	
	<!-- 凭证匹配器 -->
	<bean id="credentialsMatcher"
		class="org.apache.shiro.authc.credential.HashedCredentialsMatcher">
		<property name="hashAlgorithmName" value="md5" />
		<property name="hashIterations" value="1" />
	</bean>
	
	<!-- 缓存管理器 -->
	<bean id="cacheManager" class="org.apache.shiro.cache.ehcache.EhCacheManager">
    	<property name="cacheManagerConfigFile" value="classpath:shiro-ehcache.xml"/>
    </bean>

<!-- 会话管理器 -->
    <bean id="sessionManager" class="org.apache.shiro.web.session.mgt.DefaultWebSessionManager">
        <!-- session的失效时长，单位毫秒 ,30分钟-->
        <property name="globalSessionTimeout" value="1800000"/>
        <!-- 删除失效的session -->
        <property name="deleteInvalidSessions" value="true"/>
    </bean>

<!-- 自定义form认证过虑器 -->
<!-- 基于Form表单的身份验证过滤器，不配置将也会注册此过虑器，表单中的用户账号、密码及loginurl将采用默认值，建议配置 -->
	<bean id="formAuthenticationFilter" 
	class="com.jiesai.gzahi.core.shiro.CustomFormAuthenticationFilter ">
		<!-- 表单中账号的input名称 -->
		<property name="usernameParam" value="loginName" />
		<!-- 表单中密码的input名称 -->
		<property name="passwordParam" value="password" />
		<!-- 记住我input的名称 -->
		<property name="rememberMeParam" value="rememberMe"/>
    </bean>

<!-- rememberMeManager管理器，写cookie，取出cookie生成用户信息 -->
	<bean id="rememberMeManager" class="org.apache.shiro.web.mgt.CookieRememberMeManager">
		<property name="cookie" ref="rememberMeCookie" />
	</bean>
	<!-- 记住我cookie -->
	<bean id="rememberMeCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
		<!-- rememberMe是cookie的名字 -->
		<constructor-arg value="rememberMe" />
		<!-- 记住我cookie生效时间7天，单位秒 -->
		<property name="maxAge" value="604800" />
	</bean>


</beans>