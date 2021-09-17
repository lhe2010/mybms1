<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="resources/jquery/jquery-3.5.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="${contextPath}/resources/css/myStyle.css" rel="stylesheet" />
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
<script>
	function fn_modify_member_info(member_id, mod_type){
		var value;
		var frm_mod_member = document.frm_mod_member;
		
		if(mod_type == 'member_pw'){
			value = frm_mod_member.member_pw.value;
		} else if(mod_type == 'member_name'){
			value = frm_mod_member.member_name.value;
		} else if (mod_type == 'member_gender'){
			var member_gender = frm_mod_member.member_gender;
			for (var i = 0; member_gender.length; i++){
				if(member_gender[i].checked){
					value = member_gender[i].value;
					break;
				}
			}
		} else if (mod_type == 'member_birth'){
			var member_birth_y = frm_mod_member.member_birth_y;
			var member_birth_m = frm_mod_member.member_birth_m;
			var member_birth_d = frm_mod_member.member_birth_d;
			var member_birth_gn = frm_mod_member.member_birth_gn;
			
			for(var i =0; member_birth_y.length;i++){
				if(member_birth_y[i].selected){
					value_y = member_birth_y[i].value;
					break;
				}
			}
			for(var i =0; member_birth_m.length;i++){
				if(member_birth_m[i].selected){
					value_m = member_birth_m[i].value;
					break;
				}
			}
			for(var i =0; member_birth_d.length;i++){
				if(member_birth_d[i].selected){
					value_d = member_birth_d[i].value;
					break;
				}
			}
			for(var i =0; member_birth_gn.length;i++){
				if(member_birth_gn[i].checked){
					value_gn = member_birth_gn[i].value;
					break;
				}
			}
			value =+ value_y +","+ value_m +","+ value_d +","+ value_gn;
		} else if(mod_type == 'tel'){
			var tel1 = frm_mod_member.tel1;
			var tel2 = frm_mod_member.tel2;
			var tel3 = frm_mod_member.tel3;
			
			for(var i = 0; tel1.length; i++){
				if(tel1[i].selected){
					value_tel1 = tel1[i].value;
					break;
				}
			}
			value_tel2 = tel2.value;
			value_tel3 = tel3.value;
			
			value = value_tel1+","+value_tel2+","+value_tel3;
		} else if(mod_type == 'hp'){
			var hp1 = frm_mod_member.hp1;
			var hp2 = frm_mod_member.hp2;
			var hp3 = frm_mod_member.hp3;
			var smssts_yn = frm_mod_member.smssts_yn;
			
			for(var i = 0; hp1.length; i++){
				if(hp1[i].selected){
					value_hp1 = hp1[i].value;
					break;
				}
			}
			value_hp2 = hp2.value;
			value_hp3 = hp3.value;
			
			if(smssts_yn.checked) 
				value_smssts_yn = 'Y';
			else
				value_smssts_yn = 'N';
			
			value = value_hp1+","+value_hp2+","+value_hp3+","+value_smssts_yn;
		} else if(mod_type == 'email'){
			var email1 = frm_mod_member.email1;
			var email2 = frm_mod_member.email2;
			var email3 = frm_mod_member.email3;
			var emailsts_yn = frm_mod_member.emailsts_yn;
			
			value_email1 = email1.value;
			for(var i = 0; i < email3.length; i++){
				if(email3[i].selected){
					value_email2 = email3.value;
					break;
				}
			}
			
			if(emailsts_yn.checked) 
				value_emailsts_yn = 'Y';
			else
				value_emailsts_yn = 'N';
			
			value = value_email1+","+value_email2+","+value_emailsts_yn;
		} else if (mod_type == 'address'){
			var zipcode = frm_mod_member.zipcode;
			var roadAddress = frm_mod_member.roadAddress;
			var jibunAddress = frm_mod_member.jibunAddress;
			var namujiAddress = frm_mod_member.namujiAddress;
			
			value_zipcode = zipcode.value;
			value_roadAddress = roadAddress.value;
			value_jibunAddress = jibunAddress.value;
			value_namujiAddress = namujiAddress.value;
			
			value = value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
		}
		
 		/* alert('member_id:'+ member_id + '\nmod_type='+mod_type+'\nvalue='+value); */ 
		$.ajax({
			type: "post",
			url: "${contextPath}/admin/member/modifyMemberInfo.do",
			data: {
				member_id : member_id,
				mod_type : mod_type,
				value : value
			},
			success: function(data, textStatus){
				if(data.trim() == 'mod_success'){
					alert("회원정보를 수정했습니다.");
				} else if(data.trim() == 'failed'){
					alert("다시시도해 주세요.");
				}
			},
			error: function(data, textStatus){
				alert("에러가 발생했습니다. \n" + data);
			}
		});			
	}
