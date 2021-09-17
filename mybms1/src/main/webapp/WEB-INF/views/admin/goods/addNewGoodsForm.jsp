<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 파일관련 script -->
<script>
	var cnt = 0;
	
	function fn_addFile(){
		if(cnt == 0)
			$("#d_file").append("<br>"+"<input type='file' name='main_image' id='f_main_image'/>");
		else
			$("#d_file").append("<br>"+"<input type='file' name='detail_image"+cnt+"'/>");
		cnt++;
	}
	
	function fn_add_new_goods(obj){
		fileName = $('#f_main_image').val();
		
		if(fileName != null && fileName != undefined){
			obj.submit();
		} else {
			alert("메인 이미지는 반드시 첨부해야 합니다. ");
			return;
		}
	}
</script>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>

<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">
	<h1>상품 등록창</h1>
	<div class="tab_container">
		<div class="tab_container" id="container">
			<ul class="tabs">
				<li><a href="#tab1">상품정보</a></li>
				<li><a href="#tab2">상품목차</a></li>
				<li><a href="#tab3">상품저자소개</a></li>
				<li><a href="#tab4">상품소개</a></li>
				<li><a href="#tab5">출판사 상품 평가</a></li>
				<li><a href="#tab6">추천사</a></li>
				<li><a href="#tab7">상품이미지</a></li>
			</ul>
			<div class="tab_content" id="tab1">
				<table class="table table-bordered table-hover">
					<tr>
						<td width="180px">제품분류</td>
						<td width="520px">
							<select name="goods_sort" class="form-control">
								<option value="컴퓨터와 인터넷" selected>컴퓨터와 인터넷</option>
								<option value="디지털 기기">디지털 기기</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>제품종류</td>
						<td>
							<select name="goods_status" class="form-control">
								<option value="bestseller">베스트셀러</option>
								<option value="steadyseller">스테디셀러</option>
								<option value="newbook">신간</option>
								<option value="on_sale">판매중</option>
								<option value="buy_out">품절</option>
								<option value="out_of_print">절판</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>제품이름</td>
						<td><input name="goods_title" type="text" class="form-control" /></td>
					</tr>
					<tr>
						<td>저자</td>
						<td><input type="text" name="goods_writer" class="form-control"></td>
					</tr>
					<tr>
						<td>출판사</td>
						<td><input type="text" name="goods_publisher" class="form-control"></td>
					</tr>
					<tr>
						<td>제품정가</td>
						<td><input type="text" name="goods_price" class="form-control"></td>
					</tr>
					<tr>
						<td>제품판매가격</td>
						<td><input type="text" name="goods_sales_price" class="form-control"></td>
					</tr>
					<tr>
						<td>제품 구매 포인트</td>
						<td><input type="text" name="goods_point" class="form-control"></td>
					</tr>
					<tr>
						<td>제품 출판일</td>
						<td><input type="date" name="goods_published_date" class="form-control"></td>
					</tr>
					<tr>
						<td>제품 총 페이지 수</td>
						<td><input type="text" name="goods_total_page" class="form-control"></td>
					</tr>
					<tr>
						<td>ISBN</td>
						<td><input type="text" name="goods_isbn" class="form-control"></td>
					</tr>
					<tr>
						<td>제품 배송비</td>
						<td><input type="text" name="goods_delivery_price" class="form-control"></td>
					</tr>
					<tr>
						<td>제품 도착 예정일</td>
						<td><input type="date" name="goods_delivery_date" class="form-control"></td>
					</tr>
				</table>
			</div>
			<div class="tab_content" id="tab2">
				<div class="form-group">
					<label for="goods_contents_order">책 목차</label>
					<textarea rows="50" cols="50" id="goods_contents_order" name="goods_contents_order" class="form-control"></textarea>
				</div>
			</div>
			<div class="tab_content" id="tab3">
				<div class="form-group">
					<label for="goods_writer_intro">상품 저자 소개</label>
					<textarea rows="50" cols="50" id="goods_writer_intro" name="goods_writer_intro" class="form-control"></textarea>
				</div>
			</div>
			<div class="tab_content" id="tab4">
				<div class="form-group">
					<label for="goods_intro">상품 소개</label>
					<textarea rows="50" cols="50" id="goods_intro" name="goods_intro" class="form-control"></textarea>
				</div>
			</div>
			<div class="tab_content" id="tab5">
				<div class="form-group">
					<label for="goods_publisher_comment">출판사 상품 평가</label>
					<textarea rows="50" cols="50" id="goods_publisher_comment" name="goods_publisher_comment" class="form-control"></textarea>
				</div>
			</div>
			<div class="tab_content" id="tab6">
				<div class="form-group">
					<label for="goods_recommendation">추천사</label>
					<textarea rows="50" cols="50" id="goods_recommendation" name="goods_recommendation" class="form-control"></textarea>
				</div>
			</div>
			<div class="tab_content" id="tab7">
				<h4>상품 이미지</h4>
				<table class="list_view">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tr align="center" style="background-color : #0061f2; color:#fff; height: 50px">
						<th>이미지 분류</th>
						<th colspan="2">이미지 추가</th>
					</tr>
					<tr>
						<td>이미지 파일 첨부</td>
						<td><input type="button" value="파일추가" onClick="fn_addFile()"></td>
						<td><div id="d_file"></div></td>
					</tr>
				</table>
			</div>
		</div>
		<p align="right">
			<input type="button" value="상품 등록하기" onClick="fn_add_new_goods(this.form)" class="btn btn-outline-primary">
		</p>	
	</div>
</form>
</body>
</html>