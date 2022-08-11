<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알러지 유발</title>
<link rel="stylesheet" href="${path}/resources/css/allergy.css">
</head>
<body>
<form name="allergy">
	<div id="allergy_box">
		<ul>
				<c:forEach items="${allergyList}" var="all">
					<li>
							<input type="checkbox" id="allergy_num" name="allergy_Num" value="${all.allergy_Num}" onchange="makeFilter(this);">${all.allergy_Name}
					</li>
				</c:forEach>
		</ul>
		<div id="but_box">
			<input type="text" id="showFilter" readonly><br>
			<input type="button" value="확인" onclick="addAllergy()">
			<input type="button" value="닫기">
		</div>
	</div>
</form>
<script>

var allerArr = new Array(); //필터 내용을 저장하는 배열
var showFilterValue = document.getElementById("showFilter");//필터입력값 보여주기 위한 text

console.log(window.name)
//필터 내용을 저장하는 function
function makeFilter(target){

    var allVal = target.value; //check value
    var confirmCheck = target.checked; //check여부 확인
    console.log("필터 선택값 : "+allVal);
    console.log("선택여부 : "+confirmCheck);

    // check true
    if(confirmCheck == true){

        console.log("check");
        allerArr.push(allVal); // check value filter 배열에 입력

    // check false
    }else{

    	allerArr.splice(allerArr.indexOf(allVal), 1); // check value filter 배열내용 삭제            
    }

    showFilterValue.value = allerArr; // textBox에 필터 배열 추가
    console.log("필터입력값 출력 : "+allerArr);
    
    return allerArr;
}


function addAllergy(){
	if(window.name== "lallergy1"){
		opener.document.addMenu.lallergy1.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name== "lallergy2"){
		opener.document.addMenu.lallergy2.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name== "lallergy3"){
		opener.document.addMenu.lallergy3.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name== "lallergy4"){
		opener.document.addMenu.lallergy4.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name== "lallergy5"){
		opener.document.addMenu.lallergy5.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name== "lallergy6"){
		opener.document.addMenu.lallergy6.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name == "ballergy1"){
		opener.document.addMenu.ballergy1.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name == "ballergy2"){
		opener.document.addMenu.ballergy2.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name == "sallergy1"){
		opener.document.addMenu.sallergy1.value = document.allergy.showFilter.value;
		self.close();
	} else if(window.name == "sallergy2"){
		opener.document.addMenu.sallergy2.value = document.allergy.showFilter.value;
		self.close();
	}
	
	
}



</script>
</body>
</html>