//만들어진 테이블에 페이지 처리
function page(){ 
	
	var reSortColors = function($table) {
	  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
	  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
	 };
	 $('table.paginated').each(function() {
	  var pagesu = 10;  //페이지 번호 갯수
	  var currentPage = 0;
	  var numPerPage = 5;  //목록의 수
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

function view(kinder_num) { // 원생별 상담내역 조회
	var kinder_num = kinder_num;
	$("#kinder_num").val(kinder_num);
	var login_staff_name = document.getElementById('login_staff_name').value;
	var login_staff_num = document.getElementById('login_staff_num').value;
	
	$.ajax({
		url : "/ius/consult/get_consult_by_kinder_num",
		type : "POST",
		data : {
			kinder_num : kinder_num
		},
		success : function(data) {
			$("#date_from").val("");
			$("#date_to").val("");
			$("#staff_name").val(login_staff_name);
			$("#staff_num").val(login_staff_num);
			$("#kinder_name").val(data.kinder_name);
			$("#relation").val("");
			$("#parent_num").val("");
			$("#parent_name").val("");
			$("#consult_code").val("");
			$("#consult_content").val("");
			
			values = data.consultInfo;
			$("#consult_tbl").text("");
			if(values.length != 0) {
				output = "<thead><tr><th>상담 일시</th><th>상담자</th><th>원생 이름</th><th>가족 관계</th><th>내담자</th><th style='width : 480px; height : auto;'>상담 내용</th></tr></thead>";
				$.each(values, function(index, value) {
					
					output += "<tbody><tr>";
					output += "<td>" + value.consult_date + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.kinder_name + "</td>";
					output += "<td>" + value.relation + "</td>";
					output += "<td>" + value.parent_name + "</td>";
					output += "<td><a href=\"javascript:getConsult(" + value.consult_code + ");\">" + value.consult_content + "</a></td>";
					output += "</tr></tbody>";
				});
				
				
				$("#consult_tbl").html(output);
			}		
			
			$("#consult").show();
			page();
		}		
	})
};

function getConsult(consult_code) { // 정보 수정이나 삭제를 위해 상담 내용을 가져옴
	var consult_code = consult_code;
	
	$.ajax({
		url : "/ius/consult/get_consult_by_consult_code",
		type : "POST",
		data : {
			consult_code : consult_code
		},
		success : function(data) {
			$("#consult_code").val("");
			$("#staff_num").val("");
			$("#staff_name").val("");
			$("#kinder_num").val("");
			$("#kinder_name").val("");
			$("#relation").val("");
			$("#parent_num").val("");
			$("#parent_name").val("");
			$("#consult_content").val("");
			
			value = data.consultInfo;
			$("#consult_code").val(consult_code);
			$("#staff_num").val(value.staff_num);
			$("#staff_name").val(value.staff_name);
			$("#kinder_num").val(value.kinder_num);
			$("#kinder_name").val(value.kinder_name);
			$("#relation").val(value.relation);
			$("#parent_num").val(value.parent_num);
			$("#parent_name").val(value.parent_name);
			$("#consult_content").val(value.consult_content);

		}		
	})
	
}





$(function(){
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
						
						output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
						output += "<td>" + value.kinder_num + "</td>";
						output += "<td>" + value.kinder_name + "</td>";
						output += "<td>" + value.class_name + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "</tr>";
					});
				}
				$("#kinder_list_tbl").html(output);
			
			}
		})
			
	});
	
	$("#selectBtn").click(function(){ // 원생상담일지 날짜별조회
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
			url : "/ius/consult/select_consult",
			type : "POST",
			data : {
				kinder_num : kinder_num,
				date_from : date_from,
				date_to : date_to
			},
			success : function(data) {
				$("#consult").hide();
				$("#consult_tbl").text("");
				values = data.consultInfo;
				
				/* console.log(values.length); */
				if (values.length == 0) {
					alert("조회된 데이터가 없습니다.");
					
				} else {
					alert("성공적으로 데이터를 조회했습니다.");
					
					output = "<thead><tr><th>상담 일시</th><th>상담자</th><th>원생 이름</th><th>가족 관계</th><th>내담자</th><th style='width : 480px; height : auto;'>상담 내용</th></tr></thead>";				
					$.each(values, function(index, value) {
						
						output += "<tbody><tr>";
						output += "<td>" + value.consult_date + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "<td>" + value.kinder_name + "</td>";
						output += "<td>" + value.relation + "</td>";
						output += "<td>" + value.parent_name + "</td>";
						output += "<td><a href=\"javascript:getConsult(" + value.consult_code + ");\">" + value.consult_content + "</a></td>";
						output += "</tr></tbody>";
					});
					
					$("#consult_tbl").html(output);
				}
				
				$("#consult").show();
				page();
			
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
	
	$("#register").click(function(){ // 상담일지 등록시 - 수정데이터인지 판단. 수정데이터일 경우 작성자 본인이 아니면 수정 불가.
	
		var consult_code = $("#consult_code").val();
		var kinder_num = $("#kinder_num").val();
		var parent_num = $("#parent_num").val();
		var staff_num = $("#login_staff_num").val();
		var write_staff_num = $("#staff_num").val();
		var consult_content = $("#consult_content").val();
	
		if (parent_num != "") {
			if (consult_code == "") { // 등록
				$.ajax({
					url : "/ius/consult/register_consult",
					type : "POST",
					data : {
						kinder_num : kinder_num,
						parent_num : parent_num,
						staff_num : staff_num,
						consult_content : consult_content
					},
					success : function(data) {
						alert("상담 일지가 등록되었습니다.");
						
						$("#parent_num").val("");
						$("#parent_name").val("");
						$("#relation").val("");
						$("#basic").prop("selected", true);
						$("#consult_content").val("");
						view(kinder_num);
					}
				})	
				
			} else { // 수정 일 때
				
				if (write_staff_num != staff_num) { // 로그인한 사람이 수정할 기록의 작성자가 아닌 경우 수정 불가
					alert("상담 기록 수정은 작성자 본인만 할 수 있습니다.");
				} else { // 본인의 기록인 경우
					$.ajax({
						url : "/ius/consult/update_consult",
						type : "POST",
						data : {
							consult_code : consult_code,
							kinder_num : kinder_num,
							parent_num : parent_num,
							staff_num : staff_num,
							consult_content : consult_content
						},
						success : function(data) {
							alert("상담 일지가 수정되었습니다.");
							
							$("#parent_num").val("");
							$("#parent_name").val("");
							$("#relation").val("");
							$("#basic").prop("selected", true);
							$("#consult_content").val("");
							view(kinder_num);
						}
					})	
	
				}
				
			}
			
		} else {
			alert('내담자 정보가 없습니다.');
		}
			
	});
	
	$("#delete").click(function(){ // 상담일지 삭제시 작성자 본인이 아니면 삭제 불가.
		var consult_code = $("#consult_code").val();
		var kinder_num = $("#kinder_num").val();
		var staff_num = $("#login_staff_num").val();
		var write_staff_num = $("#staff_num").val();
		
		if (consult_code == "") {
			alert("삭제할 정보가 없습니다.");
		} else {
			if (staff_num != write_staff_num) { // 작성자 본인이 아닌 경우
				alert("상담 기록은 작성자 본인만 삭제할 수 있습니다.")
			} else { // 본인인 경우
				var input = confirm("정말 삭제하시겠습니까?");
				
				if (input === true) {
					$.ajax({
						url : "/ius/consult/delete_consult",
						type : "POST",
						data : {
							consult_code : consult_code
						},
						success : function(data) {
							alert("상담 일지가 삭제되었습니다.");
							
							$("#parent_num").val("");
							$("#parent_name").val("");
							$("#relation").val("");
							$("#basic").prop("selected", true);
							$("#consult_content").val("");
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