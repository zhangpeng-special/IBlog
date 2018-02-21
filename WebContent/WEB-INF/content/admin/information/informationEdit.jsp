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
				<strong class="am-text-primary am-text-lg">个人信息</strong>
				 / <small>笑一笑，十年少</small>
			</div>
		</div>
		    
		<hr/>

        <div class="am-g">

		<form id="informationForm" class="am-form">
			<input type="hidden" name="information.id" value="${information.id}" />
			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
					<div class="am-panel am-panel-default">
						<div class="am-panel-bd">
							<div class="am-g">
								<div class="am-u-md-4">
									<img id="imgShow" class="am-img-circle am-img-thumbnail" src="${information.photo}" alt="" />
								</div>
								<div class="am-u-md-8">
									<p>主人，别忘了选一张图片展现一下自己哦</p>
									<div class="am-form-group">
										<input type="hidden" id="photo" name="information.photo" value="${information.photo}" />
										<div id="btnFileUpload" class="am-btn am-btn-primary am-btn-xs btn btnUpload">上传图片</div>
										<p class="am-form-help">请选择要上传的文件...</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">名称</div>
						<div class="am-u-sm-8 am-u-md-6 am-u-end col-end">
							<input type="text" name="information.name" value="${information.name}" class="am-input-sm">
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">职业</div>
						<div class="am-u-sm-8 am-u-md-6">
							<input type="text" name="information.job" value="${information.job}" class="am-input-sm">
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">地址</div>
						<div class="am-u-sm-8 am-u-md-6">
							<input type="text" name="information.address" value="${information.address}" class="am-input-sm">
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">联系方式</div>
						<div class="am-u-sm-8 am-u-md-6">
							<input type="text" name="information.contect" value="${information.contect}" class="am-input-sm">
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">格言-标题</div>
						<div class="am-u-sm-8 am-u-md-6">
							<input type="text" name="information.title" value="${information.title}" class="am-input-sm">
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-4 am-u-md-2 am-text-right">格言-描述</div>
						<div class="am-u-sm-8 am-u-md-6">
							<textarea class="" rows="4" name="information.content">${information.content}</textarea>
						</div>
						<div class="am-hide-sm-only am-u-md-4">*必填，255字以内</div>
					</div>
					<div class="am-g am-margin-top">
						<div class="am-u-sm-10 am-u-sm-push-2">
							<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveInformation();">保存修改</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
	<!-- content end -->
</div>

<footer>
   <jsp:include page="${contextPath}/WEB-INF/content/admin/common/footer.jsp"/> 
</footer>

<script type="text/javascript" charset="utf-8" src="${base}/webuploader/js/webuploader.js"></script>
<script type="text/javascript">
    var fileUploader;
    
	function saveInformation() {
		var loader = layer.load();
		$.ajax({
			type : "POST",
			url : "${base}/admin/saveInformation",
			data : $('#informationForm').serialize(),// 你的formid
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
						window.location.href = "${base}/admin/goEditInformation";
					});
				} else {
					layer.msg('保存出现问题了。。。', {
						icon : 5
					});
				}
			}
		});
	}
	
	function initFileUploader(){
	    if (!fileUploader) {
	  	    fileUploader = WebUploader.create({
	  	    // swf文件路径
	  	    swf: '${base}/webuploader/Uploader.swf',
	  	  	duplicate :true,
	  	    auto: true,
	  	    // 文件接收服务端。
	  	    server: '${base}/admin/uploadPicture',
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#btnFileUpload',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	});
	  	    
	  	fileUploader.on('uploadAccept', function(obj,response) {
  	   	   var statusCode = response.statusCode;
  	   	   if(statusCode != "error"){
  	   		   var ImageSrc = "${base}/upload/"+statusCode;
  	  	       $("#photo").val(ImageSrc);
  	  	       $("#imgShow").attr("src",ImageSrc);
  	   	   }else{
  				layer.msg('对不起主人。。。图片没有上传成功', {
  				  icon: 5,
  				  time: 2000 //2秒关闭（如果不配置，默认是3秒）
  				}); 
  	   	   }
	  	});
	   }
	}
	
	initFileUploader();
	
</script>
</body>
</html>