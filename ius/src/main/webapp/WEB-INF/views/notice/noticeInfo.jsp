<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/summernote/summernote-lite.js"></script>
<script type="text/javascript" src="${path}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/summernote/summernote-lite.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
</head>
<style>
	#notice_title {
		height : 30px;
	 	width : 1238px;
	 	padding-left : 10px;
	 	margin-bottom : 10px;
	}
	
	#register {
		display : inline-block;
		width : 50px;
		margin: 5px auto;
	}
</style>
<body>
<script type="text/javascript">
function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
};

function getReply(reply_num) { // 댓글 정보 가져오기
	$jQ("#reply_num").val(reply_num);
	
	$jQ.ajax({
		url : "/ius/notice/get_reply_Info",
		type : "POST",
		data : {
			reply_num : reply_num
		},
		success : function(data) {
			$jQ("#reply_register_staff_id").val("");
			$jQ("#staff_name").val("");
			$jQ("#reply_content").val("");
			
			$jQ("#reply_register_staff_id").val(data.replyInfo.staff_id);
			$jQ("#staff_name").val(data.replyInfo.staff_name);
			$jQ("#reply_content").val(data.replyInfo.reply_content);
		}
	});
}


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
		
		$jQ("#notice_content").summernote('disable');
		
		$jQ("#delete").click(function(){ // 삭제
			var master = getCookie("master");
			
			if (master == "N") {
				alert("권한이 없습니다.");
				return
			}; 
			
			var notice_num = $jQ("#notice_num").val();
			var input = confirm("정말 삭제하시겠습니까?");
		
			if(input === true) {
				alert("글이 삭제되었습니다.");
				location.href="../notice/delete_notice?notice_num=" + notice_num;
			}
		});
		
		$jQ("#update").click(function(){ // 수정
			var master = getCookie("master");
			
			if (master == "N") {
				alert("권한이 없습니다.");
				return
			}; 
			
			var notice_num = $jQ("#notice_num").val();
			location.href="../notice/update_notice_form?notice_num=" + notice_num;

		});
		
		function getReply() { // 댓글 리스트 가져오기
			var notice_num = $jQ("#notice_num").val();
		
			$jQ.ajax({
				url : "/ius/notice/get_reply_list",
				type : "POST",
				data : {
					notice_num : notice_num
				},
				success : function(data) {
					$(".replyInfoTr").remove();
					
					values = data.replyList;
					$jQ("#noticeInfo>tbody").append("<tr class='replyInfoTr'><th>작성자</th><th colspan='6'>내용</th><th>작성 일자</th></tr>");
					if(values.length != 0) {
						$.each(values, function(index, value) {
							$jQ("#noticeInfo>tbody").append("<tr class='replyInfoTr'><td>"+ value.staff_name + "</td><td colspan='6'><a href=\"javascript:getReply(" + value.reply_num + ");\">"+ value.reply_content + "</a></td><td>"+ value.reply_date + "</td></tr>");	
						});
					}
					
				}
			});
			
		};

		getReply();
		
		$jQ("#replyRegister").click(function() { // 댓글 등록
			var notice_num = $jQ("#notice_num").val();
			var staff_id = $jQ("#staff_id").val();
			var reply_content = $jQ("#reply_content").val();
			
			if (reply_content == "") {
				alert("댓글 내용을 입력하세요");
				return;
			};
			
			$jQ.ajax({
				url : "/ius/notice/add_reply",
				type : "POST",
				data : {
					notice_num : notice_num,
					staff_id : staff_id,
					reply_content : reply_content
				},
				success : function(data) {
					$jQ("#reply_content").val("");
					getReply();	
				}
			});
			
		});
		
		$jQ("#replyUpdate").click(function(){ // 댓글 수정
			var reply_num = $jQ("#reply_num").val();
			var staff_id = $jQ("#staff_id").val();
			var reply_content = $jQ("#reply_content").val();
			var reply_register_staff_id = $jQ("#reply_register_staff_id").val();
			
			if (reply_num == "") {
				alert("먼저 수정할 데이터를 선택하세요.");
				return;
			};
			
			if (reply_register_staff_id != staff_id) { // 댓글 작성자가 아니면 수정불가.
				alert("댓글 수정은 작성자 본인만 할 수 있습니다.");
				return;
			};
			
			$jQ.ajax({
				url : "/ius/notice/update_reply",
				type : "POST",
				data : {
					reply_num : reply_num,
					reply_content : reply_content,
				},
				success : function(data) {
					alert("수정이 완료되었습니다.");
					$jQ("#reply_register_staff_id").val("");
					$jQ("#reply_num").val("");
					$jQ("#reply_content").val("");
					getReply();	
				}
			});
			
			
		});
		
		$jQ("#replyDelete").click(function(){ // 댓글 삭제
			var reply_num = $jQ("#reply_num").val();
			var staff_id = $jQ("#staff_id").val();
			var reply_content = $jQ("#reply_content").val();
			var reply_register_staff_id = $jQ("#reply_register_staff_id").val();
			
			if (reply_num == "") {
				alert("먼저 삭제할 데이터를 선택하세요.");
				return;
			};
			
			if (reply_register_staff_id != staff_id) { // 댓글 작성자가 아니면 수정불가.
				alert("댓글 삭제는 작성자 본인만 할 수 있습니다.");
				return;
			};
			
			$jQ.ajax({
				url : "/ius/notice/delete_reply",
				type : "POST",
				data : {
					reply_num : reply_num,
				},
				success : function(data) {
					alert("삭제되었습니다.");
					$jQ("#reply_register_staff_id").val("");
					$jQ("#reply_num").val("");
					$jQ("#reply_content").val("");
					getReply();	
				}
			});
			
			
		});
		
		$jQ("#replyCancel").click(function(){ // 비우기
			$jQ("#reply_register_staff_id").val("");
			$jQ("#reply_num").val("");
			$jQ("#reply_content").val("");
		});
		
		
	});
