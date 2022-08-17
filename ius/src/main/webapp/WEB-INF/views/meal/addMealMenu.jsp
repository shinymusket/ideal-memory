<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 추가</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/mealCss/addMeal.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js" ></script>
<script>

function openlAllergy(name){
	window.open("./allergyInfo", name, "width=300, height=500");
}

// 엔터 누를 시 이벤트 발생 안되게 
document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);


function inNumber(){
    if(event.keyCode<48 || event.keyCode>57){
       event.returnValue=false;
    }
}

</script>
<script>
	// 점심 추가
	$(document).ready(function() {
	    var max_fields = 6;
	    var wrapper = $("#lunch");
	    var add_button = $("#add_lunch_field");
	
	    var x = 1;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='L'>"
	            		+"<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'></td>"
	            		+"<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리'> kcal</td>"
	            		+"<td><input type='text' id='lallergy"+x+"' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>"
	            		+"<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`lallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>&times;</td></tr>");
	        } else {
	            alert('6개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	        e.preventDefault();
	        $(this).parent('#input-menu').remove();
	        x--;
	    })
	});
	
	// 아침 간식
	$(document).ready(function() {
	    var max_fields = 2;
	    var wrapper = $("#break");
	    var add_button = $("#add_break_field");
	
	    var x = 1;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='B'>"
	            		+"<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'></td>"
	            		+"<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리'> kcal</td>"
	            		+"<td><input type='text' id='ballergy"+x+"' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>"
	            		+"<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`ballergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>&times;</td></tr>");
	        } else {
	            alert('아침 간식은 2개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	        e.preventDefault();
	        $(this).parent('#input-menu').remove();
	        x--;
	    })
	});
	
	
	// 오후 간식
	$(document).ready(function() {
	    var max_fields = 2;
	    var wrapper = $("#snack");
	    var add_button = $("#add_snack_field");
	
	    var x = 1;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='S'>"
	            		+"<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'></td>"
	            		+"<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리'> kcal</td>"
	            		+"<td><input type='text' id='sallergy"+x+"' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>"
	            		+"<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`sallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>&times;</td></tr>");
	        } else {
	            alert('오후 간식은 2개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	        e.preventDefault();
	        $(this).parent('#input-menu').remove();
	        x--;
	    })
	});
 
</script>
<script>
	$(document).ready(function(){
		 $("#register").click(function(){
			
			if($("input[name='menu[]']").length == 0){
				alert("메뉴 입력 후 등록이 가능합니다.");
				return;
			};
			
			if($(".menu").val() == ""){
				alert("메뉴를 입력해 주세요.");
				return;
			}
			if($(".kcal").val() == ""){
				alert("칼로리를 입력해 주세요.");
				return;
			}
 
			$("form").submit(); 
			 
		}); 
	});

</script>
</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/nav.jsp"%>
	<article>
		<!-- 왼쪽 소제목 박스 -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>식단 등록</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색)-->
		<div id="title_top">
			
		</div>

		<!-- 내용 구간 -->
		<!-- 내용 넣으면 길이 알아서 늘어나요(아마도) -->
		<section>
			<div id="content">
				<form name="addMenu" id="addMenu" action="./addMenu" method="POST">
					<table id="navAddMenu">
						<tr>
							<th>급식 일자</th>
							<td	style="text-align:left;">
								<input type="date" class="dateStyle" name="menu_edate" data-placeholder="날짜 선택" aria-required="true" required="required" max="9999-12-31">
							</td>
						</tr>
						
					</table>
					<table id="break">
						<tr>
							<th colspan="4">식단</th>
						</tr>
						<tr>
							<th>음식명</th>
							<th>칼로리</th>
							<th colspan="2">알레르기 유발</th>
						</tr>
						<tr>
							<th colspan="4">오전 간식 (최대 2개)<input name="addButton" id="add_break_field" type="button" value="+"></th>
						</tr>
						<tr id='input-menu'>
							<td>
								<input type='hidden' name='meal_code[]' value='B'>
								<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'>
							</td>
							<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리' onkeypress="inNumber();"> kcal</td>
							<td>
								<input type='text' id='ballergy1' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>
								<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`ballergy1`)'>
							</td>
							<td>
							</td>
						</tr>
					</table>
						
					<table id="lunch">
							<tr>
								<th colspan="4">점　 　 심 (최대 6개)<input name="addButton" id="add_lunch_field" type="button" value="+"></th>
							</tr>	
							<tr id='input-menu'>
							<td>
								<input type='hidden' name='meal_code[]' value='L'>
								<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'>
							</td>
							<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리' onkeypress="inNumber();"> kcal</td>
							<td>
								<input type='text' id='lallergy1' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>
								<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`lallergy1`)'>
							</td>
							<td>
							</td>
						</tr>
					</table>
						
					<table id="snack">
						<tr>
							<th colspan="4">오후 간식 (최대 2개)<input name="addButton" id="add_snack_field" type="button" value="+"></th>
						</tr>
						<tr id='input-menu'>
							<td>
								<input type='hidden' name='meal_code[]' value='S'>
								<input type='text' class='menu' name='menu[]' required='required' placeholder='음식명'>
							</td>
							<td><input type='text' class='kcal' name='kcal[]' required='required' placeholder='칼로리' onkeypress="inNumber();"> kcal</td>
							<td>
								<input type='text' id='sallergy1' name='allergy[]' readonly='readonly' placeholder='알레르기 정보를 선택하세요'>
								<input type='button' class='allchoice' value='선택' onclick='openlAllergy(`sallergy1`)'>
							</td>
							<td>
							</td>
						</tr>
					</table>
					
					<input type="submit" id="register" value="등　  록">
					<input type="reset" value="다시 작성">
					<input type="button" class="turnList" value="돌아가기" onclick="location.href='./meal_list'">
					
				</form>
			</div>
		</section>
	</article>
<%@include file="../include/footer.jsp" %>
</body>
</html>