
package com.iblog.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class LoginInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
        Controller controller = inv.getController();
        Object admin = controller.getSession().getAttribute("admin");
        if(null != admin && "zhangpeng".equals(String.valueOf(admin))){
        	inv.invoke();
        }else{
        	controller.render("login.jsp");
        }
	}
	
}
