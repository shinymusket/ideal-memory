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
<script type="text/javascript" src="${path}/resources/js/notice/noticeInfo.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/notice/noticeInfo.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
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
					<div id="controllBtns">
						<input type="button" value="목록" onclick="location.href='../notice/notice_list'">
					</div>
				
					<div id="notice">
						<table border="1" id="noticeInfo">
							<tbody>
								<tr>
									<th id="noticeTitle">제목</th>
									<td id="noticeTitleTd" colspan="7">
										${noticeInfo.notice_title}
									</td>
								</tr>
								<tr>
									<th>글 번호</th>
									<td id="noticeNumTd">
										${noticeInfo.notice_num}
										<input type="hidden" id="notice_num" value="${noticeInfo.notice_num}">
									</td>
									<th class="noticeInfoTh">작성자</th>
									<td id="noticeWriterTd">
										${noticeInfo.staff_name}
										<input type="hidden" id="staff_name" value="${noticeInfo.staff_name}">
									</td>
									<th class="noticeInfoTh">작성 날짜</th>
									<td>${noticeInfo.notice_writeDate}</td>
									<th class="noticeInfoTh">조회수</th>
									<td>${noticeInfo.notice_readCount}</td>
								</tr>	
								<tr>
									<td id="notice_contentTd" colspan="8">
										${noticeInfo.notice_content}
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr id="registerReplyTr">
									<td colspan="1">
										<input type="hidden" id="staff_id" value="${staffInfo.staff_id}">
										<input type="hidden" id="reply_register_staff_id">
										<input type="hidden" id="log_staff_name" value="${staffInfo.staff_name}">
										<input type="hidden" id="reply_num">
										<input type="text" id="staff_name" style="width : 100%;" value="${staffInfo.staff_name}" readonly="readonly">
									</td>
									<td colspan="6">
										<input type="text" placeholder="내용을 입력하세요." id="reply_content">
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