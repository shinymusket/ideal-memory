<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/staff/staffRegister.js"></script>
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
	            document.getElementById('staff_zipcode').value = data.zonecode;
	            document.getElementById("staff_addr").value = addr;

	            document.getElementById("staff_addr").focus();
	        }
	    }).open();
	};

</script>
<title>교직원 등록</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/staff/staffRegister.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
	<!-- 왼쪽 소제목 박스 (타이틀 써 주시면 됩니다) -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>교직원 등록</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색 등등 필요없으면 div 안에 내용 지워도 무방)-->
		<div id="title_top">
		</div>

		<section>
			<div id="content">
				<input type="button" value="목록으로" onclick="location.href='./staff_list'">
				<form action="./staff_register" method="POST" name="frm" enctype="multipart/form-data">
					<table border="1">
						<tr>
							<th>교직원 코드</th>
							<td>
								<input type="text" name="staff_num" id="staff_num" value="${nextSeq}" readonly="readonly">
							</td>
							<th>직무*</th>
							<td>
								<input type="hidden" name="staff_cls" id="staff_cls">
								<input type="text" name="job_Kname" id="job_Kname" readonly="readonly">
								<input type="button" id="staff_cls_edit" value="선택">
							</td>
						</tr>
						<tr>
							<th>아이디*</th>
							<td>
								<input type="text" name="staff_id" id="staff_id">
								<input type="hidden" name="staff_reid" id="staff_reid">
								<input type="button" value="아이디 중복 검사" name="staff_idChk" id="staff_idChk">
							</td>
							<th>이름*</th>
							<td>
								<input type="text" name="staff_name" id="staff_name"> 
							</td>
						</tr>
						<tr>
							<th colspan="1">프로필 사진</th>
							<td colspan="3">
								<input type="file" name="staff_picFile" id="staff_picFile">
								<div class="select_img">
									<img src="">
								</div>
							</td>
						</tr>
						<tr>
							<th>주민등록번호*</th>
							<td>
								<input type="text" name="staff_rrn1" id="staff_rrn1" placeholder="ex)110011">
								-
								<input type="text" name="staff_rrn2" id="staff_rrn2" placeholder="0000000">
							</td>
							<th>연락처</th>
							<td>
								<input type="tel" name="staff_tel" id="staff_tel">
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>
								<input type="text" name="staff_addr" id="staff_addr">
								<input type="button" value="우편번호 찾기" id="select_addr" onclick="selectAddr()"> 
							</td>
							<th>우편번호</th>
							<td>
								<input type="text" name="staff_zipcode" id="staff_zipcode" readonly="readonly">
								<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
								<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
							</td>
						</tr>
						<tr>
							<th>입사일</th>
							<td>
								<input type="date" name="staff_hireD" id="staff_hireD">
							</td>
							<th>퇴사일</th>
							<td>
								<input type="date" name="staff_retireD" id="staff_retireD">
							</td>
						</tr>
						<tr>
							<th>재직여부*</th>
							<td>
								<select name="staff_workYn" id="staff_workYn">
									<option value="Y">재직</option>
									<option value="P">휴직</option>
									<option value="N">퇴사</option>
								</select>
							</td>
							<th>월급</th>
							<td>
								<input type="text" name="staff_salary" id="staff_salary" required="required" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
							</td>
						</tr>
						<tr>
							<th colspan="1">이메일*</th>
							<td colspan="3">
								<input type="email" name="staff_email" id="staff_email">
								<input type="hidden" id="check_email">
								<font id="check" size="2"></font>
								<p>이메일은 비밀번호 찾기와 초기 비밀번호 발급시 사용되므로 정확하게 입력해주시기 바랍니다.</p>
							</td>
						</tr>
						<tr>
							<td colspan="4" id="btnsTd">
								<input type="button" id="register" value="등록"> 
								<input type="reset" value="취소">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</section>
	</article> 


<%@include file="../include/footer.jsp" %>
</body>
</html>