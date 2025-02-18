log4j.rootLogger=DEBUG,Console,File

log4j.appender.Console=org.apache.log4j.ConsoleAppender
log4j.appender.Console.Target=System.out
log4j.appender.Console.layout=org.apache.log4j.PatternLayout
log4j.appender.Console.layout.ConversionPattern=[%p][%d{HH\:mm\:ss,SSS}][%c]%m%n

log4j.appender.File=org.apache.log4j.RollingFileAppender 
log4j.appender.File.File=gzahi.log
log4j.appender.File.MaxFileSize=10MB
log4j.appender.File.Threshold=ALL
log4j.appender.File.layout=org.apache.log4j.PatternLayout
log4j.appender.File.layout.ConversionPattern=[%p][%d{yyyy-MM-dd HH\:mm\:ss,SSS}][%c]%m%n

log4j.logger.org.quartz=WARN,Console,File
log4j.logger.org.activiti=WARN,Console,File
log4j.logger.org.apache=WARN,Console,File
log4j.logger.org.mybatis=WARN,Console,File
log4j.logger.net.sf.ehcache=WARN,Console,File
log4j.logger.org.springframework=WARN,Console,File
log4j.logger.org.springframework.jdbc.core.JdbcTemplate=debug,Console,File
