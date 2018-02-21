<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!doctype html>
<html>
<jsp:include page="${contextPath}/WEB-INF/content/guest/common/common.jsp" />
<body>
<div class="ibody">
  <jsp:include page="${contextPath}/WEB-INF/content/guest/common/header.jsp" />
  <article>
    <h2 class="about_h">您现在的位置是：<a href="${base}">首页</a>><a href="javascript:void(0)">${currentCategory.name}</a></h2>
    <div class="index_about">
	  <div class="otherlink">
			<h2>留言</h2>
			<!-- 来必力City版安装代码 -->
			<div id="lv-container" data-id="city" data-uid="MTAyMC8zMzYwMS8xMDE1Ng==">
				<script type="text/javascript">
			   (function(d, s) {
			       var j, e = d.getElementsByTagName(s)[0];
			
			       if (typeof LivereTower === 'function') { return; }
			
			       j = d.createElement(s);
			       j.src = 'https://cdn-city.livere.com/js/embed.dist.js';
			       j.async = true;
			
			       e.parentNode.insertBefore(j, e);
			   })(document, 'script');
				</script>
			<noscript> 为正常使用来必力评论功能请激活JavaScript</noscript>
			</div>
			<!-- City版安装代码已完成 -->
	  </div>
    </div>
    <div>
        <embed src="http://music.163.com/style/swf/widget.swf?sid=22829933&amp;type=2&amp;auto=1&amp;width=278&amp;height=32" 
           style="visibility:hidden;"width="298" height="50" allownetworking="all">
    </div>
  </article>
  <jsp:include page="${contextPath}/WEB-INF/content/guest/common/aside.jsp" />
</div>
</body>
</html>