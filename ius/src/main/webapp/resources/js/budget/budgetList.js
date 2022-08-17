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
}

	$(function(){
		function addComma(value){
			result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
	        return result;
	    };
			
		function getList() {
			$.ajax({
				url : "/ius/budget/get_budget_list",
				type : "POST",
				data : {
					
				},
				success: function(data) {
					$("#list").text("");			

					values = data.budgetList;
					output = "<thead><tr><th>예산 번호</th><th>년도</th><th>구분</th><th>항목</th><th>총액</th></tr></thead>";				
					$.each(values, function(index, value) {
						
						if (value.budget_iE == 'In') {
							budgetType = '수입';
						} else if (value.budget_iE == 'Ex') {
							budgetType = '지출';
						}
						
						output += "<tbody><tr>";
						output += "<td>" + value.budget_num + "</td>";
						output += "<td>" + value.budget_year + "</td>";
						output += "<td>" + budgetType + "</td>";
						output += "<td><a href='../budget/budget_info?budget_num=" + value.budget_num + "'>" + value.budget_cls + "</a></td>";
						output += "<td>" + addComma(value.budget_total) + "</td>";
						output += "</tr></tbody>";
					});
					$("#list").html(output);
					page();
				}
				
			})
			
		}
		getList();
		
		$("#yearSearch").click(function(){ // 년도별 조회
			if ($("#budget_year").val() == "") {
				alert("년도를 선택하세요.");
				$("#budget_year").val().focus();
				return;
			};
			
			budgetYear = $("#budget_year").val();
			
			var objParams = {
					seachYear : $("#budget_year").val(),
					budgetType : $("#budget_type").val()

			}
			
			var values = [];
			
			$.post(
				"/ius/budget/get_budget_list_by_year",
				objParams,
				function(retVal) {
					$("#list").text("");
					$("#budgetYear").text("");
					$("#totalIncome").text("");
					$("#totalExpense").text("");
					$("#balance").text("");
					
					values = retVal.budgetList;
					totalIncome = retVal.totalIncome;
					totalExpense = retVal.totalExpense;
					balance = (totalIncome-totalExpense);
		

					output = "<thead><tr><th>예산 번호</th><th>년도</th><th>구분</th><th>항목</th><th>총액</th></tr></thead>";				
					$.each(values, function(index, value) {
						if (value.budget_iE == 'In') {
							budgetType = '수입';
						} else if (value.budget_iE == 'Ex') {
							budgetType = '지출';
						}
						
						
						output += "<tbody><tr>";
						output += "<td>" + value.budget_num + "</td>";
						output += "<td>" + value.budget_year + "</td>";
						output += "<td>" + budgetType + "</td>";
						output += "<td><a href='../budget/budget_info?budget_num=" + value.budget_num + "'>" + value.budget_cls + "</a></td>";
						output += "<td>" + addComma(value.budget_total) + "</td>";
						output += "</tr></tbody>";
					});
					
					$("#budgetYear").html(budgetYear);
					$("#totalIncome").html(addComma(totalIncome));
					$("#totalExpense").html(addComma(totalExpense));
					$("#balance").html(addComma(balance));

					$("#list").html(output);
					page();
				}
			)
		});
		
		$("#register").click(function(){ // 예산 등록시 관리자 권한 확인.
			var master = getCookie("master");
			
			if (master == "N") { // 마스터 권한이 없는 경우
				alert("권한이 없습니다.");
				return;
			} else if (master == "Y") { // 마스터 권한이 있는 경우
				location.href="../budget/budget_register_form";
			}
		
		})
		
		
	})