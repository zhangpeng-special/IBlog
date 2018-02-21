package com.iblog.config;

import com.iblog.config.route.AdminRoutes;
import com.iblog.config.route.FrontRoutes;
import com.iblog.timer.TimerTaskManager;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;

/**
 * API引导式配置
 */
public class Config extends JFinalConfig {
	
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("mysql.properties");
		me.setDevMode(PropKit.getBoolean("devMode", false));
        me.setBaseViewPath("/WEB-INF/content");
		me.setViewType(ViewType.JSP);
		me.setEncoding("UTF-8");
        me.setError404View("/WEB-INF/content/404.jsp");
        me.setError500View("/WEB-INF/content/500.jsp");
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add(new FrontRoutes());  //前端路由
		me.add(new AdminRoutes());  //后端路由
	}
	
	public static C3p0Plugin createC3p0Plugin() {
		return new C3p0Plugin(PropKit.get("jdbcUrl").trim(), PropKit.get("username").trim(), PropKit.get("password").trim());
	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin c3p0Plugin = createC3p0Plugin();
		c3p0Plugin.setDriverClass(PropKit.get("jdbcDriver").trim());
		me.add(c3p0Plugin);
		
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		arp.setDialect(new MysqlDialect());
		me.add(arp);
		
        // 配置Ecache插件
        me.add(new EhCachePlugin());
		
		// 所有配置在 MappingKit 中搞定
		MappingKit.mapping(arp);
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		me.add(new ContextPathHandler("base"));
	}
	
    @Override
    public void afterJFinalStart(){
    	//定时爬取简书首页文章
    	TimerTaskManager tm = new TimerTaskManager();
        tm.init();
    }
	
}
