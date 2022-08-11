<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};

function getList() { // 원생 리스트 가져오기
	$.ajax({
		url : "/ius/kinder/get_kinder_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#kinder_list_tbl").text("");
			values = data.kinderList;
			output = "<tr><th>원생 번호</th><th>원생 이름</th><th>학급명</th><th>담당 교사</th></tr>";				
			$.each(values, function(index, value) {
	
				output += "<tr>";
				output += "<td>" + value.kinder_num + "</td>";
				output += "<td><a href=\"javascript:view(" + value.kinder_num + ");\">" + value.kinder_name + "</a></td>";
				output += "<td>" + value.class_name + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "</tr>";
			});
			
			$("#kinder_list_tbl").html(output);
		}
		
	})
	
}
getList();

function view(kinder_num) { // 원생별 수납내역 조회
	
	var authCode = getCookie("auth_cookie");
	$("#auth_info").val(authCode);
	
	var kinder_num = kinder_num;
	
	$.ajax({
		url : "/ius/receipt/get_receipt_by_kinder_num",
		type : "POST",
		data : {
			kinder_num : kinder_num
		},
		success : function(data) {
			$("#receipt_tbl").html("");
			
			
			$("#receipt").hide();
			$("#date_from").val("");
			$("#date_to").val("");
			$("#kinder_name").val(data.kinder_name);
			$("#relation").val("");
			$("#parent_num").val("");
			$("#parent_name").val("");
			$("#receipt_code").val("");
			$("#receipt_content").val("");
			$("#receipt_price").val("");
			$("#kinder_num").val(kinder_num);
			
			values = data.receiptInfo;
			if(values.length != 0) {
				output = "<tr><th>수납 일시</th><th>원생 이름</th><th>가족 관계</th><th>수납자</th><th style='width : 480px; height : auto;'>수납 내용</th><th>수납 금액</th></tr>";
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td>" + value.receipt_date + "</td>";
					output += "<td>" + value.kinder_name + "</td>";
					output += "<td>" + value.relation + "</td>";
					output += "<td>" + value.parent_name + "</td>";
					output += "<td><a href=\"javascript:getReceipt(" + value.receipt_code + ");\">" + value.receipt_content + "</a></td>";
					output += "<td>" + addComma(value.receipt_price) + "원</td>";
					output += "</tr>";
				});
				
				
				$("#receipt_tbl").html(output);
			}		
			
			$("#receipt").show();		
		}		
	})
};

function getReceipt(receipt_code) { // 정보 수정이나 삭제를 위해 수납 내역을 가져옴
	var receipt_code = receipt_code;
	
	$.ajax({
		url : "/ius/receipt/get_receipt_by_receipt_code",
		type : "POST",
		data : {
			receipt_code : receipt_code
		},
		success : function(data) {
			$("#receipt_code").val("");
			$("#kinder_num").val("");
			$("#kinder_name").val("");
			$("#relation").val("");
			$("#parent_num").val("");
			$("#parent_name").val("");
			$("#receipt_content").val("");
			$("#receipt_price").val("");
			
			value = data.receiptInfo;
			$("#receipt_code").val(value.receipt_code);
			$("#kinder_num").val(value.kinder_num);
			$("#kinder_name").val(value.kinder_name);
			$("#relation").val(value.relation);
			$("#parent_num").val(value.parent_num);
			$("#parent_name").val(value.parent_name);
			$("#receipt_content").val(value.receipt_content);
			$("#receipt_price").val(value.receipt_price);

		}		
	})
	
}





