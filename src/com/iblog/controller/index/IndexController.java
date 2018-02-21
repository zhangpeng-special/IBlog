package com.iblog.controller.index;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.iblog.controller.BaseController;
import com.iblog.controller.admin.AdminsController;
import com.iblog.model.Blog;
import com.iblog.model.Category;
import com.iblog.model.Friend;
import com.iblog.model.Information;
import com.iblog.model.Site;
import com.iblog.util.DateUtil;
import com.iblog.util.SysThreadPool;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.ehcache.CacheInterceptor;
import com.jfinal.plugin.ehcache.CacheKit;
import com.jfinal.plugin.ehcache.CacheName;

/**
 * IndexController
 */
public class IndexController extends BaseController {
	
	private static Logger logger = Logger.getLogger(AdminsController.class);
	
	@Before(CacheInterceptor.class)
	@CacheName("index")
	public void index() {
		Information information = null;
		List<Friend> friendList = null;
		try{
			information = Information.dao.getInformation();
			friendList = Friend.dao.findByVisible("1");
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -方法：index",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -方法：index",e);
			renderError(404);
		}
		setAttr("information",information);
		setAttr("friendList",friendList);
		setCommonAttr();
		render("index.jsp");
	}
	
	@Before(CacheInterceptor.class)
	@CacheName("category")
	public void category() {
		Page<Blog> blogPage = null;
		Category category = null;
		try{
			int id = getParaToInt(0);
			int page = getParaToInt(1);
			blogPage = Blog.dao.paginateByCategory(page, 8, id);
			category = Category.dao.findById(id);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -方法：category",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -方法：category",e);
			renderError(404);
		}
		if(null == category || null == blogPage || blogPage.getList().size() < 1){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e){
				logger.info("日期格式化异常 -方法：category",e);
			}
			logger.info(datetime + " -IP:"+getIpAddress() + "可能手动篡改url传参 -方法：category");
			renderError(404);
		}
		setAttr("title", category.getName());
		setAttr("keywords", category.getRemark());
        setAttr("description",category.getRemark());
		setAttr("currentCategory",category);
        setAttr("blogPage",blogPage);
        setCommonAttr();
        render(category.getRender());
	}
	
	public void article() {
		Blog blog = null;
		Blog preBlog = null;
		Blog nextBlog = null;
		try{
			int id = getParaToInt(0);
			blog = Blog.dao.findById(id);
			String logtime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(blog.getLogtime());
			preBlog = Blog.dao.getPreBlog(logtime);
			nextBlog = Blog.dao.getNextBlog(logtime);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -方法：article",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -方法：article",e);
			renderError(404);
		}
		if(null == blog){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e){
				logger.info("日期格式化异常 -方法：article",e);
			}
			logger.info(datetime + " -IP:"+getIpAddress()+"可能手动篡改url传参 -方法：article");
			renderError(404);
		}
		final int blogId = blog.getId();
		SysThreadPool.threadPool.execute(new Runnable() {
			@Override
			public void run() {
				try {
					Blog.dao.refleshViews(blogId);
					clearCache();
				} catch (Exception e) {
					logger.error("blogId:"+String.valueOf(blogId)+"增长views发现异常",e);
				}
			}
		});
		setAttr("title", blog.getTitle());
		setAttr("keywords", blog.getTags());
        setAttr("description",blog.getTags());
        setAttr("blog",blog);
        setAttr("preBlog",preBlog);
        setAttr("nextBlog",nextBlog);
        setAttr("currentCategory",blog.getCategory());
        setCommonAttr();
		render("blog.jsp");
	}
	
	@Before(CacheInterceptor.class)
	@CacheName("commonAttr")
	public void setCommonAttr() {
		Site site = null;
		List<Category> categoryList = null;
		Page<Blog> hotBlogPage = null;
		Page<Blog> newBlogPage = null;
		try{
			site = Site.dao.getSite();
			categoryList = Category.dao.findAll();
			hotBlogPage = Blog.dao.paginateHot(1, 5);
			newBlogPage = Blog.dao.paginate(1, 8);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -方法：setCommonAttr",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -方法：setCommonAttr",e);
		}
		setAttr("site", site);
		setAttr("categoryList", categoryList);
        setAttr("hotBlogPage",hotBlogPage);
        setAttr("newBlogPage",newBlogPage);
	}
	
	public void clearCache(){
		CacheKit.removeAll("index");
		CacheKit.removeAll("category");
		CacheKit.removeAll("commonAttr");
	}
	
	@Before(CacheInterceptor.class)
	@CacheName("guestbook")
	public void guestbook(){
		Category category = null;
		try{
			int id = getParaToInt(0);
			category = Category.dao.findById(id);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -方法：guestbook",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -方法：guestbook",e);
			renderError(404);
		}
		if(null == category){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e){
				logger.info("日期格式化异常 -方法：guestbook",e);
			}
			logger.info(datetime + " -IP:"+getIpAddress() + "可能手动篡改url传参 -方法：guestbook");
			renderError(404);
		}
		setAttr("title", category.getName());
		setAttr("keywords", category.getRemark());
        setAttr("description",category.getRemark());
		setAttr("currentCategory",category);
        setCommonAttr();
        render(category.getRender());
	}
	
}
