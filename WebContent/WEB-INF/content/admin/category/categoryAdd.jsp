<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">编辑分类</strong> / <small>笑一笑，十年少</small>
			</div>
		</div>

		<form id="categoryForm" class="am-form">
			<div class="am-u-sm-12 am-u-sm-centered">

				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">分类名称</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="category.name" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填，不可重复</div>
				</div>
				
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">URL</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="category.url" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>
				
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">Render</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="category.render" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>

				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">排序</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="category.sort" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">选填</div>
				</div>

				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">备注</div>
					<div class="am-u-sm-8 am-u-md-6">
						<textarea rows="3" name="category.remark"></textarea>
					</div>
					<div class="am-hide-sm-only am-u-md-4">选填</div>
				</div>

				<div class="am-g am-margin-top">
				<div class="am-u-sm-10 am-u-sm-push-2">
					<button type="button" onclick="saveCategory();" class="am-btn am-btn-primary am-btn-xs">保存</button>
					<a type="button" href="javascript:history.go(-1)" class="am-btn am-btn-primary am-btn-xs">返回</a>
				</div>
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
	function saveCategory() {
		var loader = layer.load();
		$.ajax({
			type : "POST",
			url : "${base}/admin/addCategory",
			data : $('#categoryForm').serialize(),// 你的formid
			async : false,
			error : function(data) {
				layer.close(loader);
				layer.msg('请求出错了。。。', {
					icon : 3
				});
			},
			success : function(data) {
				layer.close(loader);
				if (data.statusCode == "success") {
					layer.msg('保存成功啦', {
						icon : 1,
						time : 2000
					//2秒关闭（如果不配置，默认是3秒）
					}, function() {
						window.location.href = "${base}/admin/findMyCategorys";
					});
				} else {
					layer.msg('保存出现问题了。。。', {
						icon : 5
					});
				}
			}
		});
	}
</script>
</body>
</html>