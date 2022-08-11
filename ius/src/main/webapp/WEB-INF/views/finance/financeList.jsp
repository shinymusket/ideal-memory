<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};

function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

//만들어진 테이블에 페이지 처리
function page(){ 
	
	var reSortColors = function($table) {
	  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
	  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
	 };
	 $('table.paginated').each(function() {
	  var pagesu = 10;  //페이지 번호 갯수
	  var currentPage = 0;
	  var numPerPage = 15;  //목록의 수
	  var $table = $(this);    
	  
	  //length로 원래 리스트의 전체길이구함
	  var numRows = $table.find('tbody tr').length;
	  //Math.ceil를 이용하여 반올림
	  var numPages = Math.ceil(numRows / numPerPage);
	  //리스트가 없으면 종료
	  if (numPages==0) return;
	  //pager라는 클래스의 div엘리먼트 작성
	  var $pager = $('<td align="center" id="remo" colspan="10"><div class="pager"></div></td>');
	  
	  var nowp = currentPage;
	  var endp = nowp+10;
	  
	  //페이지를 클릭하면 다시 셋팅
	  $table.bind('repaginate', function() {
	  //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
	  
	   $table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
	   $("#remo").html("");
	   
	   if (numPages > 1) {     // 한페이지 이상이면
	    if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
	     nowp = 0;     // 1부터 
	     endp = pagesu;    // 10까지
	    }else{
	     nowp = currentPage -5;  // 6넘어가면 2부터 찍고
	     endp = nowp+pagesu;   // 10까지
	     pi = 1;
	    }
	    
	    if (numPages < endp) {   // 10페이지가 안되면
	     endp = numPages;   // 마지막페이지를 갯수 만큼
	     nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
	    }
	    if (nowp < 1) {     // 시작이 음수 or 0 이면
	     nowp = 0;     // 1페이지부터 시작
	    }
	   }else{       // 한페이지 이하이면
	    nowp = 0;      // 한번만 페이징 생성
	    endp = numPages;
	   }
	   // [처음]
	   $('<br /><span class="page-number" cursor: "pointer">[처음]</span>').bind('click', {newPage: page},function(event) {
	          currentPage = 0;   
	          $table.trigger('repaginate');  
	          $($(".page-number")[2]).addClass('active').siblings().removeClass('active');
	      }).appendTo($pager).addClass('clickable');
	    // [이전]
	      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[이전]&nbsp;</span>').bind('click', {newPage: page},function(event) {
	          if(currentPage == 0) return; 
	          currentPage = currentPage-1;
	    $table.trigger('repaginate'); 
	    $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	    // [1,2,3,4,5,6,7,8]
	   for (var page = nowp ; page < endp; page++) {
	    $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
	     currentPage = event.data['newPage'];
	     $table.trigger('repaginate');
	     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	     }).appendTo($pager).addClass('clickable');
	   } 
	    // [다음]
	      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[다음]&nbsp;</span>').bind('click', {newPage: page},function(event) {
	    if(currentPage == numPages-1) return;
	        currentPage = currentPage+1;
	    $table.trigger('repaginate'); 
	     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	    // [끝]
	   $('<span class="page-number" cursor: "pointer">&nbsp;[끝]</span>').bind('click', {newPage: page},function(event) {
	           currentPage = numPages-1;
	           $table.trigger('repaginate');
	           $($(".page-number")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	     
	     $($(".page-number")[2]).addClass('active');
	reSortColors($table);
	  });
	   $pager.insertAfter($table).find('span.page-number:first').next().next().addClass('active');   
	   $pager.appendTo($table);
	   $table.trigger('repaginate');
	 });
};

function select_finance_year() { // 년도를 선택했을 때
	var finance_year = $("#finance_year").val();
	var finance_type = $("#finance_type").val();
	var search_type = $("#search_type").val();
	
	if (finance_year != "") {
		
		var objParams = {
				seachYear : finance_year,
				finance_type : finance_type
		}
		
		var values = [];
		
		$.post(
			"/ius/finance/get_finance_list_by_year",
			objParams,
			function(retVal) {
				$("#financeYear").text("");
				$("#totalIncome").text("");
				$("#totalExpense").text("");
				$("#balance").text("");
	
				totalIncome = retVal.totalIncome;
				totalExpense = retVal.totalExpense;
				balance = (totalIncome-totalExpense);
				
				$("#financeYear").html(finance_year);
				$("#totalIncome").html(addComma(totalIncome));
				$("#totalExpense").html(addComma(totalExpense));
				$("#balance").html(addComma(balance));
			
			}
		)
			
		
		if (search_type == "budget_name") { // 검색 타입이 예산 항목 일때
			
			$.ajax({
				url : "/ius/finance/get_budget_list",
				type : "POST",
				data : {
					finance_year : finance_year,
					finance_type : finance_type
				},
				success: function(data) {
					$("#budget_num").text("");
					values = data.budgetList;
					output = "";
					$.each(values, function(index, value) {
						
						
						output += "<option value='"+ value.budget_num + "''>";
						output += value.budget_cls;
						output += "</option>";
					});
					
					$("#budget_num").html(output);
					$("#budget_num").show();
				}
				
			})
		}
	}
}


