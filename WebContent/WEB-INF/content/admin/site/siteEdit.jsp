<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">网站基本信息</strong>
				 / <small><fmt:formatDate value="${site.logtime}" pattern="yyyy-MM-dd HH:mm"/></small>
			</div>
		</div>

		<form id="siteForm" class="am-form">
			<input type="hidden" name="site.id" value="${site.id}" />
			<div class="am-g">
			<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
				<div class="am-panel am-panel-default">
					<div class="am-panel-bd">
						<div class="am-g">
							<div class="am-u-md-4">
								<img id="imgLogoShow" class="am-img-circle am-img-thumbnail" src="${site.logo}" alt="" />
							</div>
							<div class="am-u-md-8">
								<p>网站logo</p>
								<div class="am-form-group">
									<input type="hidden" id="logo" name="site.logo" value="${site.logo}" />
									<div id="btnLogoUpload" class="am-btn am-btn-primary am-btn-xs btn btnUpload">上传图片</div>
									<p class="am-form-help">请选择要上传的文件...</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="am-panel am-panel-default">
					<div class="am-panel-bd">
						<div class="am-g">
							<div class="am-u-md-4">
								<img id="imgBannerShow" class="am-img-circle am-img-thumbnail" src="${site.banner}" alt="" />
							</div>
							<div class="am-u-md-8">
								<p>Banner图片，美美哒</p>
								<div class="am-form-group">
									<input type="hidden" id="banner" name="site.banner" value="${site.banner}" />
									<div id="btnBannerUpload" class="am-btn am-btn-primary am-btn-xs btn btnUpload">上传图片</div>
									<p class="am-form-help">请选择要上传的文件...</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">网站名称</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="site.name" value="${site.name}"
							class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>
				
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">版权描述</div>
					<div class="am-u-sm-8 am-u-md-6 am-u-end col-end">
						<input type="text" name="site.copyright" value="${site.copyright}" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>

				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">备案号</div>
					<div class="am-u-sm-8 am-u-md-6">
						<input type="text" name="site.license" value="${site.license}" class="am-input-sm">
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>
				
			    <div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">banner-标题</div>
					<div class="am-u-sm-8 am-u-md-6">
					    <textarea rows="2" name="site.bannerTitle">${site.bannerTitle}</textarea>
					</div>
					<div class="am-hide-sm-only am-u-md-4">选填</div>
				</div>
				
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">banner-内容</div>
					<div class="am-u-sm-8 am-u-md-6">
					    <textarea rows="2" name="site.bannerContent">${site.bannerContent}</textarea>
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>
				
				<div class="am-g am-margin-top">
					<div class="am-u-sm-4 am-u-md-2 am-text-right">网站描述</div>
					<div class="am-u-sm-8 am-u-md-6">
						<textarea rows="2" name="site.content">${site.content}</textarea>
					</div>
					<div class="am-hide-sm-only am-u-md-4">*必填</div>
				</div>

				<div class="am-g am-margin-top">
				<div class="am-u-sm-10 am-u-sm-push-2">
					<button type="button" onclick="saveSite();" class="am-btn am-btn-primary am-btn-xs">保存修改</button>
				</div>
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

<script type="text/javascript" charset="utf-8" src="${base}/webuploader/js/webuploader.js"></script>
<script type="text/javascript">
    var logoUploader;
    var bannerUploader;
    
	function saveSite() {
		var loader = layer.load();
		$.ajax({
			type : "POST",
			url : "${base}/admin/saveSite",
			data : $('#siteForm').serialize(),// 你的formid
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
						window.location.href = "${base}/admin/goEditSite";
					});
				} else {
					layer.msg('保存出现问题了。。。', {
						icon : 5
					});
				}
			}
		});
	}
	
	function initLogoUploader(){
	    if (!logoUploader) {
	    	logoUploader = WebUploader.create({
	  	    // swf文件路径
	  	    swf: '${base}/webuploader/Uploader.swf',
	  	  	duplicate :true,
	  	    auto: true,
	  	    // 文件接收服务端。
	  	    server: '${base}/admin/uploadPicture',
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#btnLogoUpload',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	});
	  	    
	  	logoUploader.on('uploadAccept', function(obj,response) {
  	   	   var statusCode = response.statusCode;
  	   	   if(statusCode != "error"){
  	   		   var ImageSrc = "${base}/upload/"+statusCode;
  	  	       $("#logo").val(ImageSrc);
  	  	       $("#imgLogoShow").attr("src",ImageSrc);
  	   	   }else{
  				layer.msg('对不起主人。。。图片没有上传成功', {
  				  icon: 5,
  				  time: 2000 //2秒关闭（如果不配置，默认是3秒）
  				}); 
  	   	   }
	  	});
	   }
	}
	
	function initBannerUploader(){
	    if (!bannerUploader) {
	    	bannerUploader = WebUploader.create({
	  	    // swf文件路径
	  	    swf: '${base}/webuploader/Uploader.swf',
	  	  	duplicate :true,
	  	    auto: true,
	  	    // 文件接收服务端。
	  	    server: '${base}/admin/uploadPicture',
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#btnBannerUpload',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	});
	  	    
	  	bannerUploader.on('uploadAccept', function(obj,response) {
  	   	   var statusCode = response.statusCode;
  	   	   if(statusCode != "error"){
  	   		   var ImageSrc = "${base}/upload/"+statusCode;
  	  	       $("#banner").val(ImageSrc);
  	  	       $("#imgBannerShow").attr("src",ImageSrc);
  	   	   }else{
  				layer.msg('对不起主人。。。图片没有上传成功', {
  				  icon: 5,
  				  time: 2000 //2秒关闭（如果不配置，默认是3秒）
  				}); 
  	   	   }
	  	});
	   }
	}
	
	initLogoUploader();
	
	initBannerUploader();
</script>
</body>
</html>