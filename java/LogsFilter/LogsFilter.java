package com.bz.mh;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.sql.Timestamp;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.bz.mh.po.VisitLog;
import com.bz.mh.visit.dao.VisitLogDao;
import com.bz.mh.visit.service.VisitLogService;

public class LogsFilter implements Filter {
	
	private ServletContext servletContext;
	
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    	servletContext =  filterConfig.getServletContext();  
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
    	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	    HttpServletRequest request = (HttpServletRequest) servletRequest;  
        HttpServletResponse response = (HttpServletResponse) servletResponse;  
        try{
		    VisitLogService service_visit = (VisitLogService)wac.getBean("visitLogServiceImpl");
		    String ipAddress = getIpAddr(request);
		    String webAddress = request.getServletPath();
		    Timestamp currTime = new Timestamp(System.currentTimeMillis());
		    String str1 = request.getParameter("categoryId");
		    String str2 = request.getParameter("contentId");
		    Integer categoryId,contentId;
		    try {
		    	categoryId = Integer.valueOf(str1);
			} catch (Exception e) {
				categoryId = null;
			}
		    try {
		    	contentId = Integer.valueOf(str2);
			} catch (Exception e) {
				contentId = null;
			}
		    //业务类型 :1、栏目2、内容3、全文检索4、错误页面
		    Integer busiType;
		    String busiName = null;
		    if (categoryId != null) {
		    	busiType =1;
		    	busiName = "栏目访问";
		    } else {
		    	if (contentId != null) {
			    	busiType =2;
			    	busiName = "新闻访问";
			    } else {
			    	//判断是否是全文搜索页面
				    int in = webAddress.substring(webAddress.lastIndexOf("/")).indexOf("search");
				    if (in > -1) {
				    	busiType =3;
				    	busiName = "全文搜索";
				    } else {
				    	in = webAddress.substring(webAddress.lastIndexOf("/")).indexOf("error");
				    	if (in > -1) {
				    		busiType =4;
				    		
				    	} else {
				    		busiType =1;
				    		categoryId = 101;
				    		busiName = "栏目访问";
				    	}
				    }
			    }
		    }
		    VisitLog log = new VisitLog();
		    log.setVisit_address(request.getRequestURI());
		    log.setVisit_ipaddress(ipAddress);
		    log.setVisit_time(currTime);
		    log.setCategory_id(categoryId);
		    log.setContent_id(contentId);
		    log.setBusiness_type(busiType);
		    log.setBusiness_name(busiName);
		    log.setSite_id(1);
		    service_visit.doSave(log);
        } catch(Exception e) {
        	  filterChain.doFilter(servletRequest, servletResponse);
        }
	    filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
    
    public static void main(String[] args) {
		String a = "/gzzscq/list/search.jsp";
		System.out.println(a.substring(a.lastIndexOf("/")).length());
	}
    
    public String getIpAddr(HttpServletRequest request) { 
        String ip = request.getHeader("x-forwarded-for"); 
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }   
        return ip; 
    }
    
}
