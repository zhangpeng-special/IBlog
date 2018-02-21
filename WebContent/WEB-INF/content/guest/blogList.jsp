<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<jsp:include page="${contextPath}/WEB-INF/content/guest/common/common.jsp" />
<body>
<div class="ibody">
<jsp:include page="${contextPath}/WEB-INF/content/guest/common/header.jsp" />
  <article>
    <h2 class="about_h">您现在的位置是：<a href="${base}">首页</a>><a href="javascript:void(0)">${currentCategory.name}</a></h2>
    <div class="bloglist">
    <c:forEach items="${blogPage.list}" var="blog" varStatus="status">
      <div class="newblog">
        <ul>
          <h3><a href="article/${blog.id}">${blog.title}</a></h3>
          <div class="autor">
          <span>作者：<a href="${blog.sourceURL}" target="_blank">${blog.sourceName}</a></span><span>分类：[<a href="category/${blog.category.id}-1">${blog.category.name}</a>]</span>
          <span>浏览(<a href="article/${blog.id}">${blog.views}</a>)</span>
          </div>
          <p>${blog.statement}<a href="article/${blog.id}" target="_blank" class="readmore">全文</a></p>
        </ul>
        <figure><img src="${blog.titlePicture}" ></figure>
        <div class="dateview"><fmt:formatDate value="${blog.logtime}" pattern="yyyy-MM-dd"/></div>
      </div>
    </c:forEach>
    </div>
    <div id="kkpager"></div>
  </article>
  <jsp:include page="${contextPath}/WEB-INF/content/guest/common/aside.jsp" />
</div>
<script type="text/javascript">
laypage({
    cont: 'kkpager',
    pages: '${blogPage.totalPage}', //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
    curr: '${blogPage.pageNumber}', 
    first: 1, //将首页显示为数字1,。若不显示，设置false即可
    last: false, //将尾页显示为总页数。若不显示，设置false即可
    prev: '<', //若不显示，设置false即可
    next: '>', //若不显示，设置false即可
    groups: 5, //连续显示分页数
    skin: 'molv', //皮肤
    jump: function(e, first){ //触发分页后的回调
        if(!first){ //一定要加此判断，否则初始时会无限刷新
            location.href = 'category/${currentCategory.id}-'+e.curr;
        }
    }
});
</script>
</body>
</html>