package com.green.course.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.green.course.dao.CourseDAO;

public class CourseDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "CS?command=course_list";
		String id = request.getParameter("id");
		
		CourseDAO dao = CourseDAO.getInstance();
		dao.deleteCourseById(id);
		
		response.sendRedirect(url);
	}

}