</script>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>공지사항</p>
				<h3>공지사항 조회</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="notice">
						<table border="1" id="noticeInfo">
							<tbody>
								<tr>
									<td colspan="8">
										<input type="text" id="notice_title" name="notice_title" value="${noticeInfo.notice_title}" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th>글 번호</th>
									<td>
										<input type="text" id="notice_num" readonly="readonly" value="${noticeInfo.notice_num}">
									</td>
									<th>작성자</th>
									<td>
										<input type="text" id="staff_name" readonly="readonly" value="${noticeInfo.staff_name}">
									</td>
									<th>작성일</th>
									<td>${noticeInfo.notice_writeDate}</td>
									<th>조회수</th>
									<td>${noticeInfo.notice_readCount}</td>
								</tr>	
								<tr>
									<td colspan="8">
										<textarea id="notice_content" name="notice_content">${noticeInfo.notice_content}</textarea>
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="1">
										<input type="hidden" id="staff_id" value="${staffInfo.staff_id}">
										<input type="hidden" id="reply_register_staff_id">
										<input type="hidden" id="log_staff_name" value="${staffInfo.staff_name}">
										<input type="text" id="reply_num">
										<input type="text" id="staff_name" style="width : 235px;" value="${staffInfo.staff_name}" readonly="readonly">
									</td>
									<td colspan="6">
										<input type="text" placeholder="내용을 입력하세요." id="reply_content" style="width : 860px;">
									</td>
									<td>
										<input type="button" value="등록" id="replyRegister">
										<input type="button" value="수정" id="replyUpdate">
										<input type="button" value="삭제" id="replyDelete">
										<input type="button" value="비우기" id="replyCancel">
									</td>
								</tr>
								<tr>
									<td colspan="8">
										<input type="button" value="수정" id="update">
										<input type="button" value="삭제" id="delete">
										<input type="button" value="목록" onclick="location.href='../notice/notice_list'">
									</td>
								</tr>	
							</tfoot>			
						</table>
					</div>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>

</html>