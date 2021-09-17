<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
	<script>
		window.onload=function() {
			alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
		}
	</script>
</c:if>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />

</head>
<body>
	<h1>Login to myBMS1</h1>
	<br>
	<form action="${contextPath}/member/login.do" method="post">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tr>
				<td align="center"><label for="member_id" >아이디</label></td>
				<td><input type="text" id="member_id" name="member_id" class="form-control" placeholder="아이디를 입력해주세요."></td>
			</tr>
			<tr>
				<td align="center"><label for="member_pw" >비밀번호</label></td>
				<td><input type="password" id="member_pw" name="member_pw" class="form-control" placeholder="비밀번호를 입력해주세요."></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="로그인" class="btn btn-primary btn-sm"></td>
			</tr>
		</table>
	</form>
	<p align="center">
		<img src="${contextPath }/resources/image/bms_logo1.png" width="300">
	</p>

</body>
</html>