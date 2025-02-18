<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:jee="http://www.springframework.org/schema/jee" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="  
            http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd  
            http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

	<context:property-placeholder location="classpath:redis.properties" />
	

    <bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
        <property name="maxActive" value="100" />
        <property name="maxIdle" value="3000" />
        <property name="maxWait" value="1000" />
        <property name="testOnBorrow" value="true"/>
        <property name="testOnReturn" value="true"/>
        <!-- <property name="testWhileIdle" value="true"/> -->
    </bean>

    <bean id="shardedJedisPool" class="redis.clients.jedis.ShardedJedisPool"  scope="singleton">
        <constructor-arg index="0" ref="jedisPoolConfig" />
        <constructor-arg index="1">
            <list>  
                <bean class="redis.clients.jedis.JedisShardInfo">  
                   <constructor-arg index="0" value="127.0.0.1"/>  
                   <constructor-arg index="1" value="6379" type="int"/>  
               </bean>  
           </list>  
        </constructor-arg>
    </bean>
	
    <bean id="redisDataSource" class="com.jiesai.gzahi.core.redis.RedisDataSource">
        <property name="shardedJedisPool" ref="shardedJedisPool"></property>
    </bean>
    
    <bean id="redisClientTemplate" class="com.jiesai.gzahi.core.redis.RedisClientTemplate">
        <property name="redisDataSource" ref="redisDataSource"></property>
    </bean>
	
</beans>  