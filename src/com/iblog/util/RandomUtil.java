package com.iblog.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 随机生成一定长度的文件名
 *
 */
public class RandomUtil {
	
	public static final String ALLCHAR = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	public static final String LETTERCHAR = "abcdefghijkllmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	public static final String NUMBERCHAR = "0123456789";

	/**
	 * 生成数字字符串
	 * @param length
	 * @return
	 */
	public static String generateNum(int length) {
		  StringBuffer sb = new StringBuffer();
		  Random random = new Random();
		  for (int i = 0; i < length; i++) {
			  sb.append(NUMBERCHAR.charAt(random.nextInt(NUMBERCHAR.length())));
		  }
		  return sb.toString();
	}
	
	/**
	 * 生成大小写字母数字字符串
	 * @param length
	 * @return
	 */
	public static String generateString(int length) {
		  StringBuffer sb = new StringBuffer();
		  Random random = new Random();
		  for (int i = 0; i < length; i++) {
			  sb.append(ALLCHAR.charAt(random.nextInt(ALLCHAR.length())));
		  }
		  return sb.toString();
	}
	
	
	/**
	 * 生成大小写字母字符串
	 * @param length
	 * @return
	 */
	 public static String generateMixString(int length) {
		  StringBuffer sb = new StringBuffer();
		  Random random = new Random();
		  for (int i = 0; i < length; i++) {		   
			  sb.append(ALLCHAR.charAt(random.nextInt(LETTERCHAR.length())));
		  }
		  return sb.toString();
	}


	 /**
	  * 生成小写字母字符串
	  * @param length
	  * @return
	  */
	 public static String generateLowerString(int length) {
		  
		 return generateMixString(length).toLowerCase();
	 }

	 
	 /**
	  * 生成大写字母字符串
	  * @param length
	  * @return
	  */
	 public static String generateUpperString(int length) {
		 return generateMixString(length).toUpperCase();
	 }
	 
	 /**
	  * 生成当前时间字符串
	  * @return
	  */
	 public static String generateDateString(){
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		 return sdf.format(new Date());
	 }
	 
	 /**
	  * yyyy/MM/dd HH:mm:ss
	  * @param date
	  * @return
	  */
	 public static String generateBasicDate(Date date){
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		 return sdf.format(date);
	 }
	 
	 /**
	  * yyyy-MM-dd HH:mm:ss
	  * @param date
	  * @return
	  */
	 public static String generateYMDHMSDate(Date date){
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 return sdf.format(date);
	 }
	 
	 public static String generateYMD(Date date){
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		 return sdf.format(date);
	 }
	 
	 public static String generateYearString(Date date){
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
		 return sdf.format(date);
	 }
	 
	 /**
	  * 字符串转为日期
	  * @param date
	  * @return
	  * @throws ParseException
	  */
	 public static Date generateYearDate(String date) throws ParseException{
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 return sdf.parse(date);
	 }
	 
	 /**
	  * 字符串转为日期
	  * @param date
	  * @return
	  * @throws ParseException
	  */
	 public static Date generateYMD(String date) throws ParseException{
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		 return sdf.parse(date);
	 }
	 
}
