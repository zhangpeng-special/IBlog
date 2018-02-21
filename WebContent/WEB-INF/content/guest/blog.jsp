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
    <h2 class="about_h">您现在的位置是：<a href="${base}">首页</a>><a href="javascript:void(0)">${blog.category.name}</a></h2>
    <div class="index_about">
      <h2 class="c_titile">${blog.title}</h2>
      <p class="box_c">
      <span class="d_time">发布时间：<fmt:formatDate value="${blog.logtime}" pattern="yyyy-MM-dd"/></span>
      <span>编辑：${blog.sourceName}</span>
      <span>浏览(${blog.views})</span>
      </p>
      <ul class="infos">
        ${blog.content}
      </ul>
      <div class="keybq">
        <p><span>关键字词</span>：${blog.tags}</p>
      </div>
      
		<!-- JiaThis Button BEGIN -->
		<div class="jiathis_style">
		<span class="jiathis_txt">分享到：</span>
		<a class="jiathis_button_weixin">微信</a>
		<a class="jiathis_button_qzone">QQ空间</a>
		<a class="jiathis_button_douban">豆瓣</a>
		<a class="jiathis_button_cqq">QQ好友</a>
		<a class="jiathis_button_tsina">新浪微博</a>
		<a href="http://www.jiathis.com/share?uid=2156650" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank">更多</a>
		</div>
		<script type="text/javascript" >
		var jiathis_config={
			data_track_clickback:true,
			url:"<%=basePath%>/article/${blog.id}",
			summary:"${blog.statement}",
			title:"#${blog.title}#",
			pic:"<%=basePath%>/${blog.titlePicture}",
			shortUrl:false,
			hideMore:false
		}
		</script>
		<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=2156650" charset="utf-8"></script>
		<!-- JiaThis Button END -->
		<div class="clear"></div>
		<p>&nbsp;</p>

      <div class="nextinfo">
        <p>上一篇：
        <c:choose>
			<c:when test="${empty preBlog}">
				没有了
			</c:when>
			<c:otherwise>
				<a href="article/${preBlog.id}">${preBlog.title}</a>
			</c:otherwise>
		</c:choose>
        </p>
        <p>下一篇：
        <c:choose>
			<c:when test="${empty nextBlog}">
				没有了
			</c:when>
			<c:otherwise>
				<a href="article/${nextBlog.id}">${nextBlog.title}</a>
			</c:otherwise>
		</c:choose>
        </p>
      </div>
	 <div class="otherlink">
			<h2>评论</h2>
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
  </article>
  <jsp:include page="${contextPath}/WEB-INF/content/guest/common/aside.jsp" />
</div>
</body>
</html>