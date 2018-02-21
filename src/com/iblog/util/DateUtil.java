package com.iblog.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * 使用ThreadLocal以空间换时间解决SimpleDateFormat线程安全问题。
 */
public class DateUtil {

	private static final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	private static ThreadLocal<DateFormat> threadLocal = new ThreadLocal<DateFormat>();

	// 第一次调用get将返回null
	// 获取线程的变量副本，如果不覆盖initialValue，第一次get返回null，
	// 故需要初始化一个SimpleDateFormat，并set到threadLocal中
	public static DateFormat getDateFormat(String pattern) {
		if(null == pattern || "".equals(pattern))
			pattern = DATE_FORMAT;
		DateFormat df = (DateFormat) threadLocal.get();
		if (df == null) {
			df = new SimpleDateFormat(pattern);
			threadLocal.set(df);
		}
		return df;
	}
	
}
