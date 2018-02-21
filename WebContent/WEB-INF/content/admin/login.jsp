<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath() + "/";
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
  <base href="<%=path%>">
  <meta charset="UTF-8">
  <title>IBlog</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="format-detection" content="telephone=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="alternate icon" type="image/png" href="assets/i/favicon.png">
  <link rel="stylesheet" href="assets/css/amazeui.min.css"/>
  <style>
    .header {
      text-align: center;
    }
    .header h1 {
      font-size: 200%;
      color: #333;
      margin-top: 30px;
    }
    .header p {
      font-size: 14px;
    }
  </style>
  <!--[if lt IE 9]>
  <script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
  <![endif]-->

  <!--[if (gte IE 9)|!(IE)]><!-->
  <script src="assets/js/jquery.min.js"></script>
  <!--<![endif]-->
  <script src="layer/layer.js"></script>
</head>
<body>
<div class="header">
  <div class="am-g">
    <h1>IBlog</h1>
    <p>后台登录</p>
  </div>
  <hr />
</div>
<div class="am-g">
  <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
    <form method="post" action="admin/login" class="am-form">
      <label>账号:</label>
      <input type="text" name="username" value="${username}" />
      <br>
      <label for="password">密码:</label>
      <input type="password" name="password" value="${password}" />
      <br>
      <div class="am-cf">
        <input type="submit" value="登 录" class="am-btn am-btn-primary am-btn-sm am-fl" />
      </div>
    </form>
    <hr>
    <p>© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
  </div>
</div>
<script type="text/javascript">
    var message = "${message}";
    if(message){
    	layer.msg(message, {
  		  icon: 5,
  		  time: 2000 //2秒关闭（如果不配置，默认是3秒）
  		});
    }
</script>
</body>
</html>
