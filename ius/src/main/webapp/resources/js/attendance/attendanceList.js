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

function getList() {
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
				output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
				output += "<td>" + value.kinder_num + "</td>";
				output += "<td>" + value.kinder_name + "</td>";
				output += "<td>" + value.class_name + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "</tr>";
			});
			
			$("#kinder_list_tbl").html(output);
		}
		
	})
	
}
getList();

function view(kinder_num) {
	var kinder_num = kinder_num;
	$("#kinder_num").val(kinder_num);
	
	$.ajax({
		url : "/ius/attendance/get_attendance_by_kinder_num",
		type : "POST",
		data : {
			kinder_num : kinder_num
		},
		success : function(data) {
			$("#attendance").hide();
			$("#attendance_tbl").text("");
			values = data.attendanceList;
			output = "<thead><tr><th>일시</th><th>출결 정보</th><th>등원시간</th><th>하원시간</th></tr></thead>";				
			$.each(values, function(index, value) {
				
				attend_info = value.attend_info;
				
				if (attend_info == "T") {
					attend_info = "출석";
				} else if (attend_info == "B") {
					attend_info = "결석";
				} else if (attend_info == "L") {
					attend_info = "지각";
				} else if (attend_info == "E") {
					attend_info = "조퇴";
				}; 	
				
				if (value.in_time == null) {
					value.in_time = "";
				};
				if (value.out_time == null) {
					value.out_time = "";
				};
				
				
				output += "<tbody><tr>";
				output += "<td>" + value.attend_date + "</td>";
				output += "<td>" + attend_info + "</td>";
				output += "<td>" + value.in_time + "</td>";
				output += "<td>" + value.out_time + "</td>";
				output += "</tr></tbody>";
			});
			
			$("#attendance_tbl").html(output);
			$("#attendance").show();
			page();
			
		}
	})
	
};

$(function(){
	$("#searchBtn").click(function(){
		
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
				$.each(values, function(index, value) {
		
					output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
					output += "<td>" + value.kinder_num + "</td>";
					output += "<td>" + value.kinder_name + "</td>";
					output += "<td>" + value.class_name + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "</tr>";
				});
				
				$("#kinder_list_tbl").html(output);
				
			}
		})
			
	});
	
	$("#selectBtn").click(function(){
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
			url : "/ius/attendance/select_attendance",
			type : "POST",
			data : {
				kinder_num : kinder_num,
				date_from : date_from,
				date_to : date_to
			},
			success : function(data) {
				$("#attendance").hide();
				$("#attendance_tbl").text("");
				values = data.attendanceList;
				output = "<thead><tr><th>일시</th><th>출결 정보</th><th>등원시간</th><th>하원시간</th></tr></thead>";				
				$.each(values, function(index, value) {
					
					attend_info = value.attend_info;
					
					if (attend_info == "T") {
						attend_info = "출석";
					} else if (attend_info == "B") {
						attend_info = "결석";
					} else if (attend_info == "L") {
						attend_info = "지각";
					} else if (attend_info == "E") {
						attend_info = "조퇴";
					}; 	
					
					if (value.in_time == null) {
						value.in_time = "";
					};
					if (value.out_time == null) {
						value.out_time = "";
					};
					
					output += "<tbody><tr>";
					output += "<td>" + value.attend_date + "</td>";
					output += "<td>" + attend_info + "</td>";
					output += "<td>" + value.in_time + "</td>";
					output += "<td>" + value.out_time + "</td>";
					output += "</tr></tbody>";
				});
				
				$("#attendance_tbl").html(output);
				$("#attendance").show();
				page();
			}
		})
		
		
		
	});
	
	
	
})