var $jQ = jQuery.noConflict();
	$jQ(document).ready(function(){
	
		$jQ("#notice_content").summernote({
			height : 300,
			width : 1238,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : "ko-KR",
			placeholder : '내용을 입력하세요'
		});
		
		$jQ("#register").click(function(){
			var notice_title =  $jQ("#notice_title").val();
			var notice_content = $jQ("#notice_content").val();
			
			if (notice_title == "") {
				alert("제목을 입력해주세요.");
				return;
			};
			
			if (notice_content == "") {
				alert("내용을 입력해주세요.");
				return;
			};
			
			$jQ("form").submit();
			
		});
	
		
			
	});