function select_search_type() { // 검색 타입을 선택했을 때
	var finance_year = $("#finance_year").val();
	var finance_type = $("#finance_type").val();
	var search_type = $("#search_type").val();
	
	if (finance_year != "") {
		if (search_type == "budget_name") { // 검색 타입이 예산 항목 일때
			
			$.ajax({
				url : "/ius/finance/get_budget_list",
				type : "POST",
				data : {
					finance_year : finance_year,
					finance_type : finance_type
				},
				success: function(data) {
					$("#budget_num").text("");
					values = data.budgetList;
					output = "";
					$.each(values, function(index, value) {
						
						
						output += "<option value='"+ value.budget_num + "''>";
						output += value.budget_cls;
						output += "</option>";
					});
					
					$("#budget_num").html(output);
					$("#search_content").hide();
					$("#budget_num").show();
					$("#search_date").hide();
				}
				
			})
		} else if (search_type == "") { // 미선택시
			$("#search_content").hide();
			$("#budget_num").hide();
			$("#search_date").hide();
		} else if ((search_type == "finance_code") || (search_type == "finance_cls")) { // 재정 코드, 항목명 선택시 
			$("#search_content").show();
			$("#budget_num").hide();
			$("#search_date").hide();	
		} else if (search_type == "finance_eDate") {// 집행 날짜 선택시
			$("#search_content").hide();
			$("#budget_num").hide();
			$("#search_date").show();	
		}
	}
	
}

function select_finance_type() { // 재정타입을 선택했을 때
	var finance_year = $("#finance_year").val();
	var finance_type = $("#finance_type").val();
	var search_type = $("#search_type").val();
	
	if (finance_year != "") {
		if (search_type == "budget_name") { // 검색 타입이 예산 항목 일때
			
			$.ajax({
				url : "/ius/finance/get_budget_list",
				type : "POST",
				data : {
					finance_year : finance_year,
					finance_type : finance_type
				},
				success: function(data) {
					$("#budget_num").text("");
					values = data.budgetList;
					output = "";
					$.each(values, function(index, value) {
						
						
						output += "<option value='"+ value.budget_num + "''>";
						output += value.budget_cls;
						output += "</option>";
					});
					
					$("#budget_num").html(output);
					$("#budget_num").show();
				}
				
			})
		}
	}
	
}





