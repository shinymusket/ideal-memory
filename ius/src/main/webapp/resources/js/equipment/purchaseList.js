function selSearchType() { // 검색타입 변경
	var searchType = $("#searchType").val();
	
	if (searchType == "purchase_date") { // 구매 날짜 타입
		$("#searchContent").hide();
		$("#searchDate").show();
	} else {
		$("#searchContent").show();
		$("#searchDate").hide();
	}
};


function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};

// ajax로 테이블리스트 생성
function loadData() {
	
	$.ajax({
		url : "/ius/equipment/get_purchase_list",
		type : "POST",
		data : {
			
		},
		success : function(data) {
			$("#purchaseList").text("");
			values = data.purchaseList;
			output = "<thead><tr><th>구매 번호</th><th>재정 코드</th><th>구매자</th><th>구매 자산 번호</th><th>구매 자산 명</th><th>구매 일자</th><th>총 구매 가격</th><th>구매 수량</th></tr></thead>";
			$.each(values, function(index, value) {
				
				output += "<tbody><tr>";
				output += "<td>" + value.purchase_num + "</td>";
				output += "<td>" + value.finance_num + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td>" + value.equipment_num + "</td>";
				output += "<td><a href='../equipment/purchase_info?purchase_num=" + value.purchase_num + "'>" + value.equipment_name + "</a></td>";
				output += "<td>" + value.purchase_date + "</td>";
				output += "<td>" + addComma(value.purchase_price) + "</td>";
				output += "<td>" + value.purchase_count + "</td>";
				output += "</tr></tbody>";
			});
			
			$("#purchaseList").html(output);
			page();
		}
	});
};
	
loadData();
/* function getList() {
	$.ajax({
		url : "/ius/equipment/get_purchase_list",
		type : "POST",
		data :  {
			
		},
		success: function(data) {
			$("#purchaseList").text("");
			values = data.purchaseList;
			output = "<tr><th>구매 번호</th><th>재정 코드</th><th>구매자</th><th>구매 자산 번호</th><th>구매 자산 명</th><th>구매 일자</th><th>총 구매 가격</th><th>구매 수량</th></tr>";
			$.each(values, function(index, value) {
				
				output += "<tr>";
				output += "<td>" + value.purchase_num + "</td>";
				output += "<td>" + value.finance_num + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td>" + value.equipment_num + "</td>";
				output += "<td><a href='../equipment/purchase_info?purchase_num=" + value.purchase_num + "'>" + value.equipment_name + "</a></td>";
				output += "<td>" + value.purchase_date + "</td>";
				output += "<td>" + addComma(value.purchase_price) + "</td>";
				output += "<td>" + value.purchase_count + "</td>";
				output += "</tr>";
			});
			
			$("#purchaseList").html(output);
		
		}
	})

};

getList(); */

// 만들어진 테이블에 페이지 처리
function page(){ 
	
	var reSortColors = function($table) {
	  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
	  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
	 };
	 $('table.paginated').each(function() {
	  var pagesu = 10;  //페이지 번호 갯수
	  var currentPage = 0;
	  var numPerPage = 10;  //목록의 수
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
}

$(function(){
	
	$("#searchBtn").click(function(){ // 검색
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		var searchDate = $("#searchDate").val();
		
		$.ajax({
			url : "/ius/equipment/search_purchase_list",
			type : "POST",
			data : {
				searchType : searchType,
				searchContent : searchContent,
				searchDate : searchDate
			},
			success : function(data) {
				$("#purchaseList").text("");
			 	values = data.purchaseList;
				output = "<thead><tr><th>구매 번호</th><th>재정 코드</th><th>구매자</th><th>구매 자산 번호</th><th>구매 자산 명</th><th>구매 일자</th><th>총 구매 가격</th><th>구매 수량</th></tr></thead>";
				$.each(values, function(index, value) {
					
					output += "<tbody><tr>";
					output += "<td>" + value.purchase_num + "</td>";
					output += "<td>" + value.finance_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.equipment_num + "</td>";
					output += "<td><a href='../equipment/purchase_info?purchase_num=" + value.purchase_num + "'>" + value.equipment_name + "</a></td>";
					output += "<td>" + value.purchase_date + "</td>";
					output += "<td>" + addComma(value.purchase_price) + "</td>";
					output += "<td>" + value.purchase_count + "</td>";
					output += "</tr></tbody>";
				});
				
				$("#purchaseList").html(output);
				page();
				alert("검색한 데이터를 불러왔습니다.");
			}
		});
		
		
	});
	
})