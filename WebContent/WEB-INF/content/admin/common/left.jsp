<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<ul class="am-list admin-sidebar-list">
	<li class="am-active"><a href="${base}/admin"><span class="am-icon-home"></span>首页</a></li>
	<li class="admin-parent">
	    <a class="am-cf" data-am-collapse="{target: '#collapse-nav'}">
	        <span class="am-icon-file"></span> 系统设置 
	        <span class="am-icon-angle-right am-fr am-margin-right"></span>
	    </a>
		<ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
			<li><a href="${base}/admin/goEditInformation" class="am-cf">
			    <span class="am-icon-check"></span>个人资料
			    <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
			    </a>
			</li>
			<li><a href="${base}/admin/goEditSite"><span class="am-icon-puzzle-piece"></span> 网站信息</a></li>
			<li><a href="${base}/admin/findMyCategorys"><span class="am-icon-calendar"></span> 导航分类</a></li>
			<li><a href="${base}/admin/findMyFriends/1"><span class="am-icon-th"></span> 友链管理</a></li>
			<li><a href="javascript:void(0)"><span class="am-icon-bug"></span> 系统日志</a></li>
		</ul>
	</li>
	<li><a href="${base}/admin/findMyBlogs"><span class="am-icon-table"></span>文章管理</a></li>
	<li><a href="javascript:void(0)"><span class="am-icon-pencil-square-o"></span>评论管理</a></li>
	<li><a href="javascript:void(0)"><span class="am-icon-pencil-square-o"></span>留言管理</a></li>
</ul>
<div class="am-panel am-panel-default admin-sidebar-panel">
	<div class="am-panel-bd">
		<p>
			<span class="am-icon-bookmark"></span> 公告
		</p>
		<p>时光静好，与君语；细水流年，与君同。—— IBlog</p>
	</div>
</div>