package com.bz.mh;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SqlInjectIntercepter implements Filter{
 	private static List<String> invalidsql = new ArrayList<String>(); 
    private static boolean debug = false; 
     
    public void destroy() { 
         
    } 
    public void doFilter(ServletRequest req, ServletResponse res, 
            FilterChain fc) throws IOException, ServletException { 
        HttpServletRequest request = (HttpServletRequest)req; 
        HttpServletResponse response = (HttpServletResponse)res; 
        Map<String, String[]> params = request.getParameterMap(); 
        Set<String> keys = params.keySet(); 
        for(String key : keys){ 
            String value = request.getParameter(key); 
            if(debug){ 
                System.out.println("process params <key, value>: <"+key+", "+value+">"); 
            } 
            for(String word : invalidsql){ 
                if(word.equalsIgnoreCase(value) || value.contains(word)){ 
                    if(value.contains("<")){ 
                        value = value.replace("<", "<"); 
                    } 
                    if(value.contains(">")){ 
                        value = value.replace(">", ">"); 
                    } 
                    request.getSession().setAttribute("sqlInjectError", "the request parameter \""+value+"\" contains keyword: \""+word+"\"");  
                    response.getWriter().println("搜索内容存在不安全字符:"+value+",请返回重新输入");
                    System.out.println("sql注入字段："+value);
                    return; 
                } 
            } 
        } 
        fc.doFilter(req, res); 
    } 
    public void init(FilterConfig conf) throws ServletException { 
        String sql = conf.getInitParameter("invalidsql"); 
        String de = conf.getInitParameter("debug"); 
        if(sql != null){ 
            invalidsql = Arrays.asList(sql.split(",")); 
        } 
        if(de != null && Boolean.parseBoolean(de)){ 
            debug = true; 
            System.out.println("PreventSQLInject Filter staring..."); 
            System.out.println("invalid words as fllows (split with blank):"); 
            for(String s : invalidsql){ 
                System.out.print(s+" "); 
            } 
        } 
    } 
}

