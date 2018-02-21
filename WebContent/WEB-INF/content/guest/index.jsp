<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!doctype html>
<html>
<head>
<base href="<%=path%>">
<meta charset="utf-8">
<title>${site.name}</title>
<meta name="keywords" content="张小戊,张小戊的博客,jfinal博客,java博客" />
<meta name="description" content="张小戊的个人博客，分享java编程技术开发工作日常心得体会，也分享工作之余的生活见闻与人生感悟。" />
<link href="css/base.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/media.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->

<style type="text/css">
.logo { background: url('${site.logo}') no-repeat #000 center; width: 145px; height: 145px; border-radius: 50%; position: absolute; left: -72px; top: 40px; box-shadow: 0px 2px 2px #414141; }
.avatar a { display: block; padding-top: 100px; width: 160px; background: url('${information.photo}') no-repeat; background-size: 160px 160px; }
.banner { background: url('${site.banner}') no-repeat center; height: 290px; margin: 10px auto; width: 100%; font-size: 16px; font-family: "Microsoft Yahei", Arial, Helvetica, sans-serif; }
</style>
</head>
<body>
<div class="ibody">
<jsp:include page="${contextPath}/WEB-INF/content/guest/common/header.jsp" />
  <article>
    <jsp:include page="${contextPath}/WEB-INF/content/guest/common/banner.jsp" />
    <div class="bloglist">
      <h2>
        <p><span>推荐</span>文章</p>
      </h2>
      <c:forEach items="${hotBlogPage.list}" var="blog" varStatus="status">
      <div class="blogs">
        <h3><a href="article/${blog.id}">${blog.title}</a></h3>
        <figure><img src="${blog.titlePicture}" ></figure>
        <ul>
          <p>${blog.statement}</p>
          <a href="article/${blog.id}" target="_blank" class="readmore">阅读全文&gt;&gt;</a>
        </ul>
        <p class="autor"><span>作者：<a href="${blog.sourceURL}" target="_blank">${blog.sourceName}</a></span><span>分类：【<a href="category/${blog.category.id}-1">${blog.category.name}</a>】</span>
        <span>浏览(<a href="article/${blog.id}">${blog.views}</a>)</span>
        </p>
        <div class="dateview"><fmt:formatDate value="${blog.logtime}" pattern="yyyy-MM-dd"/></div>
      </div>
      </c:forEach>
    </div>
  </article>
  <aside>
    <div class="avatar"><a href="javascript:void(0)"><span>${information.name}</span></a></div>
    <div class="topspaceinfo">
      <h1>${information.title}</h1>
      <p>${information.content}</p>
    </div>
    <div class="about_c">
      <p>昵称：${information.name}</p>
      <p>职业：${information.job} </p>
      <p>地址：${information.address}</p>
      <p>联系方式：${information.contect}</p>
    </div>
    <div class="bdsharebuttonbox">
		<a href="#" class="bds_more" data-cmd="more"></a>
		<a href="#" class="bds_qzone" data-cmd="qzone"></a>
		<a href="#" class="bds_tsina" data-cmd="tsina"></a>
		<a href="#" class="bds_tqq" data-cmd="tqq"></a>
		<a href="#" class="bds_weixin" data-cmd="weixin"></a>
    </div>
	<script>
		window._bd_share_config = {
			common : {
				bdText : '${site.bannerContent}',	
				bdDesc : '${site.name}',	
				bdUrl : 'http://www.nalidor.com', 	
				bdPic : '<%=basePath%>${site.banner}'
			},
			share : [{
				"bdSize" : 32
			}],
			image : [{
				viewList : ['qzone','tsina','tqq','weixin'],
				viewText:'分享到：',
				viewSize : '32'
			}],
			selectShare : [{
				"bdselectMiniList" : ['qzone','tsina','tqq','weixin']
			}]
		}
		with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
	</script>
    <div class="tj_news">
      <h2>
        <p class="tj_t1">最新文章</p>
      </h2>
      <ul>
        <c:forEach items="${newBlogPage.list}" var="blog" varStatus="status">
        <li><a href="article/${blog.id}">${blog.title}</a></li>
        </c:forEach>
      </ul>
      <h2>
        <p class="tj_t2">推荐文章</p>
      </h2>
      <ul>
        <c:forEach items="${hotBlogPage.list}" var="blog" varStatus="status">
        <li><a href="article/${blog.id}">${blog.title}</a></li>
        </c:forEach>
      </ul>
    </div>
    <div class="links">
      <h2>
        <p>友情链接</p>
      </h2>
      <ul>
        <c:forEach items="${friendList}" var="friend" varStatus="status">
        <li><a href="${friend.url}" target="_blank">${friend.name}</a></li>
        </c:forEach>
      </ul>
    </div>
    <div class="copyright">
      <ul>
        <p> Designed by <a href="javascript:void(0)">${site.copyright}</a></p>
        <p>${site.license}</p>
        </p>
      </ul>
    </div>
  </aside>
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 -->
</div>
</body>
</html>