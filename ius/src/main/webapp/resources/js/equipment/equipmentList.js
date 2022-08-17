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


function getInfo(equipment_num) {
	location.href = "../equipment/equipment_info?equipment_num=" + equipment_num;
}


function getList() {
		$.ajax({
			url : "/ius/equipment/get_equipment_list",
			type : "POST",
			data :  {
				
			},
			success: function(data) {
				$("#equipmentList").text("");
				values = data.equipmentList;

				output = "<thead><tr><th>자산 번호</th><th>등록자</th><th>분류</th><th>비품명</th><th>수량</th><th>취득일자</th><th>구분</th></tr></thead>";
				$.each(values, function(index, value) {
					
					output += "<tbody><tr class='bgc' onclick='getInfo(" + value.equipment_num + ")'>";
					output += "<td>" + value.equipment_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.equip_cls_name + "</td>";
					output += "<td>" + value.equipment_name + "</td>";
					output += "<td>" + value.equipment_count + "</td>";
					output += "<td>" + value.equipment_regdate + "</td>";
					output += "<td>" + value.equipment_cate + "</td>";
					output += "</tr></<tbody>";
				});
				
				$("#equipmentList").html(output);
				page();
			
			}
		})
	
	};

	getList();
	
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
	
	function changeSearchType() { // 검색타입 변환시
		
		var searchType = $("#searchType").val();
		
		if( searchType == "equip_cls_name") { // 검색 타입이 분류명인 경우.
			$("#searchContent").hide();
			$("#searchDate").hide();
			$("#equip_cls_num").show();
			$("#equipment_cate").hide();
		} else if (searchType == "equipment_regdate") { // 검색 타입이 취득날짜인 경우.
			$("#searchContent").hide();
			$("#searchDate").show();
			$("#equip_cls_num").hide();
			$("#equipment_cate").hide();
		} else if (searchType == "equipment_cate") { // 검색 타입이 구분인 경우.
			$("#searchContent").hide();
			$("#searchDate").hide();
			$("#equip_cls_num").hide();
			$("#equipment_cate").show();
		} else { // 그 외에
			$("#searchContent").show();
			$("#searchDate").hide();
			$("#equip_cls_num").hide();
			$("#equipment_cate").hide();
		};
	};
	
	function getInfo(equipment_num) {
		location.href="../equipment/equipment_info?equipment_num=" + equipment_num;
	};
	
	
	
$(function(){
	$("#searchBtn").click(function(){ // 검색 기능.
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		var searchDate = $("#searchDate").val();
		var equip_cls_num = $("#equip_cls_num").val();
		var equipment_cate = $("#equipment_cate").val();
		
		
		$.ajax({
			url : "/ius/equipment/search_equipment_list",
			type : "POST",
			data :  {
				searchType : searchType,
				searchContent : searchContent,
				searchDate : searchDate,
				equip_cls_num : equip_cls_num,
				equipment_cate : equipment_cate
			},
			success: function(data) {
				$("#equipmentList").text("");
				values = data.equipmentList;
				
				if (values.length > 0) {
					alert("성공적으로 데이터를 조회 했습니다.");
				} else {
					alert("조회할 데이터가 없습니다.");
				};
				
				output = "<thead><tr><th>자산 번호</th><th>등록자</th><th>분류</th><th>비품명</th><th>수량</th><th>취득일자</th><th>구분</th></tr></thead>";
				$.each(values, function(index, value) {
					
					output += "<tbody><tr class='bgc' onclick='getInfo(" + value.equipment_num + ")'>";
					output += "<td>" + value.equipment_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.equip_cls_name + "</td>";
					output += "<td>" + value.equipment_name + "</td>";
					output += "<td>" + value.equipment_count + "</td>";
					output += "<td>" + value.equipment_regdate + "</td>";
					output += "<td>" + value.equipment_cate + "</td>";
					output += "</tr></<tbody>";
				});
				
				$("#equipmentList").html(output);
				page();
			
			}
		})
		
		
	});

	$("#equipRegister").click(function(){ // 시설(비품) 등록시 시설 권한이 있는지 유무 체크확인.
		var facility = getCookie("facility");
	
		console.log(facility);
		
		if (facility == "N") { // 시설 권한이 없으면 등록 불가.
			alert("권한이 없습니다.");
		} else if (facility == "Y") { 
			location.href='../equipment/equipment_register_form';
		}
	});
	
	$("#purchaseRegister").click(function(){ // 구매품 등록시 시설 권한이 있는지 유무 체크확인.
		var facility = getCookie("facility");
	
		console.log(facility);
		
		if (facility == "N") { // 시설 권한이 없으면 등록 불가.
			alert("권한이 없습니다.");
		} else if (facility == "Y") { 
			location.href='../equipment/purchaseEquip_form'
		}
	});
	
	
})