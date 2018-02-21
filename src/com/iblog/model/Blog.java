package com.iblog.model;

import com.iblog.model.base.BaseBlog;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Blog extends BaseBlog<Blog> {
	
	public static final Blog dao = new Blog();
	
	private Category category;
	
	private String categoryName;
	
	private String startDate;
	
	private String endDate;
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Category getCategory() {
		this.category = Category.dao.findById(this.getCategoryId());
		return this.category;
	}
	
	public void refleshViews(int id){
		Db.update("update blog set views = views + 1 where id = " + id);
	}
	
	public void refleshComments(int id){
		Db.update("update blog set comments = comments + 1 where id = " + id);
	}
	
	public Blog getPreBlog(String logtime){
		Blog blog = findFirst("select * from blog where visible = '1' and logtime > '" + logtime + "' order by logtime");
	    return blog;
	}
	
	public Blog getNextBlog(String logtime){
		Blog blog = findFirst("select * from blog where visible = '1' and logtime < '" + logtime + "' order by logtime desc");
	    return blog;
	}

	/**
	 * 博客和首页默认博客列表
	 */
	public Page<Blog> paginate(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select * ",
				"from blog where visible = '1' order by logtime desc");
	}

	/**
	 * 最热博客
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Page<Blog> paginateHot(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select * ",
				"from blog where visible = '1' order by views desc, logtime desc");
	}

	public Page<Blog> paginateByCategory(int pageNumber, int pageSize, int categoryId) {
		return paginate(pageNumber, pageSize, "select * ",
				"from blog where categoryId = ? and visible = '1' order by logtime desc", categoryId);
	}

	public Page<Blog> paginateByKeyword(int pageNumber, int pageSize, String keyword) {
		return paginate(pageNumber, pageSize, "select * ", 
				"from blog where (title like '%" + keyword
				+ "%' or tags like '%" + keyword + "%') and visible = '1' order by logtime desc");
	}
	
	public Page<Blog> paginateByCondition(int pageNumber, int pageSize, Blog blog){
		
	    StringBuffer sb = new StringBuffer(" from blog where 1 = 1 ");
	    
	    if (blog.getTitle() != null && !"".equals(blog.getTitle()))
	    	sb.append(" and title like '%" + blog.getTitle() + "%'");
	    if (blog.getTags() != null && !"".equals(blog.getTags()))
	        sb.append(" and tags like '%" + blog.getTags() + "%'");
	    if (blog.getCategoryId() != null && blog.getCategoryId() != 0)
		    sb.append(" and categoryId = '" + blog.getCategoryId() + "'");
	    if (blog.getStartDate() != null && !"".equals(blog.getStartDate()))
		    sb.append(" and logtime >= '" + blog.getStartDate() + "'");
	    if (blog.getEndDate() != null && !"".equals(blog.getEndDate()))
		    sb.append(" and logtime <= '" + blog.getEndDate() + "'");
	    if (blog.getVisible() != null && !"".equals(blog.getVisible()))
	        sb.append(" and visible = '" + blog.getVisible() + "'");
	    
	    sb.append(" order by logtime desc");
	    
	    String querySql = sb.toString();
	    
		return paginate(pageNumber, pageSize, "select * ", querySql);
	}
}