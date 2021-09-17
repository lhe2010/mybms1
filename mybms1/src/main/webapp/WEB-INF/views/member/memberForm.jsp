<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$().ready(function() {
	$("#select_email").change(function(){
		$("#email2").val($("#select_email option:selected").val());
	});
	
	$("#btnOverlapped").click(function(){
	    var member_id = $("#member_id").val();
	    if (member_id==''){
	   	 alert("ID를 입력하세요");
	   	 return;
	    }
	   
	    $.ajax({
	       type:"post",
	       async:false,  
	       url:"${contextPath}/member/overlapped.do",
	       dataType:"text",
	       data: {id:member_id},
	       success:function (data,textStatus){
	          if (data == 'false'){
	          	alert("사용할 수 있는 ID입니다.");
	          } else {
	          	alert("사용할 수 없는 ID입니다.");
	          }
	       },
	       error:function(data,textStatus){
	          alert("적절하지 않은 값을 입력하였습니다. 다시 시도해주십시요.");
	          history.go(-1);
	       },
	    });
	 });	
});
</script>
<script>
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if (data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if (extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	            if (fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('roadAddress').value = fullRoadAddr;
	            document.getElementById('jibunAddress').value = data.jibunAddress;
	
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if (data.autoRoadAddress) {
	                //예상되는 도로명 주소에 조합형 주소를 추가한다.
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	
	            } 
	            else if (data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	
	            } 
	            else {
	                document.getElementById('guide').innerHTML = '';
	            }
	        }
	    }).open();
	}
