<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />
<c:set var="cntfrm" value="${imageFileList.size() }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script>
	/* 각 요소 수정버튼 ajax */
	function fn_modify_goods(goods_id, attribute){
		var frm_mod_goods = document.frm_mod_goods;
		var value="";
		
		if(attribute == 'goods_sort')						value = frm_mod_goods.goods_sort.value;
		else if (attribute == 'goods_title') 				value = frm_mod_goods.goods_title.value;
		else if (attribute == 'goods_writer') 				value = frm_mod_goods.goods_writer.value;
		else if (attribute == 'goods_publisher') 			value = frm_mod_goods.goods_publisher.value;
		else if (attribute == 'goods_price') 				value = frm_mod_goods.goods_price.value;
		else if (attribute == 'goods_sales_price') 			value = frm_mod_goods.goods_sales_price.value;
		else if (attribute == 'goods_point') 				value = frm_mod_goods.goods_point.value;
		else if (attribute == 'goods_published_date') 		value = frm_mod_goods.goods_published_date.value;
		else if (attribute == 'goods_page_total') 			value = frm_mod_goods.goods_page_total.value;
		else if (attribute == 'goods_isbn') 				value = frm_mod_goods.goods_isbn.value;
		else if (attribute == 'goods_delivery_price') 		value = frm_mod_goods.goods_delivery_price.value;
		else if (attribute == 'goods_delivery_date') 		value = frm_mod_goods.goods_delivery_date.value;
		else if (attribute == 'goods_status') 				value = frm_mod_goods.goods_status.value;
		else if (attribute == 'goods_contents_order') 		value = frm_mod_goods.goods_contents_order.value;
		else if (attribute == 'goods_writer_intro') 		value = frm_mod_goods.goods_writer_intro.value;
		else if (attribute == 'goods_intro') 				value = frm_mod_goods.goods_intro.value;
		else if (attribute == 'goods_publisher_comment') 	value = frm_mod_goods.goods_publisher_comment.value;
		else if (attribute == 'goods_recommendation') 		value = frm_mod_goods.goods_recommendation.value;
		
		$.ajax({
			type : "post",
			url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
			data : {
				goods_id : goods_id,
				attribute : attribute,
				value : value
			},
			success : function(data, textStatus){
				if(data.trim() == 'mod_success')
					alert("상품정보를 수정했습니다. ");
				else if(data.trim() == 'failed')
					alert("다시 시도해 주세요.");
			}, 
			error : function(data, textStatus) {
				alert("에러가 발생했습니다. " + data);
			}, 
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}			
		});
	}
	
	/* 2. readURL함수 작성 */
	function readURL(input, preview){
		if(input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#'+preview).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]); // 이 코드 실행시, reader.onload()실행됨
		}
	}
	
	/* 3. fn_addFile() 함수 작성 */
	var cnt = "${cntfrm}";
	function fn_addFile(){
		$("#d_file").append("<br>"+"<input type='file' name='detail_image"+cnt+"' id='detail_image"+cnt+"' onchange=readURL(this, 'previewImage"+cnt+"')/>");
		$("#d_file").append("<img id='previewImage"+cnt+"' width='200' height='200' />");
		$("#d_file").append("<input type='button' value='추가' onclick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image') class='btn btn-info btn-xs'/>");
		cnt++;
	}
	
	/* 4. addNewImageFile() 함수  */
	function addNewImageFile(fileId, goods_id, fileType){
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form);
		formData.append("fileName", $('#'+fileId)[0].files[0]);
		formData.append("goods_id", goods_id);
		/* formData.append("image_id", image_id); */
		formData.append("fileType", fileType);
		
		$.ajax({
			url: '${contextPath}/admin/goods/addNewGoodsImage.do',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			success: function(result){
				alert("이미지를 추가했습니다. ");
				location.href = "${contextPath}/admin/goods/modifyGoodsForm.do?goods_id="+goods_id+"#tab7";
			}
		});
	}
	/* 5. modifyImageFile() 함수 */
	function modifyImageFile(fileId, goods_id, image_id, fileType){
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form);
		formData.append("fileName", $('#'+fileId)[0].files[0]);
		formData.append("goods_id", goods_id);
		formData.append("image_id", image_id);
		formData.append("fileType", fileType);
		
		$.ajax({
			url : '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function (result){
				alert("이미지를 수정했습니다.");
			}
		});
	}
	
	/* 6. deleteImageFile() 함수 */
	function deleteImageFile(goods_id, image_id, imageFileName, trId){
		var tr = document.getElementById(trId);
		
		$.ajax({
			url : "${contextPath}/admin/goods/removeGoodsImage.do",
			type : "post",
			data : {goods_id : goods_id,
					image_id : image_id,
					imageFileName : imageFileName
			},
			success : function(data, textStatus){
	  			if(result == "deleted"){
		   			alert("이미지를 삭제했습니다.");
		            /* tr.style.display = 'none'; */
		            tr.remove();
	  			}
/* 		   			location.href = "${contextPath}/admin/goods/modifyGoodsForm.do?goods_id="+goods_id; */	
			},
			error : function(data, textStatus){
	   			alert(result+"\n!!에러가 발생했습니다."+textStatus+"\ngoods_id = "+ goods_id + ", image_id = "+image_id +", imageFileName = " + imageFileName + ", trId = " + trId);
			},
			complete : function(data, textStatus){
			}
		});
	}
