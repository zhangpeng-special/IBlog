
package com.iblog.controller.admin;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import com.iblog.controller.BaseController;
import com.iblog.interceptor.LogInterceptor;
import com.iblog.interceptor.LoginInterceptor;
import com.iblog.model.Blog;
import com.iblog.model.Category;
import com.iblog.model.Friend;
import com.iblog.model.Information;
import com.iblog.model.Site;
import com.iblog.util.DateUtil;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.ehcache.CacheKit;
import com.jfinal.upload.UploadFile;

/**
 * 博客管理 - 后台
 * @author peng
 *
 */

@Before({LoginInterceptor.class,LogInterceptor.class})
public class AdminsController extends BaseController{
	
	private static Logger logger = Logger.getLogger(AdminsController.class);
	
	public void index() {
		render("index.jsp");
	}
	
	@Clear(LoginInterceptor.class)
	public void login(){
		String username = getPara("username");
		String password = getPara("password");
		if("test".equals(username) && "test".equals(password)){
			HttpSession session = getSession();
			session.setAttribute("admin", "test");
			render("index.jsp");
		}else{
			setAttr("username",username);
			setAttr("password",password);
			setAttr("message","账号或密码错误");
			render("login.jsp");
		}
	}

	// ==================博客管理=====================
	public void findMyBlogs() {
		Blog param = getModel(Blog.class);
		if(null == param.getVisible() || "".equals(param.getVisible()))
			param.setVisible("1");
		Page<Blog> blogPage = null;
		List<Category> categoryList = null;
		try{
			blogPage = Blog.dao.paginateByCondition(getParaToInt("page", 1), 10, param);
		    categoryList = Category.dao.findAll();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：findMyBlogs",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：findMyBlogs",e);
			renderError(500);
		}
		setAttr("blog",param);
        setAttr("blogPage",blogPage);
        setAttr("categoryList",categoryList);
        render("blog/blogManage.jsp");
	}
	
	public void goAddBlog() {
		List<Category> categoryList = null;
		try{
		    categoryList = Category.dao.findAll();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goAddBlog",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goAddBlog",e);
			renderError(500);
		}
		setAttr("categoryList",categoryList);
		render("blog/blogAdd.jsp");
	}
	
	public void goEditBlog() {
		int id = getParaToInt(0);
		Blog blog = null;
		List<Category> categoryList = null;
		try{
			blog = Blog.dao.findById(id);
			categoryList = Category.dao.findAll();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goEditBlog",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goEditBlog",e);
			renderError(500);
		}
        setAttr("blog",blog);
        setAttr("categoryList",categoryList);
		render("blog/blogEdit.jsp");
	}
	
    public void uploadPicture() {
        UploadFile file = getFile();
        String statusCode;
        try{
        	String oldFileName = file.getFileName();
            String suffix = oldFileName.substring(oldFileName.lastIndexOf('.'));
            String newFilename = UUID() + suffix;
            File destFile = new File(PathKit.getWebRootPath() + File.separator + "upload" + File.separator + newFilename);
            FileUtils.moveFile(file.getFile(), destFile);
            statusCode = newFilename;
        }catch (Exception e){
        	statusCode = "error";
        }
        renderJson("statusCode", statusCode);
    }

	public void addBlog() {
		Blog param = getModel(Blog.class);
		param.setLogtime(new Date());
		String statement = param.getStatement();
		String statusCode;
		if(statement.length() > 255){
			statement = statement.substring(0,252);
			param.setStatement(statement + "...");
		}
		try{
			param.save();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void saveBlog() {
		Blog param = getModel(Blog.class);
		param.setLogtime(new Date());
		String statement = param.getStatement();
		String statusCode;
		if(statement.length() > 255){
			statement = statement.substring(0,252);
			param.setStatement(statement + "...");
		}
		try{
			param.update();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void resetBlog() {
		String statusCode;
		int id = getParaToInt(0);
		String visible = getPara(1);
		try{
			Blog blog = Blog.dao.findById(id);
			if(null != blog){
				blog.setVisible(visible);;
				blog.update();
			}
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}

	public void deleteBlog() {
		String statusCode;
		int id = getParaToInt("id");
		try{
			Blog.dao.deleteById(id);
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	// ==================导航管理=====================
	public void findMyCategorys() {
		List<Category> categoryList = null;
		try{
			categoryList = Category.dao.findAll();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：findMyCategorys",e1);
			}
			logger.error(datetime + " -IP:" + getIpAddress() + " -管理员后台方法：findMyCategorys",e);
			renderError(500);
		}
        setAttr("categoryList",categoryList);
        render("category/categoryManage.jsp");
	}

	public void goAddCategory() {
		render("category/categoryAdd.jsp");
	}
	
	public void goEditCategory() {
		int id = getParaToInt(0);
		Category category = null;
		try{
			category = Category.dao.findById(id);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goEditCategory",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goEditCategory",e);
			renderError(500);
		}
        setAttr("category",category);
		render("category/categoryEdit.jsp");
	}

	public void addCategory() {
		Category param = getModel(Category.class);
		param.setLogtime(new Date());
		String statusCode;
		try{
			param.save();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void saveCategory() {
		Category param = getModel(Category.class);
		param.setLogtime(new Date());
		String statusCode;
		try{
			param.update();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void refleshCategory(){
		String statusCode;
		try{
			List<Category> categoryList = Category.dao.findAll();
			getSession().removeAttribute("categoryList");
			getSession().setAttribute("categoryList", categoryList);
			statusCode = "success";
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}

	public void deleteCategory() {
		String statusCode;
		int id = getParaToInt(0);
		try{
			Category.dao.deleteById(id);
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	// ==================网站信息管理=====================
	
	public void goEditSite() {
		Site site = null;
		try{
			site = Site.dao.getSite();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goEditSite",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goEditSite",e);
			renderError(500);
		}
        setAttr("site",site);
		render("site/siteEdit.jsp");
	}
	
	public void saveSite() {
		Site param = getModel(Site.class);
		param.setLogtime(new Date());
		String statusCode;
		try{
			param.update();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	// ==================友链管理=====================

	public void findMyFriends() {
		String visible = getPara(0);
		List<Friend> friendList = null;
		try{
			friendList = Friend.dao.findByVisible(visible);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：findMyFriends",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress()+" -管理员后台方法：findMyFriends",e);
			renderError(500);
		}
		setAttr("visible",visible);
        setAttr("friendList",friendList);
        render("friend/friendManage.jsp");
	}

	public void goAddFriend() {
		render("friend/friendAdd.jsp");
	}
	
	public void goEditFriend() {
		int id = getParaToInt(0);
		Friend friend = null;
		try{
			friend = Friend.dao.findById(id);
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goEditFriend",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goEditFriend",e);
			renderError(500);
		}
        setAttr("friend",friend);
		render("friend/friendEdit.jsp");
	}

	public void addFriend() {
		Friend param = getModel(Friend.class);
		String statusCode;
		try{
			param.save();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void saveFriend() {
		Friend param = getModel(Friend.class);
		String statusCode;
		try{
			param.update();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void refleshFriends(){
		String statusCode;
		try{
			List<Friend> friendList = Friend.dao.findByVisible("1");
			getSession().removeAttribute("friendList");
			getSession().setAttribute("friendList", friendList);
			statusCode = "success";
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}

	public void deleteFriend() {
		String statusCode;
		int id = getParaToInt(0);
		try{
			Friend.dao.deleteById(id);
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	// ==================个人信息管理=====================
	
	public void goEditInformation() {
		Information information = null;
		try{
			information = Information.dao.getInformation();
		}catch(Exception e){
			String datetime = "";
			try{
				datetime = DateUtil.getDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			}catch(Exception e1){
				logger.info("日期格式化异常 -管理员后台方法：goEditInformation",e1);
			}
			logger.error(datetime + " -IP:"+getIpAddress() + " -管理员后台方法：goEditInformation",e);
			renderError(500);
		}
        setAttr("information",information);
		render("information/informationEdit.jsp");
	}
	
	public void saveInformation() {
		Information param = getModel(Information.class);
		String statusCode;
		try{
			param.update();
			statusCode = "success";
			clearCache();
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void refleshInformation(){
		String statusCode;
		try{
			Information information = Information.dao.getInformation();
			getSession().removeAttribute("information");
			getSession().setAttribute("information", information);
			statusCode = "success";
		}catch(Exception e){
			statusCode = "error";
		}
		renderJson("statusCode", statusCode);
	}
	
	public void clearCache(){
		CacheKit.removeAll("index");
		CacheKit.removeAll("category");
		CacheKit.removeAll("commonAttr");
	}
	
}
