<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<%
	Calendar cal = Calendar.getInstance();
	
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	int year = cal.get(Calendar.YEAR); 
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	if(strYear != null)
	{
	  year = Integer.parseInt(strYear);
	  month = Integer.parseInt(strMonth);
	  
	}
	

	//년도 / 월 셋팅
	cal.set(year, month, 1);
	
	int startDay = cal.getMinimum(Calendar.DATE);
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	int start = cal.get(Calendar.DAY_OF_WEEK);
	int newLine = 0;

	// 오늘 날짜 저장
/* 	SimpleDateFormat dateFormet = new SimpleDateFormat("yyyyMMdd");
	String intToday = dateFormet.format(cal.getTime()); */

%>
<html lang="ko">
<HEAD>
<TITLE>행사 및 일정</TITLE>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${path}/resources/css/article.css">
<link rel="stylesheet" href="${path}/resources/css/event.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javaScript">
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

$(function(){
	var teacher = getCookie("teacher");
	if (teacher == "N") {
		$(".menu_info").removeAttr("href");
	}
	
	$("#eventRegister").click(function(){ // 행사 및 일정 등록은 교사 권한이 있어야 가능.
		
		var teacher = getCookie("teacher");
		if (teacher == "N") {  
			alert("권한이 없습니다.");
			return;
		} else if (teacher == "Y") {
			location.href='../event/event_select_by_event_date';
		}	
	});
	
})



</script>
</HEAD>
<BODY>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
<article>
                <!-- 왼쪽 소제목 박스 -->
                    <div id="title_bar">
                        <p>그룹 웨어</p>
                        <h3>행사 및 일정</h3>
                    </div>

                    <!-- 오른쪽 기능 박스 (검색)-->
                    <div id="title_top">
                        <input type="text" name="">
                        <input type="button" value="검색">
                        <input type="button" value="등록">
                        <input type="button" value="삭제">
                    </div>

                <!-- 내용 구간 -->
                <!-- 내용 넣으면 길이 알아서 늘어나요(아마도) -->
            <section>
                <div id="content">

<!-- <DIV id="content" style="width:900px"> -->
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td align ="right">
			<input type="button" onclick="location.href='./event_list'" value="오늘"/>
			<input type="button" id="eventRegister" value="일정 등록"/>
		</td>
	
	</tr>
</table>

<!--날짜 네비게이션  -->

<table class="calendar_nav">
	<tr>
		<td align="center" >
			<!-- 이전 년도 -->
			<a href="<c:url value='./event_list' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
				<b>&lt;&lt;</b>
			</a>
			
			<!-- 이전 달 -->
			<%if(month > 0 ){ %>
			<a href="<c:url value='./event_list' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
				<b>&lt;</b>
			</a>
			<%} else {%>
				<b>&lt;</b>
			<%} %>
			
			&nbsp;&nbsp;
			<%=year%>년
			
			<%=month+1%>월
			&nbsp;&nbsp;
			
			<!-- 다음 달 -->
			<%if(month < 11 ){ %>
			<a href="<c:url value='./event_list' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
				<b>&gt;</b>
			</a>
			<%}else{%>
				<b>&gt;</b>
			<%} %>
			
			<!-- 다음 년도 -->
			<a href="<c:url value='./event_list' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
				<b>&gt;&gt;</b>
			</a>
		</td>
	</tr>
	</table>
	
<br>

<table class="event_calendar">
	<THEAD>
		<TR bgcolor="#eee">
			<TD width='100px'>
			<font color="red">일</font>
			</TD>
			<TD width='100px'>월</TD>
			<TD width='100px'>화</TD>
			<TD width='100px'>수</TD>
			<TD width='100px'>목</TD>
			<TD width='100px'>금</TD>
			<TD width='100px'>
			<font color="#529dbc">토</font>
			</TD>
		</TR>
	</THEAD>
	<TBODY>
		<TR>
		<%
		
		// 달력 시작 빈공란 표시
		for(int index = 1; index < start ; index++ ) {
		  out.println("<TD >&nbsp;</TD>");
		  newLine++;
		}
		
			
		for(int index = 1; index <= endDay; index++)
		{
			String color = "";
			
			if(newLine == 0){			color = "RED";
			}else if(newLine == 6){ 	color = "#529dbc";
			}else{						color = "BLACK"; };
		
			String thisDate = Integer.toString(year);
		
			thisDate += Integer.toString(month+1).length() == 1 ? "-0" + Integer.toString(month+1) : "-" + Integer.toString(month+1);
			thisDate += Integer.toString(index).length() == 1 ? "-0" + Integer.toString(index) + " 00:00:00" : "-" + Integer.toString(index) + " 00:00:00";
			
			request.setAttribute("thisDate", thisDate);
			
			String search_date = Integer.toString(year);
			search_date += Integer.toString(month+1).length() == 1 ? "-0" + Integer.toString(month+1) : "-" + Integer.toString(month+1);
			search_date += Integer.toString(index).length() == 1 ? "-0" + Integer.toString(index) : "-" + Integer.toString(index);
			request.setAttribute("search_date", search_date);
		
			out.println("<TD valign='top' nowrap>");
			%>
			
			<a class="event_info" style="color:<%=color%>" href="../event/event_select_by_event_date?event_date=<%=search_date%>"><b><%=index %></b></a>

			<div class="event_content">
				<c:forEach items="${eventList}" var="event">
				<c:if test="${event.event_date eq thisDate}">
					<span class="event_title"><b>${event.event_name}</b></span><br>
				</c:if>
				</c:forEach>
			</div>
		<%
			
			out.println("</TD>");
			newLine++;
		
			// 일주일 표시
			if(newLine == 7)
			{
			  out.println("</TR>");
			  if(index <= endDay)
			  {
			    out.println("<TR>");
			  }
			  newLine=0;
			}
			
		}
		
		// 달 마지막 공란 Loop 그리기
		while(newLine > 0 && newLine < 7)
		{
		  out.println("<TD></TD>");
		  newLine++;
		}
		%>
		</TR>
	</TBODY>
</TABLE>
<!-- </DIV> -->
</div>
</section>
</article>
<%@include file="../include/footer.jsp" %>
</BODY>
</HTML>
