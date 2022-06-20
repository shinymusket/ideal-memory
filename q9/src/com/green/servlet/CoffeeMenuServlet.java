package com.green.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.green.dao.CoffeeDAO;
import com.green.vo.CoffeeVO;


@WebServlet("/CMS")
public class CoffeeMenuServlet extends HttpServlet {
	    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 1단계
		System.out.println("1단계 접속 완료");
		
		// 2단계
		CoffeeDAO dao = CoffeeDAO.getInstance();
		
		// 4단계
		List<String> coffeeNames = dao.getCoffeeName();
		if (session.getAttribute("coffeeList") == null) {
			ArrayList<CoffeeVO> coffeeList = new ArrayList<>();
			session.setAttribute("coffeeList", coffeeList);
			session.setAttribute("allTotal", 0);
		}
		
		
		// 5단계
		session.setAttribute("cNames", coffeeNames);
		request.getRequestDispatcher("coffeeMenu.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		List<CoffeeVO> coffeeList = (List) session.getAttribute("coffeeList");
		int allTotal = (int) session.getAttribute("allTotal");
		
		
		// 7단계
		request.setCharacterEncoding("UTF-8");
		
		String coffeeName = request.getParameter("coffeeName");
		String coffeeType = request.getParameter("coffeeType");
		int count = Integer.parseInt(request.getParameter("coffeeCount"));
		
		// 8단계
		CoffeeDAO dao = CoffeeDAO.getInstance();
		
		// 10단계
		int price = dao.getCoffeePrice(coffeeName, coffeeType);
//		List<String> coffeeNames = dao.getCoffeeName();
		
		// 11단계
		int sum = price * count;
		allTotal = allTotal +sum;
		
		// 12단계
//		request.setAttribute("cNames", coffeeNames);
		/*
		 * request.setAttribute("coffeeName", coffeeName);
		 * request.setAttribute("coffeeType", coffeeType); request.setAttribute("count",
		 * count); request.setAttribute("price", price); request.setAttribute("total",
		 * total);
		 */
		
		// 15단계
		CoffeeVO cVo = new CoffeeVO();
		cVo.setCoffeeName(coffeeName);
		cVo.setCoffeeType(coffeeType);
		cVo.setCount(count);
		cVo.setPrice(price);
		cVo.setSum(sum);
		
		coffeeList.add(cVo);
		
//		request.setAttribute("coffeeInfo", cVo);
		
		session.setAttribute("coffeeList", coffeeList);
		session.setAttribute("allTotal", allTotal);
		
		// 13단계
		request.getRequestDispatcher("coffeeMenu.jsp").forward(request, response);
		
	}

}
