package com.iblog.model;

import java.util.List;

import com.iblog.model.base.BaseCategory;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Category extends BaseCategory<Category> {

	public static final Category dao = new Category();

	public List<Category> findAll() {
		return find("select * from category order by sort");
	}

}
