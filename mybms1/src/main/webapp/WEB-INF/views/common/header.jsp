<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="logo">
		<a href="${contextPath }/main/main.do"> 
			<img width="176" height="80" alt="mybms1_logo" src="${contextPath }/resources/image/bms_logo2.png">
		</a>
	</div>
	<div id="head_link">
		<ul>
			<c:choose>
				<c:when test="${isLogOn eq true and not empty memberInfo}">
					<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					<li><a href="">마이페이지</a></li>
					<li><a href="">장바구니</a></li>
					<li><a href="">주문배송</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
					<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
				</c:otherwise>
			</c:choose>
					<li><a href="">고객센터</a></li>
					<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
			<c:if test="${isLogOn eq true and memberInfo.member_id eq 'admin' }">
					<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
			</c:if>
		</ul>
	</div>
	<br>
	<div id="search">
		<form name="frmSearch" action="${contextPath }/goods/searchGoods.do">
			<input type="text" name="searchWord" class="">
			<input type="submit" name="search" value="검   색">
		</form>
	</div>
	<div id="suggest">
		<div id="suggestList"></div>
	</div>
</body>
</html>