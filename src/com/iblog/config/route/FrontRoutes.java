package com.iblog.config.route;

import com.iblog.controller.index.IndexController;
import com.jfinal.config.Routes;

public class FrontRoutes extends Routes {

	@Override
	public void config() {
		add("/", IndexController.class,"/guest");
	}
}
