<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div id="sticky">
		<ul>
			<li><a href="#"><img width="20" height="24" src="${contextPath}/resources/image/facebook_icon.png" alt="Facebook"><strong>Facebook</strong></a></li>
			<li><a href="#"><img width="20" height="24" src="${contextPath}/resources/image/twitter_icon.png" alt="Twitter"><strong>Twitter</strong></a></li>
			<li><a href="#"><img width="20" height="24" src="${contextPath}/resources/image/instagram_icon.png" alt="Instagram"><strong>Instagram</strong></a></li>
		</ul>
		<div class="recent">
			<h3>최근 본 상품</h3>
			<ul>
			
			</ul>
		</div>
		<div>
			<!-- 최근조회상품 페이징+버튼 -->
		</div>
	</div>

</body>
</html>