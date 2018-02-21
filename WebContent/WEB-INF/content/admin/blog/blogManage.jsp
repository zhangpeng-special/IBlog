<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html class="no-js">
<jsp:include page="${contextPath}/WEB-INF/content/admin/common/common.jsp" /> 
<body>
<header class="am-topbar admin-header">
   <jsp:include page="${contextPath}/WEB-INF/content/admin/common/header.jsp" /> 
</header>

<div class="am-cf admin-main">

  <!-- sidebar start -->
  <div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
       <jsp:include page="${contextPath}/WEB-INF/content/admin/common/left.jsp"/> 
    </div>
  </div>
  <!-- sidebar end -->

  <!-- content start -->
  <div class="admin-content">
    <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">文章管理</strong> / <small>笑一笑，十年少</small></div>
    </div>
    <form id="queryForm" action="${base}/admin/findMyBlogs" method="post" class="am-form">
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <a href="${base}/admin/goAddBlog" type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span>写文章</a>
          </div>
        </div>
      </div>
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-form-group">
          <select id="categoryId" name="blog.categoryId" data-am-selected="{btnSize: 'sm'}">
            <option value="0">所有类别</option>
            <c:forEach items="${categoryList}" var="category">
               <option value="${category.id}">${category.name}</option>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-form-group">
          <select id="visible" name="blog.visible" data-am-selected="{btnSize: 'sm'}">
             <option value="1">已发布</option>
             <option value="0">拟稿中</option>
          </select>
        </div>
      </div>
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-input-group am-input-group-sm">
          <input name="blog.title" type="text" class="am-form-field" value="${blog.title}" />
          <span class="am-input-group-btn">
            <button class="am-btn am-btn-default" type="button" onclick="search();">搜索</button>
          </span>
        </div>
      </div>
    </div>

    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
          <tbody>
          <c:forEach items="${blogPage.list}" var="blog" varStatus="status">
            <tr>
              <td>${status.count}</td>
              <td><a href="#">${blog.title}</a></td>
              <td>${blog.category.name}</td>
              <td class="am-hide-sm-only">${blog.sourceName}</td>
              <td class="am-hide-sm-only"><fmt:formatDate value="${blog.logtime}" pattern="yyyy-MM-dd HH:mm"/></td>
              <td>
                <div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                    <a href="${base}/admin/goEditBlog/${blog.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 编辑</a>
                    <c:choose> 
                    <c:when test="${blog.visible eq '1'}">
                       <button onclick="resetBlog(${blog.id},0);" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 转存草稿</button>
                    </c:when> 
                    <c:otherwise>
                       <button onclick="resetBlog(${blog.id},1);" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 发布</button>
                    </c:otherwise> 
                    </c:choose>
                  </div>
                </div>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
		<div id="kkpager"></div>
		<input type="hidden" id="page" name="page">
		<hr />
        <p>注：.....</p>
      </div>
    </div>
    </form>
  </div>
  <!-- content end -->
</div>
<footer>
   <jsp:include page="${contextPath}/WEB-INF/content/admin/common/footer.jsp"/> 
</footer>
<script type="text/javascript">
$("#categoryId").val("${blog.categoryId}");
$("#visible").val("${blog.visible}");
$(function(){
	kkpager.generPageHtml({
		//当前页
		pno : "${blogPage.pageNumber}",
		//总页码
		total : "${blogPage.totalPage}",
		//总数据条数
		totalRecords : "${blogPage.totalRow}",
		isGoPage : false,
		mode : 'click',//默认值是link，可选link或者click
		click : function(n){
			this.selectPage(n);
			$("#page").val(n);
			$("#queryForm").submit();
		}
	});
});

function search(){
	var loader = layer.load();
	$("#queryForm").submit();
}

function resetBlog(id,visible){
	var loader = layer.load();
	$.ajax({
        type: "GET",
        url: "${base}/admin/resetBlog/"+id+"-"+visible,
        async: false,
        error: function(data) {
        	layer.close(loader);
			layer.msg('请求出错了。。。',{icon:3});
        },
        success: function(data) {
        	layer.close(loader);
        	if(data.statusCode == "success"){
    			layer.msg('欧啦！', {icon:1}, function(){
  					$("#queryForm").submit();
  				});   
        	}else{
    			layer.msg('哦？出现问题了。。。',{icon:5});   
        	}  
        }
    });
}

</script>
</body>
</html>