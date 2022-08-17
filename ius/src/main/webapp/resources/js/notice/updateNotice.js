var $jQ = jQuery.noConflict();
	$jQ(document).ready(function(){
		$jQ("#notice_content").summernote({
			height : 300,
			width : 1238,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : "ko-KR",
		});
		
		$jQ("#notice_content").summernote('enable');
		
		$jQ("#update").click(function(){
			alert("수정이 완료되었습니다.");
			$jQ("form").submit();
		});
		
		
	});