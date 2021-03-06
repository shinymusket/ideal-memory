

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/DeleteList")
public class DeleteList extends HttpServlet {
		
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); 
		
		ArrayList<String> tdList = (ArrayList<String>) session.getAttribute("tdList");
		int index = Integer.parseInt(request.getParameter("index"));
		tdList.remove(index);
		
		session.setAttribute("tdList", tdList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("toDoList.jsp");
		dispatcher.forward(request, response);
	}

}
