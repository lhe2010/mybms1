<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>
	<h3>상품조회</h3>
	<!-- 검색 조건을 위한 테이블  -->
	<div class="clear"></div>
	<table class="list_view">
		<tbody align="center">
			<tr style="background:#8e00ff; color:#fff; height: 50px;" >
				<td>상품번호</td>
				<td>상품이름</td>
				<td>저자</td>
				<td>출판사</td>
				<td>상품가격</td>
				<td>입고일자</td>
				<td>출판일</td>
			</tr>
			<c:choose>
				<c:when test="${empty newGoodsList }">
					<tr>
						<td colspan="8" class="fixed"><strong>조회된 상품이 없습니다. </strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${newGoodsList }">
						<tr>
							<td><strong>${item.goods_id }</strong></td>
							<td><a href="${pageContext.request.contextPath }/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}"><strong>${item.goods_title }</strong></a></td>
							<td><strong>${item.goods_writer }</strong></td>
							<td><strong>${item.goods_publisher }</strong></td>
							<td><strong>${item.goods_sales_price }</strong></td>
							<td><strong>${item.goods_credate }</strong></td>
							<td>
								<c:set var="pub_date" value="${item.goods_published_date }"/>
								<c:set var="arr" value="${fn:split(pub_date,' ')}"/>
								<strong><c:out value="${arr[0] }"/></strong>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<!-- 페이징 -->
			<tr></tr>
		</tbody>
	</table>
	<!-- 상품등록 버튼 -->
	<br>
	<div align="right">
		<input type="button" value="상품 등록" onclick="location.href='${contextPath}/admin/goods/addNewGoodsForm.do'" class="btn btn-indigo btn-sm">
	</div>
</body>
</html>