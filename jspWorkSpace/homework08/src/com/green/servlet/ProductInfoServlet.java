package com.green.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.green.vo.ProductVO;

@WebServlet("/PIS")
public class ProductInfoServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String code = request.getParameter("code");
		
		HttpSession session = request.getSession();
		ArrayList<ProductVO> productList = (ArrayList<ProductVO>) session.getAttribute("productList");
		
		for (int i = 0; i < productList.size(); i++) {
			if (code.equals(productList.get(i).getCode())) {
				ProductVO pVo = new ProductVO(); 
				pVo = productList.get(i);
				request.setAttribute("product", pVo);
				break;
			}
		}
		request.getRequestDispatcher("productInfo.jsp").forward(request, response);
//		response.sendRedirect("productInfo.jsp");
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
