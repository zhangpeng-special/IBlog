package com.iblog.model;

import java.util.List;

import com.iblog.model.base.BaseFriend;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Friend extends BaseFriend<Friend> {
	public static final Friend dao = new Friend();
	
	public List<Friend> findByVisible(String visible) {
		return find("select * from friend where visible = '"+visible+"'");
	}
}