</script>
<script>
	function fn_delete_member(member_id, del_yn){
		/* var frm_mod_member = document.frm_mod_member;
		
		var i_member_id = documemt.createElement("input");
		var i_del_yn = document.createElement("input");
		
		i_member_id.type = "hidden";
		i_del_yn.type = "hidden";
		i_member_id.name = "member_id";
		i_del_yn.name = "del_yn";
		i_member_id.value = member_id;
		i_del_yn.value = del_yn;
		
		frm_mod_member.appendChild(i_member_id);
		frm_mod_member.appendChild(i_del_yn);
		frm_mod_member.method="post";
		frm_mod_member.action = "${contextPath}/admin/member/deleteMember.do";
		frm_mod_member.submit(); */
		$.ajax({
			type: "post",
			url: "${contextPath}/admin/member/deleteMember.do",
			data: {
				member_id : member_id,
				del_yn : del_yn
			},
			success: function(data, textStatus){
				if(del_yn == 'Y')
					alert("회원탈퇴 완료.");
				else
					alert("회원복원 완료.");
				location.href="${contextPath}/admin/member/adminMemberMain.do";

				/* if(data.trim() == 'mod_success'){
					if(del_yn == 'Y')
						alert("회원탈퇴 완료.");
					else
						alert("회원복원 완료.");
				} else if(data.trim() == 'failed'){
					alert("다시시도해 주세요.");
				}
				location.href="redirect:/admin/member/adminMemberMain.do"; */
			},
			error: function(data, textStatus){
				alert("에러가 발생했습니다. \n" + data);
			}
		});		
	}