</script>
</head>
<body>
	<form action="${contextPath }/member/addMember.do" method="post">
		<h3>회원가입</h3>
		<table class="table table-bordered table-hover">
			<colgroup>
				<col width="20%" >
				<col width="80%">
			</colgroup>
			<tr>
				<td align="center">아이디</td>
				<td>
					<input type="text" id="member_id" name="member_id" class="form-control" style="display:inline; width:300px;" maxlength="15" placeholder="아이디를 입력하세요." />
					&emsp;<input type="button" id="btnOverlapped" class="btn btn-primary btn-sm" value="중복확인" />
				</td>
			</tr>
			<tr>
				<td align="center">비밀번호</td>
				<td>
					<input type="password" id="member_pw" name="member_pw" class="form-control" style="display:inline; width:300px;" placeholder="비밀번호를 입력하세요." />
				</td>
			</tr>	 
			<tr>
				<td align="center">비밀번호 확인</td>
				<td>
					<input type="password" id="member_pw_confirm" name="member_pw_confirm" class="form-control" style="display:inline; width:300px;" placeholder="비밀번호를 다시 한번 입력하세요." />
				</td>
			</tr>	 
			<tr>
				<td align="center">이름</td>
				<td><input type="text" class="form-control" id="member_name" name="member_name" maxlength="15" placeholder="이름을 입력하세요." style="display:inline; width:300px;"/></td>
			</tr>
			<tr>
				<td align="center">성별</td>
				<td align="center">
					<input type="radio" id="g1" name="member_gender" value="101" class="custom-control-input" checked/>&emsp;남성&emsp;&emsp;&emsp;
					<input type="radio" id="g2" name="member_gender" value="102" class="custom-control-input"/>&emsp;여성 
				</td>
			</tr>
			<tr>
				<td align="center">생년월일</td>
				<td align="center">
					<select id="member_birth_y" name="member_birth_y" class="form-control" style="display:inline; width:70px; padding:0;">
						<c:forEach var="year" begin="1" end="100">
							<c:choose>
								<c:when test="${year == 80 }">
									<option value="${1931+year }" selected>${1931+year }</option>
								</c:when>
								<c:otherwise>
									<option value="${1931+year }" >${1931+year }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 년
					<select id="member_birth_m" name="member_birth_m" class="form-control" style="display:inline; width:50px; padding:0;">
						<c:forEach var="month" begin="1" end="12">
							<c:choose>
								<c:when test="${month == 5}">
									<option value="${month }" selected>${month }</option>
								</c:when>
								<c:otherwise>
									<option value="${month }">${month }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 월
					<select id="member_birth_d" name="member_birth_d" class="form-control" style="display:inline; width:50px; padding:0;">
						<c:forEach var="day" begin="1" end="31">
							<c:choose>
								<c:when test="${day == 1}">
									<option value="${day }" selected>${day }</option>
								</c:when>
								<c:otherwise>
									<option value="${day }">${day }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 일&emsp;
					<div class="custom-control custom-radio" style="display:inline;">
						<input class="custom-control-input" type="radio" id="member_birth_gn2" name="member_birth_gn" value="2" checked />
						<label class="custom-control-label" for="member_birth_gn2">양력</label>
					</div>  
					<div class="custom-control custom-radio" style="display:inline;">
						<input class="custom-control-input" type="radio" id="member_birth_gn1" name="member_birth_gn" value="1" />
						<label class="custom-control-label" for="member_birth_gn1">음력</label>
		            </div>  
				</td>
			</tr>
			<tr>
				<td align="center">집 전화번호</td>
				<td>
					<select id="tel1" name="tel1" class="form-control" style="display:inline; width:70px; padding:0;">
						<option>없음</option>
						<option value="02" selected>02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="044">044</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>			
					</select> - 
					<input type="text" name="tel2" size="10px" class="form-control" style="display:inline; width:100px; padding:0" > - 
					<input type="text" name="tel3" size="10px" class="form-control" style="display:inline; width:100px; padding:0" >
				</td>
			</tr>
			<tr>
				<td align="center">핸드폰 번호</td>
				<td>
					<select id="hp1" name="hp1" class="form-control" style="display:inline; width:70px; padding:0">
						<option>없음</option>
						<option value="010" selected>010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select> - 
					<input type="text" name="hp2" size="10px" class="form-control" style="display:inline; width:100px; padding:0" > - 
					<input type="text" name="hp3" size="10px" class="form-control" style="display:inline; width:100px; padding:0" ><br><br>
					<input type="checkbox" id="smssts_yn" name="smssts_yn" value="Y" checked class="custom-control-input"> <label for="smssts_yn">myBMS에서 발송하는 SMS소식을 수신합니다.</label> 
				</td>
			</tr>
			<tr>
				<td align="center">이메일</td>
				<td>
					<input type="text" id="email1" name="email1" size="10px" class="form-control" style="display:inline; width:100px; padding:0"> @
					<input type="text" id="email2" name="email2" size="10px" class="form-control" style="display:inline; width:100px; padding:0"> 
					<select id="select_email" name="email3" class="form-control" style="display:inline; width:100px; padding:0">
						 <option value="none">직접입력</option>
						 <option value="gmail.com" selected>gmail.com</option>
						 <option value="naver.com">naver.com</option>
						 <option value="daum.net">daum.net</option>
						 <option value="nate.com">nate.com</option>
					</select><br><br>
					<input type="checkbox" id="emailsts_yn" name="emailsts_yn" value="Y" checked class="custom-control-input"> <label for="emailsts_yn">myBMS에서 발송하는 E-mail 소식을 수신합니다.</label> 
				</td>
			</tr>
			<tr>
				<td align="center">주소</td>
				<td>
					<input type="text" id="zipcode" name="zipcode" size="70px" placeholder="우편번호 입력" class="form-control" style="display:inline;width:150px;padding:0">
					<input type="button" value="검색" class="btn btn-outline-primary btn-sm" onclick="javascript:execDaumPostcode()">
					<br>도로명주소 : 
					<input type="text" id="roadAddress" name="roadAddress" class="form-control">
					<br>지번주소 : 
					<input type="text" id="jibunAddress" name="jibunAddress" class="form-control">
					<br>나머지 주소 : 
					<input tyoe="text" name="namujiAddress" class="form-control">			
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="회원가입하기" class="btn btn-primary btn-block" >
				</td>
			</tr>
			<tr>
		        <td colspan="2" align="center">
		        	이미 회원가입이 되어있다면 ? <a href="${contextPath}/member/loginForm.do"><strong>로그인하기</strong></a>
		        </td>
	        </tr>  
		</table>
	</form>
		
</body>
</html>