</script>


<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>

	<div class="clear"></div>
	<div id="container">
		<form name="frm_mod_goods" method="post">
			<ul class="tabs">
				<li><a href="#tab1">상품정보</a></li>
				<li><a href="#tab2">상품목차</a></li>
				<li><a href="#tab3">저자소개</a></li>
				<li><a href="#tab4">상품소개</a></li>
				<li><a href="#tab5">출판사 상품 평가</a></li>
				<li><a href="#tab6">추천사</a></li>
				<li><a href="#tab7">상품이미지</a></li>
			</ul>
			<div class="tab_container">
				<div class="tab_content" id="tab1">
					<table class="table table-bordered table-hover">
						<colgroup>
							<col width="25%">
							<col width="65%">
							<col width="10%">
						</colgroup>
						<tr>
							<td align="center">상품분류</td>
							<td>
								<select name="goods_sort" class="form-control">
									<option value="컴퓨터와 인터넷" <c:if test="${goods.goods_sort == '컴퓨터와 인터넷'}"> selected </c:if>>컴퓨터와 인터넷</option>
									<option value="디지털 기기" <c:if test="${goods.goods_sort == '디지털 기기'}"> selected </c:if>>디지털 기기</option>
								</select>
							</td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_sort')"/></td>
						</tr>
						<tr>
							<td align="center">상품종류</td>
							<td>
								<select name="goods_status" class="form-control">
									<option value="bestseller" <c:if test="${goods.goods_status } eq 'bestseller'"> selected</c:if> >베스트셀러</option>
									<option value="steadyseller" <c:if test="${goods.goods_status } eq 'steadyseller'"> selected</c:if> >스테디셀러</option>
									<option value="newbook" <c:if test="${goods.goods_status } eq 'newbook'"> selected</c:if> >신간</option>
									<option value="on_sale" <c:if test="${goods.goods_status } eq 'on_sale'"> selected</c:if> >판매중</option>
									<option value="buy_out" <c:if test="${goods.goods_status } eq 'buy_out'"> selected</c:if> >품절</option>
									<option value="out_of_print" <c:if test="${goods.goods_status } eq 'out_of_print'"> selected</c:if> >절판</option>
								</select>
								<input type="hidden" name="h_goods_status" value="${goods.goods_status }"/>
							</td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_status')"/></td>
						</tr>							
						<tr>
							<td align="center">상품이름</td>
							<td><input type="text" name="goods_title" id="goods_title" class="form-control" value="${goods.goods_title }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_title')"/></td>
						</tr>							
						<tr>
							<td align="center">저자</td>
							<td><input type="text" name="goods_writer" id="goods_writer" class="form-control" value="${goods.goods_writer }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_writer')"/></td>
						</tr>							
						<tr>
							<td align="center">출판사</td>
							<td><input type="text" name="goods_publisher" id="goods_publisher" class="form-control" value="${goods.goods_publisher }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_publisher')"/></td>
						</tr>							
						<tr>
							<td align="center">상품정가</td>
							<td><input type="text" name="goods_price" id="goods_price" class="form-control" value="${goods.goods_price }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_price')"/></td>
						</tr>							
						<tr>
							<td align="center">상품판매가격</td>
							<td><input type="text" name="goods_sales_price" id="goods_sales_price" class="form-control" value="${goods.goods_sales_price }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_sales_price')"/></td>
						</tr>							
						<tr>
							<td align="center">상품구매 포인트</td>
							<td><input type="text" name="goods_point" id="goods_point" class="form-control" value="${goods.goods_point }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_point')"/></td>
						</tr>							
						<tr>
							<td align="center">상품출판일</td>
							<td><input type="date" name="goods_published_date" id="goods_published_date" class="form-control" value="${goods.goods_published_date }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_published_date')"/></td>
						</tr>							
						<tr>
							<td align="center">상품 총 페이지 수</td>
							<td><input type="text" name="goods_total_page" id="goods_total_page" class="form-control" value="${goods.goods_total_page }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_total_page')"/></td>
						</tr>							
						<tr>
							<td align="center">ISBN</td>
							<td><input type="text" name="goods_isbn" id="goods_isbn" class="form-control" value="${goods.goods_isbn }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_isbn')"/></td>
						</tr>							
						<tr>
							<td align="center">상품 배송비</td>
							<td><input type="text" name="goods_delivery_price" id="goods_delivery_price" class="form-control" value="${goods.goods_delivery_price }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_delivery_price')"/></td>
						</tr>							
						<tr>
							<td align="center">상품 도착 예정일</td>
							<td><input type="date" name="goods_delivery_date" id="goods_delivery_date" class="form-control" value="${goods.goods_delivery_date }"/></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goods_id}', 'goods_delivery_date')"/></td>
						</tr>							
					</table>
				</div>
				<div class="tab_content" id="tab2">
					<div class="form-group">
						<label for="goods_contents_order">책 목차</label>
						<textarea rows="50" cols="50" id="goods_contents_order" name="goods_contents_order" class="form-control">${goods.goods_contents_order }</textarea>
						<p align="right"><input type="button" value="수정" class="btn btn-outline-primary btn-sm"
										onClick="fn_modify_goods('${goods.goods_id}', 'goods_contents_order')"/></p> 
						
					</div>
				</div>
				<div class="tab_content" id="tab3">
					<div class="form-group">
						<label for="goods_writer_intro">상품 저자 소개</label>
						<textarea rows="50" cols="50" id="goods_writer_intro" name="goods_writer_intro" class="form-control">${goods.goods_writer_intro }</textarea>
						<p align="right"><input type="button" value="수정" class="btn btn-outline-primary btn-sm"
										onClick="fn_modify_goods('${goods.goods_id}', 'goods_writer_intro')"/></p> 
					</div>
				</div>
				<div class="tab_content" id="tab4">
					<div class="form-group">
						<label for="goods_intro">상품 소개</label>
						<textarea rows="50" cols="50" id="goods_intro" name="goods_intro" class="form-control">${goods.goods_intro }</textarea>
						<p align="right"><input type="button" value="수정" class="btn btn-outline-primary btn-sm"
										onClick="fn_modify_goods('${goods.goods_id}', 'goods_intro')"/></p> 
					</div>
				</div>
				<div class="tab_content" id="tab5">
					<div class="form-group">
						<label for="goods_publisher_comment">출판사 상품 평가</label>
						<textarea rows="50" cols="50" id="goods_publisher_comment" name="goods_publisher_comment" class="form-control">${goods.goods_publisher_comment }</textarea>
						<p align="right"><input type="button" value="수정" class="btn btn-outline-primary btn-sm"
										onClick="fn_modify_goods('${goods.goods_id}', 'goods_publisher_comment')"/></p> 
					</div>
				</div>
				<div class="tab_content" id="tab6">
					<div class="form-group">
						<label for="goods_recommendation">추천사</label>
						<textarea rows="50" cols="50" id="goods_recommendation" name="goods_recommendation" class="form-control">${goods.goods_recommendation }</textarea>
						<p align="right"><input type="button" value="수정" class="btn btn-outline-primary btn-sm"
										onClick="fn_modify_goods('${goods.goods_id}', 'goods_recommendation')"/></p> 
					</div>
				</div>
				<div class="tab_content" id="tab7">
					<h4>상품 이미지</h4>
					<table class="list_view">
						<tr align="center" style="background-color : #0061f2; color:#fff; height: 50px">
							<th>이미지 분류</th>
							<th>이미지 추가</th>
							<th colspan="2">이미지 미리보기</th>
							<th>이미지 수정</th>
						</tr>
						<c:forEach var="item" items="${imageFileList }" varStatus="itemNum">
							<c:choose>
								<c:when test="${item.fileType == 'main_image' }"> <!-- 메인이미지 -->
									<tr>
										<td>메인 이미지</td>
										<td><input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count}' );"/>
											<input type="hidden" name="image_id" value="${item.image_id }"><br> <!-- 왜 넘겨주는거지 ??? -->
										</td>
										<td><img id="preview${itemNum.count }" width="200" height="200" src="${contextPath }/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"/></td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td><input type="button" value="수정" class="btn btn-primary btn-xs" 
												onClick="modifyImageFile('main_image','${item.goods_id }','${item.image_id}','${item.fileType }')"/></td>
									</tr>
								</c:when>
								<c:otherwise> <!-- 상세이미지 -->
									<tr id="${itemNum.count-1 }">
										<td>상세 이미지 ${itemNum.count-1 }</td>
										<td><input type="file" id="detail_image${itemNum.count-1 }" name="detail_image${itemNum.count-1 }" onchange="readURL(this,'preview${itemNum.count}' );"/>
											<input type="hidden" name="image_id" value="${item.image_id }"><br> <!-- 왜 넘겨주는거지 ??? -->
										</td>
										<td><img id="preview${itemNum.count }" width="200" height="200" src="${contextPath }/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"/></td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td>
											<input type="button" value="수정" class="btn btn-primary btn-xs" onClick="modifyImageFile('detail_image'+'${itemNum.count-1 }','${item.goods_id }','${item.image_id }','${item.fileType }')"/>
											<input type="button" value="삭제" class="btn btn-danger btn-xs" onClick="deleteImageFile('${item.goods_id }','${item.image_id }','${item.fileName }','${itemNum.count-1}')"/>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<tr align="center">
							<td colspan="3">
								<div id="d_file"></div>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="5">
								<input type="button" value="이미지파일 추가하기" class="btn btn-outline-primary btn-sm" onClick="fn_addFile()"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
</body>
</html>