</script>
</head>
<body>
	<h3>회원 상세 정보</h3>
	<form name="frm_mod_member" >
		<table class="table table-bordered table-hover">
			<colgroup>
				<col width="20%" >
				<col width="80%">
			</colgroup>
			<tr>
				<td align="center">아이디</td>
				<td>
					<input type="text" id="member_id" name="member_id" class="form-control" style="display:inline; width:300px;" value="${member_info.member_id }" disabled/>
				</td>
			</tr>
			<tr>
				<td align="center">비밀번호</td>
				<td>
					<input type="password" id="member_pw" name="member_pw" class="form-control" style="display:inline; width:300px;" value="${member_info.member_pw }" />
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','member_pw')"/></td>
			</tr>	 
			<tr>
				<td align="center">이름</td>
				<td><input type="text" class="form-control" id="member_name" name="member_name" value="${member_info.member_name }" style="display:inline; width:300px;"/></td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','member_name')"/></td>
			</tr>
			<tr>
				<td align="center">성별</td>
				<td align="center">
					<input type="radio" id="g1" name="member_gender" value="101" class="custom-control-input" <c:if test="${member_info.member_gender eq '101' }">checked</c:if>/>&emsp;남성&emsp;&emsp;&emsp;
					<input type="radio" id="g2" name="member_gender" value="102" class="custom-control-input" <c:if test="${member_info.member_gender eq '102' }">checked</c:if>/>&emsp;여성 
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','member_gender')"/></td>
			</tr>
			<tr>
				<td align="center">생년월일</td>
				<td align="center">
					<select id="member_birth_y" name="member_birth_y" class="form-control" style="display:inline; width:70px; padding:0;">
						<c:forEach var="year" begin="1" end="100">
							<c:choose>
								<c:when test="${1931+year == member_info.member_birth_y}">
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
								<c:when test="${member_info.member_birth_m == month}">
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
								<c:when test="${member_info.member_birth_d == day}">
									<option value="${day }" selected>${day }</option>
								</c:when>
								<c:otherwise>
									<option value="${day }">${day }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 일&emsp;
					<div class="custom-control custom-radio" style="display:inline;">
						<input class="custom-control-input" type="radio" id="member_birth_gn2" name="member_birth_gn" value="2" <c:if test="${member_info.member_birth_gn == '2' }">checked</c:if> />
						<label class="custom-control-label" for="member_birth_gn2">양력</label>
					</div>  
					<div class="custom-control custom-radio" style="display:inline;">
						<input class="custom-control-input" type="radio" id="member_birth_gn1" name="member_birth_gn" value="1" <c:if test="${member_info.member_birth_gn == '1' }">checked</c:if>/>
						<label class="custom-control-label" for="member_birth_gn1">음력</label>
		            </div>  
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','member_birth')"/></td>
			</tr>
			<tr>
				<td align="center">집 전화번호</td>
				<td>
					<select id="tel1" name="tel1" class="form-control" style="display:inline; width:70px; padding:0;">
						<option>없음</option>
						<option value="02"  <c:if test="${member_info.tel1 == '02' }">selected</c:if>>02</option>
						<option value="031" <c:if test="${member_info.tel1 == '031' }">selected</c:if>>031</option>
						<option value="032" <c:if test="${member_info.tel1 == '032' }">selected</c:if>>032</option>
						<option value="033" <c:if test="${member_info.tel1 == '033' }">selected</c:if>>033</option>
						<option value="041" <c:if test="${member_info.tel1 == '041' }">selected</c:if>>041</option>
						<option value="042" <c:if test="${member_info.tel1 == '042' }">selected</c:if>>042</option>
						<option value="043" <c:if test="${member_info.tel1 == '043' }">selected</c:if>>043</option>
						<option value="044" <c:if test="${member_info.tel1 == '044' }">selected</c:if>>044</option>
						<option value="051" <c:if test="${member_info.tel1 == '051' }">selected</c:if>>051</option>
						<option value="052" <c:if test="${member_info.tel1 == '052' }">selected</c:if>>052</option>
						<option value="053" <c:if test="${member_info.tel1 == '053' }">selected</c:if>>053</option>
						<option value="054" <c:if test="${member_info.tel1 == '054' }">selected</c:if>>054</option>
						<option value="055" <c:if test="${member_info.tel1 == '055' }">selected</c:if>>055</option>
						<option value="061" <c:if test="${member_info.tel1 == '061' }">selected</c:if>>061</option>
						<option value="062" <c:if test="${member_info.tel1 == '062' }">selected</c:if>>062</option>
						<option value="063" <c:if test="${member_info.tel1 == '063' }">selected</c:if>>063</option>
						<option value="064" <c:if test="${member_info.tel1 == '064' }">selected</c:if>>064</option>			
					</select> - 
					<input type="text" name="tel2" size="10px" class="form-control" style="display:inline; width:100px; padding:0" value="${member_info.tel2 }" > - 
					<input type="text" name="tel3" size="10px" class="form-control" style="display:inline; width:100px; padding:0" value="${member_info.tel2 }" >
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','tel')"/></td>
			</tr>
			<tr>
				<td align="center">핸드폰 번호</td>
				<td>
					<select id="hp1" name="hp1" class="form-control" style="display:inline; width:70px; padding:0">
						<option>없음</option>
						<option value="010" <c:if test="${member_info.hp1 == '010' }">selected</c:if>>010</option>
						<option value="011" <c:if test="${member_info.hp1 == '011' }">selected</c:if>>011</option>
						<option value="016" <c:if test="${member_info.hp1 == '016' }">selected</c:if>>016</option>
						<option value="017" <c:if test="${member_info.hp1 == '017' }">selected</c:if>>017</option>
						<option value="018" <c:if test="${member_info.hp1 == '018' }">selected</c:if>>018</option>
						<option value="019" <c:if test="${member_info.hp1 == '019' }">selected</c:if>>019</option>
					</select> - 
					<input type="text" name="hp2" size="10px" class="form-control" value="${member_info.hp2 }" style="display:inline; width:100px; padding:0" > - 
					<input type="text" name="hp3" size="10px" class="form-control" value="${member_info.hp3 }" style="display:inline; width:100px; padding:0" ><br><br>
					<%-- <c:choose>
						<c:when test="${member_info.smssts_yn == 'Y' }">
							<input type="checkbox" name="smssts_yn" value="Y" class="custom-control-input" checked> <label for="smssts_yn">myBMS에서 발송하는 SMS소식을 수신합니다.</label> 
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="smssts_yn" value="N" class="custom-control-input" > <label for="smssts_yn">myBMS에서 발송하는 SMS소식을 수신합니다.</label> 
						</c:otherwise>
					</c:choose> --%>
					<input type="checkbox" id="smssts_yn" name="smssts_yn" value="Y" class="custom-control-input" <c:if test="${member_info.smssts_yn == 'Y' }">checked</c:if>> <label for="smssts_yn">myBMS에서 발송하는 SMS소식을 수신합니다.</label> 
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','hp')"/></td>
			</tr>
			<tr>
				<td align="center">이메일</td>
				<td>
					<input type="text" id="email1" name="email1" value="${member_info.email1 }" size="10px" class="form-control" style="display:inline; width:100px; padding:0"> @
					<input type="text" id="email2" name="email2" value="${member_info.email2 }" size="10px" class="form-control" style="display:inline; width:100px; padding:0"> 
					<select id="select_email" name="email3" class="form-control" style="display:inline; width:100px; padding:0">
						 <option value="none"		<c:if test="${member_info.email2 eq 'none' }">selected</c:if>>직접입력</option>
						 <option value="gmail.com" 	<c:if test="${member_info.email2 eq 'gmail.com' }">selected</c:if>>gmail.com</option>
						 <option value="naver.com"	<c:if test="${member_info.email2 eq 'naver.com' }">selected</c:if>>naver.com</option>
						 <option value="daum.net"	<c:if test="${member_info.email2 eq 'daum.net' }">selected</c:if>>daum.net</option>
						 <option value="nate.com"	<c:if test="${member_info.email2 eq 'nate.com' }">selected</c:if>>nate.com</option>
					</select><br><br>
					<input type="checkbox" id="emailsts_yn" name="emailsts_yn" value="Y" <c:if test="${member_info.emailsts_yn == 'Y' }">checked</c:if> class="custom-control-input"> <label for="emailsts_yn">myBMS에서 발송하는 E-mail 소식을 수신합니다.</label> 
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','email')"/></td>
			</tr>
			<tr>
				<td align="center">주소</td>
				<td>
					<input type="text" id="zipcode" name="zipcode" size="70px" value="${member_info.zipcode }" class="form-control" style="display:inline;width:150px;padding:0">
					<input type="button" value="검색" class="btn btn-outline-primary btn-sm" onclick="javascript:execDaumPostcode()">
					<br>도로명주소 : 
					<input type="text" id="roadAddress" name="roadAddress" class="form-control" value="${member_info.roadAddress }">
					<br>지번주소 : 
					<input type="text" id="jibunAddress" name="jibunAddress" class="form-control" value="${member_info.jibunAddress }">
					<br>나머지 주소 : 
					<input tyoe="text" name="namujiAddress" class="form-control" value="${member_info.namujiAddress }">			
				</td>
				<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${member_info.member_id }','address')"/></td>
			</tr>
		</table>
	</form>
	<p align="right">
		<c:choose>
			<c:when test="${member_info.del_yn eq 'Y' }">
				<input type="button" value="회원복원" onClick="fn_delete_member('${member_info.member_id }','N')" class="btn btn-primary btn-sm" >
			</c:when>
			<c:when test="${member_info.del_yn eq 'N' }">
				<input type="button" value="회원탈퇴" onClick="fn_delete_member('${member_info.member_id }','Y')" class="btn btn-danger btn-sm" >
			</c:when>
		</c:choose>
	</p>
</body>
</html>