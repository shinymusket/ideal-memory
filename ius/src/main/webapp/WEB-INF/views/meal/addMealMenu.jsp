<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 추가</title>
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
	
	    var x = 0;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='L'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='lallergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`lallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
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
	
	    var x = 0;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='B'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='ballergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`ballergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
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
	
	    var x = 0;
	    $(add_button).click(function(e) {
	        e.preventDefault();
	        if (x < max_fields) {
	            x++;
	            $(wrapper).append("<tr id='input-menu'><td><input type='hidden' name='meal_code[]' value='S'><input type='text' name='menu[]' required='required'></td><td><input type='text' name='kcal[]' required='required'> kcal</td><td><input type='text' id='sallergy"+x+"' name='allergy[]' readonly='readonly'><input type='button' value='선택' onclick='openlAllergy(`sallergy"+x+"`)'></td> <td id='deleteInput' class='AutoInput' title='Delete'>x</td></tr>");
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
</head>
<body>
<form name="addMenu" id="addMenu" action="./addMenu" method="POST">
	<table border="1" width="800px">
		<tr>
			<td colspan="4">식단 등록</td>
		</tr>
		<tr>
			<td>급식 일자</td>
			<td colspan="3">
				<input type="date" name="menu_edate">
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
	</table>
		
	<table  border="1" width="800px" id="lunch">
			<tr>
				<th colspan="4">점심 (최대 6개)<input name="addButton" id="add_lunch_field" type="button" value="+"></th>
			</tr>	
	</table>
		
	<table  border="1" width="800px" id="snack">
		<tr>
			<th colspan="3">오후 간식 (최대 2개) <input name="addButton" id="add_snack_field" type="button" value="+"></th>
		</tr>
	</table>
	
	<input type="submit" value="등록">
	<input type="reset" value="다시 작성">
	<input type="button" value="돌아가기">
	
	
</form>
</body>
</html>