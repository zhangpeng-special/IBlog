package com.iblog.common.enumerate;

public enum ResponseCodeEnum {
	 FAIL("-100","response fail"),
	 SUCCESS("200","response OK"),
	 WARNING("201","response Warning"),
	 NO_LOGIN("-101","session invalid");
   
   private final String value;

   private final String desc;
   
   //构造器默认也只能是private, 从而保证构造函数只能在内部使用
   ResponseCodeEnum(String value,String desc) {
       this.value = value;
       this.desc=desc;
   }
   
   public String getValue() {
       return value;
   }
   
   public String getDesc() {
       return desc;
   }
}
