package com.iblog.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseCommentReply<M extends BaseCommentReply<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setCommentId(java.lang.Integer commentId) {
		set("commentId", commentId);
	}

	public java.lang.Integer getCommentId() {
		return get("commentId");
	}

	public void setContent(java.lang.String content) {
		set("content", content);
	}

	public java.lang.String getContent() {
		return get("content");
	}

	public void setLogtime(java.util.Date logtime) {
		set("logtime", logtime);
	}

	public java.util.Date getLogtime() {
		return get("logtime");
	}

	public void setVisitorName(java.lang.String visitorName) {
		set("visitorName", visitorName);
	}

	public java.lang.String getVisitorName() {
		return get("visitorName");
	}

	public void setVisitorEmail(java.lang.String visitorEmail) {
		set("visitorEmail", visitorEmail);
	}

	public java.lang.String getVisitorEmail() {
		return get("visitorEmail");
	}

	public void setVisitorURL(java.lang.String visitorURL) {
		set("visitorURL", visitorURL);
	}

	public java.lang.String getVisitorURL() {
		return get("visitorURL");
	}

}
