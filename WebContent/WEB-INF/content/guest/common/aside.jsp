<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <style type="text/css">
  #ds-recent-comments ul {
  display: block;
  -webkit-margin-before: 1em;
  -webkit-margin-after: 1em;
  -webkit-margin-start: 0px;
  -webkit-margin-end: 0px;
  -webkit-padding-start: 40px;
  list-style: none;
  margin: 10px;
  }
  #ds-recent-comments li {
  display: block;
  overflow: hidden;
  margin-bottom: 12px;
  color: #cdcbcb;
  -webkit-margin-before: 1em;
  -webkit-margin-after: 1em;
  -webkit-margin-start: 0px;
  -webkit-margin-end: 0px;
  height: 50px;
  width: 190px;
  font: 12px "宋体", Arial, Helvetica, sans-serif;
  }
  #ds-recent-comments li.ds-comment {
    list-style-type: none;
    position: relative !important;
    margin: 0 !important;
    padding: 6px 0 !important;
    _zoom: 1;
    word-wrap: break-word;
    border-top: 0px;
    font-size: 12px;
  }
  #ds-recent-comments li.ds-comment.ds-show-avatars {
    padding-left: 60px !important;
  }
  #ds-recent-comments li.ds-comment .ds-time {
    color: #066;
    margin-left: 10px;
  }
  #ds-recent-comments li.ds-comment .ds-meta {
  line-height: 22px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
  }
  #ds-recent-comments li.ds-comment .ds-excerpt {
  line-height: 22px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
  color: #555454;
  }
  .ds-avatar img {
  width: 50px !important;
  height: 50px !important;
  margin-right: 10px;
  border-radius: 50%;
  transition: all 1s;
  }
  .ds-avatar img:hover {
  -webkit-transform: rotate(360deg); 
  -ms-transform: rotate(30deg); 
  -moz-transform: rotate(30deg); 
  -o-transform: rotate(30deg); 
  transform: rotate(30deg); 
  }
  </style>
  <aside>
    <div class="rnav">
      <c:forEach items="${categoryList}" var="category" varStatus="status">
			<li class="rnav${status.count}">
			    <c:choose>
					<c:when test="${category.url eq 'category'}">
						<a href="${base}/${category.url}/${category.id}-1">${category.name}</a>
					</c:when>
					<c:otherwise>
						<a href="${base}/${category.url}/${category.id}">${category.name}</a>
					</c:otherwise>
				</c:choose>
			</li>
	  </c:forEach>
    </div>
    <div class="ph_news">
      <h2>
        <p>点击排行</p>
      </h2>
      <ul class="ph_n">
      <c:forEach items="${hotBlogPage.list}" var="blog" varStatus="status">
        <li>
    	<c:choose>
			<c:when test="${status.count <= 3}">
				<span class="num${status.count}">${status.count}</span>
				<a href="article/${blog.id}">${blog.title}</a>
			</c:when>
			<c:otherwise>
				<span>${status.count}</span>
				<a href="article/${blog.id}">${blog.title}</a>
			</c:otherwise>
		</c:choose>
		</li>
      </c:forEach>
      </ul>
      <h2>
        <p>栏目推荐</p>
      </h2>
      <ul>
        <c:forEach items="${newBlogPage.list}" var="blog" varStatus="status">
          <li><a href="article/${blog.id}">${blog.title}</a></li>
        </c:forEach>
      </ul>
      <h2>
        <p>最新评论</p>
      </h2>
      <!-- 多说最新评论 start -->
	  <ul class="ds-recent-comments" data-num-items="5" data-show-avatars="1" data-show-time="1" data-show-title="0" data-show-admin="0" data-excerpt-length="15">
	  </ul>
      <!-- 多说最新评论 end -->
    </div>
    <div class="copyright">
      <ul>
        <p> Designed by <a href="/">${site.copyright}</a></p>
        <p>${site.license}</p>
        </p>
      </ul>
    </div>
  </aside>
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 -->