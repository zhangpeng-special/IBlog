<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath() + "/";
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
%>
<head>
<base href="<%=path%>">
<meta charset="utf-8">
<title>${title}</title>
<meta name="keywords" content="${keywords}" />
<meta name="description" content="${description}" />
<link href="css/base.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/media.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->

<script src="laypage/laypage.js"></script>
<style type="text/css">
.logo { background: url('${site.logo}') no-repeat #000 center; width: 145px; height: 145px; border-radius: 50%; position: absolute; left: -72px; top: 40px; box-shadow: 0px 2px 2px #414141; }
.avatar a { display: block; padding-top: 100px; width: 160px; background: url('${information.photo}') no-repeat; background-size: 160px 160px; }
.banner { background: url('${site.banner}') no-repeat center; height: 290px; margin: 10px auto; width: 100%; font-size: 16px; font-family: "Microsoft Yahei", Arial, Helvetica, sans-serif; }
</style>
</head>
