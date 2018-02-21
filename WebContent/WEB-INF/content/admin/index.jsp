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
	  欢迎来到IBlog
  </div>
  <!-- content end -->

</div>

<footer>
   <jsp:include page="${contextPath}/WEB-INF/content/admin/common/footer.jsp"/> 
</footer>
</body>
</html>