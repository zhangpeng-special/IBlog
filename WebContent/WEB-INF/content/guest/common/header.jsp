<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header>
  <h1>${site.name}</h1>
  <h2>${site.content}</h2>
  <div class="logo"><a href="${base}"></a></div>
  <nav id="topnav">
  <a href="${base}" <c:if test="${not empty currentCategory}">style="background-color: rgba(51, 51, 51, 1) !important;"</c:if>>首页</a>
     <c:forEach items="${categoryList}" var="category" varStatus="status">
		<c:choose>
			<c:when test="${category.url eq 'category'}">
				<a href="${base}/${category.url}/${category.id}-1" 
				<c:if test="${currentCategory.id == category.id}">id="topnav_current"</c:if>>${category.name}</a>
			</c:when>
			<c:otherwise>
				<a href="${base}/${category.url}/${category.id}"
				<c:if test="${currentCategory.id == category.id}">id="topnav_current"</c:if>>${category.name}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
  </nav>
</header>