$(function(){
	function getList() {
		$.ajax({
			url : "/ius/finance/get_finance_list",
			type : "POST",
			data : {
				
			},
			success: function(data) {
				$("#list").text("");
				values = data.financeList;
				output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 항목</th><th>교직원명</th><th>집행 날짜</th><th>항목</th><th>구분</th><th>집행 금액</th></tr>";				
				$.each(values, function(index, value) {
					
					if (value.finance_iE == 'In') {
						financeType = '수입';
					} else if (value.finance_iE == 'Ex') {
						financeType = '지출';
					}
					
					output += "<tr>";
					output += "<td>" + value.finance_num + "</td>";
					output += "<td>" + value.finance_eYear + "</td>";
					output += "<td>" + value.budget_cls + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.finance_eDate + "</td>";
					output += "<td><a href='../finance/finance_info?finance_num=" + value.finance_num + "'>" + value.finance_cls + "</a></td>";
					output += "<td>" + financeType + "</td>";
					output += "<td>" + addComma(value.finance_amount) + "</td>";
					output += "</tr>";
				});
				
				$("#list").html(output);
				page();
			}
			
		})
		
	}
	getList();
	$("#searchBtn").click(function(){ // 검색 기능
		var finance_year = $("#finance_year").val();
		var finance_type = $("#finance_type").val();
		var search_type = $("#search_type").val();
		var search_content = $("#search_content").val();
		var budget_num = $("#budget_num").val();
		var search_date = $("#search_date").val();
		
		if (search_type == "") { // 검색 타입이 미선택 일시.
			
			if ($("#finance_year").val() == "") {
				alert("년도를 선택하세요.");
				$("#finance_year").val().focus();
				return;
			};
				
			var objParams = {
					seachYear : finance_year,
					finance_type : finance_type
			}
			
			var values = [];
			
			$.post(
				"/ius/finance/get_finance_list_by_year",
				objParams,
				function(retVal) {
					$("#list").text("");
					$("#totalIncome").text("");
					$("#totalExpense").text("");
					$("#balance").text("");
		
					values = retVal.financeList;
					
					if (values.length > 0 ) {
						alert("성공적으로 데이터를 조회했습니다.");
					} else {
						alert("조회할 데이터가 없습니다.");
					}

					totalIncome = retVal.totalIncome;
					totalExpense = retVal.totalExpense;
					balance = (totalIncome-totalExpense);
					
					output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 항목</th><th>교직원명</th><th>집행 날짜</th><th>항목</th><th>구분</th><th>집행 금액</th></tr>";				
					$.each(values, function(index, value) {
						if (value.finance_iE == 'In') {
							financeType = '수입';
						} else if (value.finance_iE == 'Ex') {
							financeType = '지출';
						}
						
						
						output += "<tr>";
						output += "<td>" + value.finance_num + "</td>";
						output += "<td>" + value.finance_eYear + "</td>";
						output += "<td>" + value.budget_cls + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "<td>" + value.finance_eDate + "</td>";
						output += "<td><a href='../finance/finance_info?finance_num=" + value.finance_num + "'>" + value.finance_cls + "</a></td>";
						output += "<td>" + financeType + "</td>";
						output += "<td>" + addComma(value.finance_amount) + "</td>";
						output += "</tr>";
					});
					
					$("#totalIncome").html(addComma(totalIncome));
					$("#totalExpense").html(addComma(totalExpense));
					$("#balance").html(addComma(balance));
					$("#list").html(output);
					
					page();
				}
			)
			
			
		} else {
			
			$.ajax({
				url : "/ius/finance/search_finance",
				type : "POST",
				data : {
					finance_year : finance_year,
					finance_type  : finance_type,
					search_type : search_type,
					search_content : search_content,
					budget_num : budget_num,
					search_date : search_date
				},
				success: function(data) {
					$("#list").text("");
					
					values = data.financeList;
					
					if (values.length > 0 ) {
						alert("성공적으로 데이터를 조회했습니다.");
					} else {
						alert("조회할 데이터가 없습니다.");
					}
					
					output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 항목</th><th>교직원명</th><th>집행 날짜</th><th>항목</th><th>구분</th><th>집행 금액</th></tr>";				
					$.each(values, function(index, value) {
						if (value.finance_iE == 'In') {
							financeType = '수입';
						} else if (value.finance_iE == 'Ex') {
							financeType = '지출';
						}
						
						
						output += "<tr>";
						output += "<td>" + value.finance_num + "</td>";
						output += "<td>" + value.finance_eYear + "</td>";
						output += "<td>" + value.budget_cls + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "<td>" + value.finance_eDate + "</td>";
						output += "<td><a href='../finance/finance_info?finance_num=" + value.finance_num + "'>" + value.finance_cls + "</a></td>";
						output += "<td>" + financeType + "</td>";
						output += "<td>" + addComma(value.finance_amount) + "</td>";
						output += "</tr>";
					});
					
					$("#totalIncome").html(addComma(totalIncome));
					$("#totalExpense").html(addComma(totalExpense));
					$("#balance").html(addComma(balance));
					$("#list").html(output);
					
					page();
				}
				
			})
		}
		
		
		
		
	});
	
	$("#inRegister").click(function(){ // 재정 수입 및 지출 등록은 관리자만 가능
		var master = getCookie("master");
	
		if (master == "N") { // 권한이 없는 경우
			alert("권한이 없습니다.");
			return;
		} else if (master == "Y") { 
			location.href='../finance/finance_register_form?iE=In';
		};
		
	});
	
	$("#exRegister").click(function(){ // 재정 수입 및 지출 등록은 관리자만 가능
		var master = getCookie("master");
	
		if (master == "N") { // 권한이 없는 경우
			alert("권한이 없습니다.");
			return;
		} else if (master == "Y") { 
			location.href='../finance/finance_register_form?iE=Ex';
		};
		
	});
	
	
	
	
	
	
})
</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>재정 관리</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="예산 항목" onclick="location.href='../budget/budget_list'">
						<input type="button" value="수입 등록" id="inRegister">
						<input type="button" value="지출 등록" id="exRegister">
					</div>
				
					<div id="search">
						<select name="finance_year" id="finance_year" onchange="select_finance_year()">
							<option value="">--년도--</option>
							<c:if test="${financeYearList != null}">
								<c:forEach items="${financeYearList}" var="financeYear">
									<option value="${financeYear}">${financeYear}년도</option>
								</c:forEach>	
							</c:if>
						</select>
						
						<select name="finance_type" id="finance_type" onchange="select_finance_type()">
							<option value="total">전체</option>
							<option value="In">수입</option>
							<option value="Ex">지출</option>
						</select>		
						
						<select name="search_type" id="search_type" onchange="select_search_type()">
							<option value="">미선택</option>
							<option value="finance_code">재정 코드</option>
							<option value="budget_name">예산 항목</option>
							<option value="finance_eDate">집행 날짜</option>
							<option value="finance_cls">항목명</option>
						</select>
						
						<input type="text" id="search_content" style="display : none;">
						
						<select id="budget_num" style="display : none;">	
						</select>
						
						<input type="date" id="search_date" style="display : none;">
						
						<input type="button" value="검색" id="searchBtn">		
					</div>
					
					<br>
					
					
					<table border="1" id="finalAccount">
						<tr>
							<th>회계 년도</th>
							<th>총 수입</th>
							<th>총 지출</th>
							<th>잔액</th>
						</tr>	
						<tr>
							<td id="financeYear"></td>
							<td id="totalIncome"></td>
							<td id="totalExpense"></td>
							<td id="balance"></td>
						</tr>
					</table>
					<table border="1" id="list" class="tbl paginated"></table>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>