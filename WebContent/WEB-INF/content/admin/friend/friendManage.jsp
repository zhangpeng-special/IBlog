<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">友链管理</strong> / <small>笑一笑，十年少</small></div>
    </div>
    <form class="am-form">
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <a href="${base}/admin/goAddFriend" type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span>添加友链</a>
          </div>
        </div>
      </div>
    </div>
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-9">
      </div>
      <div class="am-u-sm-12 am-u-md-3">
        <div class="am-form-group">
          <select id="visible" onchange="reflesh();" data-am-selected="{btnSize: 'sm'}">
             <option value="1">显示中</option>
             <option value="0">隐藏中</option>
          </select>
        </div>
      </div>
    </div>
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
          <tbody>
          <c:forEach items="${friendList}" var="friend" varStatus="status">
            <tr>
              <td>${status.count}</td>
              <td>${friend.name}</td>
              <td>${friend.url}</td>
              <td>
                <div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                    <a href="${base}/admin/goEditFriend/${friend.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 编辑</a>
                    <button onclick="deleteFriend(${friend.id});" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
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

$("#visible").val("${visible}");

function deleteFriend(id){
	var loader = layer.load();
	$.ajax({
        type: "GET",
        url: "${base}/admin/deleteFriend/"+id,
        async: false,
        error: function(data) {
        	layer.close(loader);
			layer.msg('请求出错了。。。',{icon:3});
        },
        success: function(data) {
        	layer.close(loader);
        	if(data.statusCode == "success"){
    			layer.msg('欧啦！', {icon:1}, function(){
    				var visible = $("#visible").val();
    				window.location.href="${base}/admin/findMyFriends/"+visible;
  				});   
        	}else{
    			layer.msg('哦？出现问题了。。。',{icon:5});   
        	}  
        }
    });
}
function reflesh(){
	var visible = $("#visible").val();
	window.location.href="${base}/admin/findMyFriends/"+visible;
}
</script>
</body>
</html>