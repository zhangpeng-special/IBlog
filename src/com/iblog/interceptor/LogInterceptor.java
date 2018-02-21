package com.iblog.interceptor;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.iblog.util.DateUtil;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class LogInterceptor implements Interceptor {

	private Logger logger = Logger.getLogger("");

	@Override
	public void intercept(Invocation inv) {
		Controller c = inv.getController();
		HttpServletRequest request = c.getRequest();
		String ip = getIpAddress(request);
		try {
			String url = request.getRequestURL().toString();
			Map<String, String[]> map = request.getParameterMap();
			Set<String> keys = map.keySet();
			List<Map<String,String>> parameterList = new ArrayList<Map<String,String>>();
			for (String key : keys) {
				if (key.equals("_")) {
					continue;
				}
				Map<String,String> everyParameter = new HashMap<String,String>();
				everyParameter.put(key, ((Object[]) map.get(key))[0].toString());
				parameterList.add(everyParameter);
			}
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -类：LogInterceptor",e1);
			}
			logger.info(datetime + " -IP:" + ip + " -管理员后台方法：" + url + " -参数：" + parameterList.toString());
		} catch (Exception e) {
			logger.error("访问管理员后台的ip日志记录异常：" + e.getMessage());
		}
		inv.invoke();
	}

	/**
	 * 获得当前Request真实的IP地址
	 */
	protected String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