$(function(){
	
	//키를 누르거나 떼었을때 이벤트 발생
    $("#receipt_price").bind('keyup keydown',function(){
        inputNumberFormat(this);
    });

    //입력한 문자열 전달
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    };
      
    //콤마찍기
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    };

    //콤마풀기
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    };

    //숫자만 리턴(저장할때)
    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
    function cf_getNumberOnly (str) {
        var len      = str.length;
        var sReturn  = "";

        for (var i=0; i<len; i++){
            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
                sReturn += str.charAt(i);
            }
        }
        return sReturn;
    };
	
	$("#searchBtn").click(function(){ // 원생 검색기능.
		
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		
		$.ajax({
			url : "/ius/attendance/search_kinder",
			type : "POST",
			data : {
				searchType : searchType,
				searchContent : searchContent
			},
			success : function(data) {
				$("#kinder_list_tbl").text("");
				values = data.kinderList;
				output = "<tr><th>원생 번호</th><th>원생 이름</th><th>학급명</th><th>담당 교사</th></tr>";
				
				if (values.length == 0) {
					alert("조회된 데이터가 없습니다.");
				} else {
					$.each(values, function(index, value) {
						
						output += "<tr>";
						output += "<td>" + value.kinder_num + "</td>";
						output += "<td><a href=\"javascript:view(" + value.kinder_num + ");\">" + value.kinder_name + "</a></td>";
						output += "<td>" + value.class_name + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "</tr>";
					});
				}
				$("#kinder_list_tbl").html(output);
			
			}
		})
			
	});
	
	$("#selectBtn").click(function(){ // 원생 수납내역 날짜별조회
		if ($("#date_from").val() == "") {
			alert("조회 시작 날짜를 입력해주세요");
			return;
		};
		if ($("#date_to").val() == "") {
			alert("조회 끝 날짜를 입력해주세요");
			return;
		};
		
		var kinder_num = $("#kinder_num").val();
		var date_from = $("#date_from").val();
		var date_to = $("#date_to").val();
		
		$.ajax({
			url : "/ius/receipt/select_receipt",
			type : "POST",
			data : {
				kinder_num : kinder_num,
				date_from : date_from,
				date_to : date_to
			},
			success : function(data) {
				$("#receipt").hide();
				$("#receipt_tbl").text("");
				values = data.receiptInfo;

				if (values.length == 0) {
					alert("조회된 데이터가 없습니다.");
					
				} else {
					alert("성공적으로 데이터를 조회했습니다.");
					
					output = "<tr><th>수납 일시</th><th>원생 이름</th><th>가족 관계</th><th>수납자</th><th style='width : 480px; height : auto;'>수납 내용</th><th>수납 금액</th></tr>";
					$.each(values, function(index, value) {
						
						output += "<tr>";
						output += "<td>" + value.receipt_date + "</td>";
						output += "<td>" + value.kinder_name + "</td>";
						output += "<td>" + value.relation + "</td>";
						output += "<td>" + value.parent_name + "</td>";
						output += "<td><a href=\"javascript:getReceipt(" + value.receipt_code + ");\">" + value.receipt_content + "</a></td>";
						output += "<td>" + addComma(value.receipt_price) + "원</td>";
						output += "</tr>";
					});
					
					$("#receipt_tbl").html(output);
				}
				
				$("#receipt").show();
			
			}
		})	
		
	});
	
	$("#relation").change(function(){ // 가족관계 선택시 해당 데이터를 조회하여 부모님 성함을 받아옴
		
		var kinder_num  = $("#kinder_num").val();
		var relation = $("#relation").val();
		
		if (relation != "") {
			
			$.ajax({
				url : "/ius/consult/select_parent_num_name",
				type : "POST",
				data : {
					kinder_num : kinder_num,
					relation : relation
				},
				success : function(data) {
					$("#parent_num").val("");
					$("#parent_name").val("");
					
					if(data.parentInfo == null) {
						alert("해당 부모 정보가 없습니다.");
						$("#realtion").val("");
						$("#basic").prop("selected", true);
					}
					var parent_num = data.parentInfo.parent_num;
					var parent_name = data.parentInfo.parent_name;
					
					$("#parent_num").val(parent_num);
					$("#parent_name").val(parent_name);
					
				}
			})
		} else {
			$("#parent_name").val("");
		}
				
});
	
	
	$("#register").click(function(){ // 수납내역 등록시 - 수정데이터인지 판단. 수납 내역 수정, 삭제는 관리자 권한을 가진 사람만 가능.
		
		value = cf_getNumberOnly ($("#receipt_price").val());
		$("#receipt_price").val(value);
		
		
		var receipt_code = $("#receipt_code").val();
		var kinder_num = $("#kinder_num").val();
		var parent_num = $("#parent_num").val();
		var receipt_content = $("#receipt_content").val();
		var receipt_price = $("#receipt_price").val();
		var auth_info = $("#auth_info").val();
			
		if (parent_num != "") {
			if (receipt_code == "") { // 등록
				$.ajax({
					url : "/ius/receipt/register_receipt",
					type : "POST",
					data : {
						kinder_num : kinder_num,
						parent_num : parent_num,
						receipt_content : receipt_content,
						receipt_price : receipt_price
					},
					success : function(data) {
						alert("수납 내역이 등록되었습니다.");
						
						$("#parent_num").val("");
						$("#parent_name").val("");
						$("#relation").val("");
						$("#basic").prop("selected", true);
						$("#receipt_content").val("");
						$("#receipt_price").val("");
						view(kinder_num);
					}
				})	
				
			} else { // 수정 일 때
				
				if (auth_info != "M") { // 마스터 권한을 가진 사람이 아니라면 삭제 불가
					alert("수납 내역 수정 권한이 없습니다.");
				} else { // 관리자 권한을 가진 사람인 경우
					$.ajax({
						url : "/ius/receipt/update_receipt",
						type : "POST",
						data : {
							receipt_code : receipt_code,
							kinder_num : kinder_num,
							parent_num : parent_num,
							receipt_content : receipt_content,
							receipt_price : receipt_price
						},
						success : function(data) {
							alert("수납 내역이 수정되었습니다.");
							
							$("#parent_num").val("");
							$("#parent_name").val("");
							$("#relation").val("");
							$("#basic").prop("selected", true);
							$("#receipt_content").val("");
							$("#receipt_price").val("");
							view(kinder_num);
						}
					})	
	
				}
				
			}
			
		} else {
			alert('수납자 정보가 없습니다.');
		}
			
	});
	
	$("#delete").click(function(){ // 수납내역 삭제시 마스터 권한을 가진 관리자만 가능.
		var receipt_code = $("#receipt_code").val();
		var auth_info = $("#auth_info").val();
		var kinder_num = $("#kinder_num").val();
		
		if (receipt_code == "") {
			alert("삭제할 정보가 없습니다.");
		} else {
			if (auth_info != "M") { // 관리자 권한이 아닌 경우
				alert("수납 내역은 관리자만 삭제할 수 있습니다.")
			} else { // 본인인 경우
				var input = confirm("정말 삭제하시겠습니까?");
				
				if (input === true) {
					$.ajax({
						url : "/ius/receipt/delete_receipt",
						type : "POST",
						data : {
							receipt_code : receipt_code
						},
						success : function(data) {
							alert("수납 내역이 삭제되었습니다.");
							
							$("#parent_num").val("");
							$("#parent_name").val("");
							$("#relation").val("");
							$("#basic").prop("selected", true);
							$("#receipt_content").val("");
							$("#receipt_price").val("");
							view(kinder_num);
						}
					})	
					
				} else {
					alert("삭제가 취소되었습니다.");
				}
			
			
				
				
				
			}
			
			
			
		}
		
	});
	
	
	


})
</script>
<title>수납 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관라</p>
				<h3>수납 관리</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="원생 관리" onclick="location.href='../kinder/kinder_list'">
					</div>
					
					<div id="kinder_list" style="float: left;">
						<div id="searchBts">
							<select id="searchType">
								<option value="kinder_num">원생 번호</option>
								<option value="kinder_name">원생 이름</option>
								<option value="class_name">학급명</option>
								<option value="staff_name">담당 교사</option>
							</select>
							<input type="text" id="searchContent">
							<input type="button" value="검색" id="searchBtn">
						</div>
						<table id="kinder_list_tbl" border="1"></table>
					</div>
					
					<div id="receipt" style="float: left; display:none;">
						<div id="selectBts">
							<input type="date" id="date_from">
							<input type="date" id="date_to">
							<input type="button" value="조회" id="selectBtn"> 
						</div>
						
						<table id="receipt_tbl" border="1"></table>
						<table id="receipt_register_tbl" border="1">
							<tr>
								<th>원생명</th>
								<td>
									<input type="hidden" id="auth_info" name="auth_info">
									<input type="hidden" id="receipt_code" name="receipt_code">
									<input type="text" id="kinder_name" name="kinder_name" readonly="readonly" style='text-align : center;'>
									<input type="text" id="kinder_num" name="kinder_num">
								</td>
								<th colspan="2">가족 관계</th>
								<td>
									<select id="relation" name="relation">
										<option value="" id="basic">-선택-</option>
										<option value="부">부</option>
										<option value="모">모</option>
									</select>
								</td>
								<th>수납자</th>
								<td>
									<input type="text" id="parent_name" name="parent_name" readonly="readonly">
									<input type="hidden" id="parent_num" name="parent_num">
								</td>
							</tr>
							<tr>
								<th colspan="3" >수납 내용</th>
								<td colspan="5" >
									<input type="text" id="receipt_content" name="receipt_content">
								</td>
							</tr>
							<tr>
								<th colspan="3" >수납 금액</th>
								<td colspan="5">
									<input type="text" id="receipt_price" name="receipt_price">
								</td>
							</tr>	
							<tr>
								<td colspan="8">
									<input type="button" value="등록" id="register">
									<input type="button" value="삭제" id="delete">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>