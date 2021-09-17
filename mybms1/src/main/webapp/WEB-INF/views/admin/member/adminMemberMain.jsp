<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script></script>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>

	<h3>회원조회</h3>
	<form name="frm_delivery_list">
	</form>
	
	<div class="clear"></div>
	<table class="list_view">
		<colgroup>
			<col width="15%">
			<col width="10%">
			<col width="15%">
			<col width="37%">
			<col width="13%">
			<col width="10%">
		</colgroup>
		<thead align="center">
			<tr align="center" style="background:#33ff00; color:#fff; height: 50px;">
				<td class="fixed">회원아이디</td>
				<td class="fixed">회원이름</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>가입일</td>
				<td>탈퇴여부</td>
			</tr>
		</thead>
		<tbody align="center">
			<c:choose>
				<c:when test="${empty member_list }">
					<tr>
						<td colspan="6" class="fixed">
							<strong>조회된 회원이 없습니다.</strong>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var = "member" items="${member_list }" varStatus="member_num">
						<tr>
							<td>
								<a href="${contextPath }/admin/member/memberDetail.do?member_id=${member.member_id}"><strong>${member.member_id }</strong></a>
							</td>
							<td>${member.member_name }</td>
							<td>${member.hp1 } - ${member.hp2 } - ${member.hp3 }</td>
							<td>
								${member.roadAddress }<br>${member.jibunAddress }<br>${member.namujiAddress }
							</td>
							<td><!-- joinDate -->
								<c:set var="join_date" value="${member.joinDate }"/>
								<c:set var="arr" value="${fn:split(join_date, ' ') }"/>
								<c:out value="${arr[0] }"/>
							</td>
							<td><!-- 탈퇴여부 -->
								<c:choose>
									<c:when test="${member.del_yn == 'N' }">
										<div class="badge badge-primary badge-pill">활동중</div>
									</c:when>
									<c:otherwise>
										<div class="badge badge-danger badge-pill">탈퇴</div>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<!-- paging component -->
</body>
</html>