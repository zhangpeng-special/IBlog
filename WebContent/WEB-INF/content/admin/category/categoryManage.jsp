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
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">导航分类管理</strong> / <small>笑一笑，十年少</small></div>
    </div>
    <form class="am-form">
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <a href="${base}/admin/goAddCategory" type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span>添加分类</a>
          </div>
        </div>
      </div>
    </div>

    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
          <tbody>
          <c:forEach items="${categoryList}" var="category" varStatus="status">
            <tr>
              <td>${status.count}</td>
              <td>${category.name}</td>
              <td>${category.url}</td>
              <td>${category.render}</td>
              <td class="am-hide-sm-only"><fmt:formatDate value="${category.logtime}" pattern="yyyy-MM-dd HH:mm"/></td>
              <td>
                <div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                    <a href="${base}/admin/goEditCategory/${category.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 编辑</a>
                    <button onclick="deleteCategory(${category.id});" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                  </div>
                </div>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
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
function deleteCategory(id){
	var loader = layer.load();
	$.ajax({
        type: "GET",
        url: "${base}/admin/deleteCategory/"+id,
        async: false,
        error: function(data) {
        	layer.close(loader);
			layer.msg('请求出错了。。。',{icon:3});
        },
        success: function(data) {
        	layer.close(loader);
        	if(data.statusCode == "success"){
    			layer.msg('欧啦！', {icon:1}, function(){
    				window.location.href="${base}/admin/findMyCategorys";
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