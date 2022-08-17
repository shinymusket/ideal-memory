<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<%
Calendar cal = Calendar.getInstance();

String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);

if (strYear != null) {
	year = Integer.parseInt(strYear);
	month = Integer.parseInt(strMonth);
}

//년도 / 월 셋팅
cal.set(year, month, 1);

int startDay = cal.getMinimum(Calendar.DATE);
int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int start = cal.get(Calendar.DAY_OF_WEEK);
int newLine = 0;

%>
<html lang="ko">
<HEAD>
<TITLE>캘린더</TITLE>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/mealCss/meal.css">
<script type="text/javaScript" language="javascript"></script>
</HEAD>
<BODY>
	<%@include file="../include/header.jsp"%>
	<%@include file="../include/nav.jsp"%>
	<article>
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>식단 관리</h3>
		</div>

		<div id="title_top">			
		</div>

		<section>
			<div id="content">
				<!--날짜 네비게이션  -->
				<table class="calendar_nav">
					<tr>
						<td align="center">
							<!-- 이전 년도 -->
							<a href="<c:url value='./meal_list' />?year=<%=year - 1%>&amp;month=<%=month%>" target="_self">&lt;&lt;</a>
							<!-- 이전 달 -->
							 <% if (month > 0) { %> 
							<a href="<c:url value='./meal_list' />?year=<%=year%>&amp;month=<%=month - 1%>" target="_self">&lt;</a>
							<%} else {%> &lt; <% } %> 
							
							<%=year%>년 <%=month + 1%>월 
							
							<!-- 다음 달 -->
							<% if (month < 11) { %>
							<a href="<c:url value='./meal_list' />?year=<%=year%>&amp;month=<%=month + 1%>" target="_self">&gt;</a>
							<%} else { %>&gt; <%} %>
							<!-- 다음 년도 --> 
							<a href="<c:url value='./meal_list' />?year=<%=year + 1%>&amp;month=<%=month%>" target="_self">&gt;&gt;</a>
						</td>
					</tr>
					<tr>
						<td align="right">
							<input type="button" id="todayButton" onclick="location.href='./meal_list'" value="오늘" />
							<input type="button" id="addButton" onclick="location.href='../meal/addMealMenu'" value="식단등록" />
						</td>
					</tr>
				</table>

				<br>

				<table class="meal_calendar">
					<thead>
						<tr bgcolor="#eee">
							<td><font color="red">일</font></td>
							<TD>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td><font color="#529dbc">토</font></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<%
							// 달력 시작 빈공란 표시
							for (int index = 1; index < start; index++) {
								out.println("<td class='mealdatebox'></TD>");
								newLine++;
							}

							for (int index = 1; index <= endDay; index++) {
								String color = "";

								if (newLine == 0) {
									color = "RED";
								} else if (newLine == 6) {
									color = "#529dbc";
								} else {
									color = "BLACK";
								};

								String thisDate = Integer.toString(year);

								thisDate += Integer.toString(month + 1).length() == 1 ? "-0" + Integer.toString(month + 1)
								: "-" + Integer.toString(month + 1);
								thisDate += Integer.toString(index).length() == 1 ? "-0" + Integer.toString(index) + " 00:00:00"
								: "-" + Integer.toString(index) + " 00:00:00";

								request.setAttribute("thisDate", thisDate);

								String search_date = Integer.toString(year);
								search_date += Integer.toString(month + 1).length() == 1 ? "-0" + Integer.toString(month + 1)
								: "-" + Integer.toString(month + 1);
								search_date += Integer.toString(index).length() == 1 ? "-0" + Integer.toString(index)
								: "-" + Integer.toString(index);
								request.setAttribute("search_date", search_date);

								out.println("<td valign='top' nowrap>");
							%>

							<a style="color:<%=color%>" href="../meal/menuSelectByMenuNum?menu_edate=<%=search_date%>"><b><%=index%></b></a>

							<div class="break_menu">
								<span class="menu_title"><b>오전 간식</b></span><br>
								<c:forEach items="${menuList}" var="list">
									<c:if test="${list.menu_edate eq thisDate}">
										<c:if test="${list.meal_code eq 'B'}">
											${list.meal_menu} ${list.allergy_num}<br>
										</c:if>
									</c:if>
								</c:forEach>
							</div>
							<div class="lunch_menu">
								<span class="menu_title"><b>점심</b></span><br>
								<c:forEach items="${menuList}" var="list">
									<c:if test="${list.menu_edate eq thisDate}">
										<c:if test="${list.meal_code eq 'L'}">
											${list.meal_menu} ${list.allergy_num}<br>
										</c:if>
									</c:if>
								</c:forEach>
							</div>
							<div class="snack_menu">
								<span class="menu_title"><b>오후 간식</b></span><br>
								<c:forEach items="${menuList}" var="list">
									<c:if test="${list.menu_edate eq thisDate}">
										<c:if test="${list.meal_code eq 'S'}">
											${list.meal_menu} ${list.allergy_num}<br>
										</c:if>
									</c:if>
								</c:forEach>
							</div>


							<%
							out.println("</td>");
							newLine++;

							// 일주일 표시
								if (newLine == 7) {
									out.println("</tr>");
									if (index <= endDay) {
										out.println("<tr>");
									}
								newLine = 0;
								};
							};

							// 달 마지막 공란 Loop 그리기
							while (newLine > 0 && newLine < 7) {
								out.println("<td></td>");
								newLine++;
							};
							%>
						</tr>
						<tr>
							<td>식품 알레르기 표시 정보</td>
							<td colspan="6">
							①난류 ②우유 ③메밀 ④땅콩 ⑤대두
							⑥밀 ⑦고등어 ⑧게 ⑨새우 ⑩돼지고기 ⑪복숭아 ⑫토마토 ⑬아황산염 ⑭호두 ⑮닭고기 ⑯쇠고기
							⑰오징어 ⑱조개류(굴, 전복, 홍합 포함)
							<p>알레르기 증상을 보이는 유아는 급식 시 각별한 주의를 부탁드립니다</p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</section>
	</article>
	<%@include file="../include/footer.jsp" %>
</BODY>
</HTML>
