package com.iblog.config.route;

import com.iblog.controller.admin.AdminsController;
import com.jfinal.config.Routes;

public class AdminRoutes extends Routes {

	@Override
	public void config() {
		add("/admin", AdminsController.class);// 第三个参数省略时默认与第一个参数值相同，在此即为 "/admin"
	}
}
