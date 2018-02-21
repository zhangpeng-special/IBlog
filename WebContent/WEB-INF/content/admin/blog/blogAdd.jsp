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
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">编辑文章</strong> / <small>笑一笑，十年少</small></div>
    </div>
    
  <form id="blogForm" class="am-form">
  
  <div class="am-tabs am-margin" data-am-tabs>
  
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li class="am-active"><a href="#tab1">基本信息</a></li>
      <li><a href="#tab2">文章内容</a></li>
    </ul>
    
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade am-in am-active" id="tab1">
      <div class="am-g">
      <div class="am-u-sm-12 am-u-md-8">
        <div class="am-g am-margin-top">
          <div class="am-u-sm-4 am-u-md-2 am-text-right">所属类别</div>
          <div class="am-u-sm-8 am-u-md-10">
          <select id="categoryId" name="blog.categoryId" data-am-selected="{btnSize: 'sm'}">
            <c:forEach items="${categoryList}" var="category">
               <option value="${category.id}">${category.name}</option>
            </c:forEach>
          </select>
          </div>
        </div>

        <div class="am-g am-margin-top">
          <div class="am-u-sm-4 am-u-md-2 am-text-right">显示状态</div>
          <div class="am-u-sm-8 am-u-md-10">
          <select id="visible" name="blog.visible" data-am-selected="{btnSize: 'sm'}">
             <option value="1">立即发布</option>
             <option value="0">存为草稿</option>
          </select>
          </div>
        </div>
        
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                      文章标题
            </div>
            <div class="am-u-sm-8 am-u-md-6">
              <input type="text" name="blog.title" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-4">*必填，不可重复</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                     文章作者
            </div>
            <div class="am-u-sm-8 am-u-md-6 am-u-end col-end">
              <input type="text" name="blog.sourceName" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-4">*必填</div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                      文章标签
            </div>
            <div class="am-u-sm-8 am-u-md-6">
              <input type="text" name="blog.tags" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-4">选填</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                    信息来源
            </div>
            <div class="am-u-sm-8 am-u-md-6">
              <input type="text" name="blog.sourceURL" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-4">选填</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                    内容摘要
            </div>
            <div class="am-u-sm-8 am-u-md-6">
              <textarea rows="4" name="blog.statement"></textarea>
            </div>
            <div class="am-hide-sm-only am-u-md-4">*必填，限255字以内</div>
          </div>
        </div>
        <div class="am-u-sm-12 am-u-md-4">
        <div class="am-panel am-panel-default">
          <div class="am-panel-bd">
            <div class="am-g">
              <div class="am-u-md-4">
                <img id="imgShow" class="am-img-circle am-img-thumbnail" src="http://s.amazeui.org/media/i/demos/bw-2014-06-19.jpg?imageView/1/w/200/h/200/q/80" alt=""/>
              </div>
              <div class="am-u-md-8">
                <p>主人，别忘了选一张图片作为这篇文章的logo哦</p>
                  <div class="am-form-group">
                    <input type="hidden" id="titlePicture" name="blog.titlePicture" >
                    <div id="btnFileUpload" class="am-btn am-btn-primary am-btn-xs btn btnUpload">上传图片</div>
                    <p class="am-form-help">请选择要上传的文件...</p>
                  </div>
              </div>
            </div>
          </div>
        </div>
        </div>
        </div>
      </div>
      
      <div class="am-tab-panel am-fade" id="tab2">
         <div class="am-u-sm-12 am-u-sm-centered">
           <script id="editor" name="blog.content" type="text/plain" style="height:500px;"></script>
         </div>
      </div>
      
    </div>
  </div>
</form>

  <div class="am-margin">
    <button type="button" onclick="saveBlog();" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
    <a type="button" href="javascript:history.go(-1)" class="am-btn am-btn-primary am-btn-xs">返回</a>
  </div>
  
  </div>
  <!-- content end -->
  
</div>
<footer>
   <jsp:include page="${contextPath}/WEB-INF/content/admin/common/footer.jsp"/> 
</footer>

<script type="text/javascript" charset="utf-8" src="${base}/webuploader/js/webuploader.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${base}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
	var ue = UE.getEditor('editor');
	var fileUploader;
	
	function saveBlog(){
		//满足提交条件时同步内容并提交，此处ue为编辑器实例
		if(ue.hasContents()){ //此处以非空为例
			ue.sync();       //同步内容
			submitForm();   //提交Form
		}else{
			layer.msg('主人！您一个字都还没写呢。。。', {
				  icon: 6,
				  time: 2000 //2秒关闭（如果不配置，默认是3秒）
				});   
		} 
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
  	  	       $("#titlePicture").val(ImageSrc);
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
	
	function submitForm(){
		var loader = layer.load();
		$.ajax({
            type: "POST",
            url: "${base}/admin/addBlog",
            data: $('#blogForm').serialize(),// 你的formid
            async: false,
            error: function(data) {
            	layer.close(loader);
    			layer.msg('请求出错了。。。',{icon:3});
            },
            success: function(data) {
            	layer.close(loader);
            	if(data.statusCode == "success"){
        			layer.msg('保存成功啦', {
      				  icon: 1,
      				  time: 1000 //1秒关闭（如果不配置，默认是3秒）
      				}, function(){
      				  window.location.href="${base}/admin/findMyBlogs";
      				});   
            	}else{
        			layer.msg('保存出现问题了。。。',{icon:5});   
            	}  
            }
        });
	}
	
</script>
</body>
</html>