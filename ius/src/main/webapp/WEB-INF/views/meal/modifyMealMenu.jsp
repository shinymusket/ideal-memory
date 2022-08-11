<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 수정</title>
<style>
	table{
	text-align: center;
	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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

</script>
<script>
	// 점심 추가
	$(document).ready(function() {
	    var max_fields = 6;
	    var wrapper = $("#lunch");
	    var add_button = $("#add_lunch_field");
	    
	    var count = $('.lunchCount').length
	    console.log(count);
	    
	    var x = 0;
	    x +=count
	    
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='menu_num[]' class='menuN'><input type='hidden' name='meal_code[]' value='L'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='lallergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`lallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
	        } else {
	            alert('6개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	        e.preventDefault();
	        
	        var num = $(this).parent('#input-menu').find('.menuN').val();
	        
	        $.ajax({
	        	url : "/ius/meal/meal_delete",
	        	type : "POST",
	        	data : {
	        		menu_num : num
	        	},
	        	success : function(data) {
	        		alert("삭제되었습니다.");
	        		
	        	}
	        })

	        
	        console.log($(this).parent('#input-menu').find('.menuN').val());
	        
	        $(this).parent('#input-menu').remove();
	        x--;
	        
	        
	    })
	});
	
	// 아침 간식
	$(document).ready(function() {
	    var max_fields = 2;
	    var wrapper = $("#break");
	    var add_button = $("#add_break_field");
	    
	    // 클래스를 카운트해서 현재 몇 개의 메뉴가 있는지 확인
	    var count = $('.breakCount').length
	    console.log(count);
	    
	    var x = 0;
	    x +=count
	    
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='menu_num[]' class='menuN'><input type='hidden' name='meal_code[]' value='B'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='ballergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`ballergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
	        } else {
	            alert('아침 간식은 2개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	    	
	    	var dietitian = getCookie("dietitian");
	    	
	        e.preventDefault();
	        
	        if (dietitian == "N") { // 권한이 없는 경우.
	        	alert("권한이 없습니다.");
	        	return;
	        } else if (dietitian == "Y") {
	        	var num = $(this).parent('#input-menu').find('.menuN').val();
		        $.ajax({
		        	url : "/ius/meal/meal_delete",
		        	type : "POST",
		        	data : {
		        		menu_num : num
		        	},
		        	success : function(data) {
		        		alert("삭제되었습니다.");
		        		
		        	}
		        })

		        
		        $(this).parent('#input-menu').remove();
		        x--;
	        }
	        
	    })
	});
	
	
	// 오후 간식
	$(document).ready(function() {
	    var max_fields = 2;
	    var wrapper = $("#snack");
	    var add_button = $("#add_snack_field");
	    
	    var count = $('.snackCount').length
	    console.log(count);
	    
	    var x = 0;
	    x +=count
	    
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='menu_num[]' class='menuN'><input type='hidden' name='meal_code[]' value='S'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='sallergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`sallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
	        } else {
	            alert('오후 간식은 2개를 초과할 수 없습니다.')
	        }
	    });
	
	    $(wrapper).on("click", "#deleteInput", function(e) {
	        e.preventDefault();
	        
 			var num = $(this).parent('#input-menu').find('.menuN').val();
	        
	        $.ajax({
	        	url : "/ius/meal/meal_delete",
	        	type : "POST",
	        	data : {
	        		menu_num : num
	        	},
	        	success : function(data) {
	        		alert("삭제되었습니다.");
	        		
	        	}
	        })

	        
	        $(this).parent('#input-menu').remove();
	        x--;
	    })
	});
	
	
	
</script>
</head>
<body>
<form name="addMenu" id="addMenu" action="./modifyMealMenu" method="POST">
	<table border="1" width="800px">
		<tr>
			<td colspan="4">식단 등록</td>
		</tr>
		<tr>
			<td>급식 일자</td>
			<td colspan="3">
				<input type="date" name="menu_edate" value="${menu_edate}">
			</td>
		</tr>
		<tr>
			<td colspan="4">식단</td>
		</tr>
		<tr>
			<td>음식명</td>
			<td>칼로리</td>
			<td>알레르기 유발</td>
		</tr>
	</table>
	<table  border="1" width="800px" id="break">
		<tr>
			<th colspan="4">오전 간식 (최대 2개)<input name="addButton" id="add_break_field" type="button" value="+"></th>
		</tr>
		<c:forEach items="${list}" var="meal">
			<c:if test="${meal.meal_code eq 'B'}">
				<c:set var="i" value="${i+1}"/>
				<tr id='input-menu'>
					<td><input type="hidden" name="menu_num[]" class="menuN" value="${meal.menu_num}">
					<input type='hidden' name='meal_code[]' value='B'>
					<input type='text' name='menu[]' class="breakCount"required='required' value="${meal.meal_menu}"></td>
					<td><input type='text' name='kcal[]' required='required' value="${meal.menu_calorie}"> kcal</td>
					<td><input type='text' id='ballergy${i}' name='allergy[]' readonly='readonly' value="${meal.allergy_num}">
					<input type='button' value='선택' onclick='openlAllergy(`ballergy${i}`)'></td>
					<td id='deleteInput' class='AutoInput' title='Delete'>x</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
		
	<table  border="1" width="800px" id="lunch">
			<tr>
				<th colspan="4">점심 (최대 6개)<input name="addButton" id="add_lunch_field" type="button" value="+"></th>
			</tr>
			<c:forEach items="${list}" var="meal">
				<c:if test="${meal.meal_code eq 'L'}">
				<c:set var="j" value="${j+1}"/>
					<tr id='input-menu'>
						<td><input type="hidden" name="menu_num[]" class="menuN" value="${meal.menu_num}">
						<input type='hidden' name='meal_code[]' value='L'>
						<input type='text' name='menu[]' class="lunchCount" required='required' value="${meal.meal_menu}"></td>
						<td><input type='text' name='kcal[]' required='required' value="${meal.menu_calorie}"> kcal</td>
						<td><input type='text' id='lallergy${j}' name='allergy[]' readonly='readonly' value="${meal.allergy_num}">
						<input type='button' value='선택' onclick='openlAllergy(`lallergy${j}`)'></td>
						<td id='deleteInput' class='AutoInput' title='Delete'>x</td>
					</tr>
				</c:if>
			</c:forEach>
	</table>
		
	<table  border="1" width="800px" id="snack">
		<tr>
			<th colspan="3">오후 간식 (최대 2개) <input name="addButton" id="add_snack_field" type="button" value="+"></th>
		</tr>
		<c:forEach items="${list}" var="meal">
			<c:if test="${meal.meal_code eq 'S'}">
				<c:set var="k" value="${k+1}"/>
				<tr id='input-menu'>
					<td><input type="hidden" name="menu_num[]" class="menuN" value="${meal.menu_num}">
					<input type='hidden' name='meal_code[]' value='S'>
					<input type='text' name='menu[]' class="snackCount" required='required' value="${meal.meal_menu}"></td>
					<td><input type='text' name='kcal[]' required='required' value="${meal.menu_calorie}"> kcal</td>
					<td><input type='text' id='sallergy${k}' name='allergy[]' readonly='readonly' value="${meal.allergy_num}">
					<input type='button' value='선택' onclick='openlAllergy(`sallergy${k}`)'></td>
					<td id='deleteInput' class='AutoInput' title='Delete'>x</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	
	<input type="submit" value="등록">
	<input type="reset" value="다시 작성">
	<input type="button" onclick="location.href='./meal_list'" value="돌아가기">
		
</form>
</body>
</html>