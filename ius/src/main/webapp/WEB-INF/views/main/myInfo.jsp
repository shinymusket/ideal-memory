<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>      
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/main/myInfo.js"></script>
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
            document.getElementById("staff_zipcode").value = data.zonecode;
            document.getElementById("staff_addr").value = addr;

            document.getElementById("staff_addr").focus();
        }
    }).open();
};


</script>
<title>회원 정보</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/main/myInfo.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>회원 정보</p>
				<h3>회원 정보 </h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="비밀번호 변경" onclick="location.href='../main/update_password_form'">
					</div>
					<div id="myInfo">
						<form name="frm" method="post" action="./update_staff_info" enctype="multipart/form-data">
							<table id="myInfoTbl" border="1">
								<tr>
									<th colspan="2">사번</th>
									<td colspan="2">
										<input type="text" id="staff_num" name="staff_num" readonly="readonly" value="${staff.staff_num}">
									</td>
								</tr>		
								<tr>
									<td rowspan="5" id="staff_picture" width='94.4px' height='113.3px'>
										<div class="select_img">
											
											<img src="<spring:url value="/resources/"/>${staff.staff_picture}" width='94.4px' height='113.3px'>
										</div>
										<input type="file" id="staff_picFile" name="staff_picFile" style="display : none;">
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td colspan="2">
										<input type="text" name="staff_name" id="staff_name" readonly="readonly" value="${staff.staff_name}">
									</td>
								</tr>
								<tr>
									<th>직무</th>
									<td colspan="2">
										<input type="hidden" id="staff_cls" name="staff_cls" value="${staff.staff_cls}">
										<input type="text" id="job_Kname" name="job_Kname" readonly="readonly" value="${staff.job_Kname}">
									</td>	
								</tr>
								<tr>
									<th>아이디</th>
									<td colspan="2">
										<input type="text" name="staff_id" id="staff_id" readonly="readonly" value="${staff.staff_id}">
									</td>
								</tr>
								<tr>
									<th>주민등록번호</th>
									<td colspan="2">
										<input type="text" name="staff_rrn1" id="staff_rrn1" readonly="readonly" value="${staff.staff_rrn1}">
										-
										<c:set var="rrn2Value" value="${staff.staff_rrn2}"/>
										<input type="text" name="staff_rrn2" id="staff_rrn2" readonly="readonly" value="${fn:substring(rrn2Value,0,1)}******">
									</td>
								</tr>	
								<tr>
									<th colspan="2">주소</th>
									<td colspan="2">
										<input type="text" name="staff_addr" id="staff_addr" readonly="readonly" value="${staff.staff_addr}">
										<input type="hidden" name="origin_addr" id="origin_addr" value="${staff.staff_addr}">
										<input type="button" value="우편번호 찾기" id="select_addr" onclick="selectAddr()" style="display : none;">	
									</td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td>
										<input type="text" name="staff_zipcode" id="staff_zipcode" readonly="readonly" value="${staff.staff_zipcode}">
										<input type="hidden" name="origin_zipcode" id="origin_zipcode" value="${staff.staff_zipcode}">
										<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
										<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
									</td>
									<th>연락처</th>
									<td>
										<input type="tel" name="staff_tel" id="staff_tel" readonly="readonly" value="${staff.staff_tel}">
										<input type="hidden" name="origin_tel" id="origin_tel" value="${staff.staff_tel}">
									</td>
								</tr>
								<tr>
									<th>입사일</th>
									<td>
										<input type="date" name="staff_hireD" id="staff_hireD" readonly="readonly" value="${staff.staff_hireD}">
									</td>
									<th>재직여부</th>
									<td>
										<c:if test="${staff.staff_workYn == 'Y'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="재직" readonly="readonly">
										</c:if>
										<c:if test="${staff.staff_workYn == 'P'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="휴직" readonly="readonly">
										</c:if>		
										<c:if test="${staff.staff_workYn == 'N'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="퇴직" readonly="readonly">
										</c:if>
									</td>
								</tr>
								<tr>
									<th>월급</th>
									<td>
										<input type="text" id="staff_salary" readonly="readonly" value="<fmt:formatNumber maxFractionDigits="3" value="${staff.staff_salary}"/>">
									</td>
									<th>이메일</th>
									<td>
										<input type="email" name="staff_email" id="staff_email" readonly="readonly" value="${staff.staff_email}">
									</td>
								</tr>
								<tr>
									<td id="btnsTd" colspan="4">
										<input type="button" value="정보 수정" id="updateForm">
										<input type="button" value="취소" id="cancel" style="display : none;">
										<input type="button" value="수정 완료" id="update" style="display : none;">
									</td>
								</tr>					
							</table>
						</form>
					</div>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>
</body>
</html>