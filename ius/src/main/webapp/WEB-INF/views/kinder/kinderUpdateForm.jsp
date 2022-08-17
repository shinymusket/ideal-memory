<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function selectAddr() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('kinder_zipcode').value = data.zonecode;
            document.getElementById("kinder_addr").value = addr;

            document.getElementById("kinder_addr").focus();
        }
    }).open();
};


</script>
<title>원생 정보 수정</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/kinder/kinderRegisterForm.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>원생 정보 수정</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="원생 목록" onclick="location.href='../kinder/kinder_list'">
					<form action="./update_kinder" method="POST" name="frm" enctype="multipart/form-data">
						<table border="1">
							<tr>
								<th>원생 번호</th>
								<td>
									<input type="text" name="kinder_num" id="kinder_num" value="${kinder.kinder_num}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>셔틀 버스 호차</th>
								<td>
									<select name="shuttle_num" id="shuttle_num">
										<option value="">-선택-</option>
										<c:if test="${shuttleList != null}">
											<c:forEach items="${shuttleList}" var="shuttle">
												<c:if test="${shuttle.shuttle_num == kinder.shuttle_num}">
													<option value="${shuttle.shuttle_num}" selected="selected">${shuttle.shuttle_name}] ${shuttle.shuttle_carnum}</option>
												</c:if>
												<c:if test="${shuttle.shuttle_num != kinder.shuttle_num}}">
													<option value="${shuttle.shuttle_num}">${shuttle.shuttle_name}] ${shuttle.shuttle_carnum}</option>
												</c:if>
											</c:forEach>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>담임 교사</th>
								<td>
									<select name="staff_num" id="staff_num">
										<option value="">-선택-</option>
										<c:if test="${homeTeacherList != null}">
											<c:forEach items="${homeTeacherList}" var="homeTeacher">
												<c:if test="${homeTeacher.staff_num == kinder.staff_num}">
													<option value="${homeTeacher.staff_num}" selected="selected">${homeTeacher.staff_name}</option>
												</c:if>
												<c:if test="${homeTeacher.staff_num != kinder.staff_num}">
													<option value="${homeTeacher.staff_num}">${homeTeacher.staff_name}</option>
												</c:if>
											</c:forEach>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>원생 이름</th>
								<td>
									<input type="text" name="kinder_name" id="kinder_name" value="${kinder.kinder_name}">
								</td>
								
							</tr>
							<tr>
								<th>주민등록번호</th>
								<td>
									<input type="text" name="kinder_rrn1" id="kinder_rrn1" value="${kinder.kinder_rrn1}">-<input type="text" name="kinder_rrn2" id="kinder_rrn2" value="${kinder.kinder_rrn2}">
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<input type="text" name="kinder_addr" id="kinder_addr" value="${kinder.kinder_addr}">
									<input type="button" value="우편번호 찾기" id="select_addr" onclick="selectAddr()"> 
								</td>
							</tr>
							<tr>
								<th>우편번호</th>
								<td>
									<input type="text" name="kinder_zipcode" id="kinder_zipcode" value="${kinder.kinder_zipcode}" readonly="readonly">
									<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
									<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<input type="tel" name="kinder_tel" id="kinder_tel" value="${kinder.kinder_tel}">
								</td>
							</tr>
							<tr>
								<th>등록 일</th>
								<td>
									<input type="date" name="kinder_regdate" id="kinder_regdate" value="${kinder.kinder_regdate}">
								</td>
							</tr>
							<tr>
								<th>퇴원 일</th>
								<td>
									<input type="date" name="kinder_retireDate" id="kinder_retireDate" value="${kinder.kinder_retireDate}">
								</td>
							</tr>
							<tr>
								<th>재원 상태</th>
								<td>
									<select name="kinder_regYn" id="kinder_regYn">
										<c:if test="${kinder.kinder_regYn == 'Y'}">
											<option value="Y" selected="selected">재원</option>
											<option value="P">휴원</option>
											<option value="N">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'P'}">
											<option value="Y">재원</option>
											<option value="P" selected="selected">휴원</option>
											<option value="N">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'N'}">
											<option value="Y">재원</option>
											<option value="P">휴원</option>
											<option value="N" selected="selected">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'G'}">
											<option value="Y">재원</option>
											<option value="P">휴원</option>
											<option value="N">퇴원</option>
											<option value="G" selected="selected">졸업</option>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>프로필 사진</th>
								<td>
									<input type="file" name="kinder_picFile" id="kinder_picFile">
									<div class="select_img">
										<img src="">
									</div>
									<p>새로 업로드하실 경우에는 기존 사진에서 새로운 사진으로 대체됩니다.</p>
								</td>
							</tr>
							<tr>
								<th>보유 알러지 정보</th>
								<td>
									<input type="text" id="allergy_info" readonly="readonly" style='text-align:center'>					
									<input type="hidden" id="allergy_code" name="allergy_code" value="${kinder.allergy_code}">
									<input type="button" value="입력" id="allergySel">
								</td>
							</tr>	
							<tr>
								<td colspan="2" id="btnsTd">
									<input type="button" value="수정" id="update"> 
								</td>
							</tr>
						</table>
					</form>
				</div>
			</section>
	</article>
<%@include file="../include/footer.jsp" %>	
</body>
<script type="text/javascript" src="${path}/resources/js/kinder/kinderUpdateForm.js"></script>
</html>