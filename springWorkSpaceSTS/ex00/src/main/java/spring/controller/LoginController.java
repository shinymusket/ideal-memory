package spring.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import spring.exception.IdPasswordNotMatchingException;
import spring.service.AuthService;
import spring.validator.LoginCommandValidator;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;

@Controller
public class LoginController {
	
	private AuthService authService;
	
	public void setAuthService(AuthService authService) {
		this.authService = authService;
	}

//	@GetMapping("login")
//	public String form(Model model) {
//		
//		model.addAttribute("loginCommand", new LoginCommand());
//		
//		return "login/loginForm";
//	}
	
	@GetMapping("login")
	public String form(LoginCommand loginCommand, HttpServletRequest req, @CookieValue(value="remember", required=false) Cookie rememberEamil) {
		HttpSession session = req.getSession();
		
		if(session.getAttribute("authInfo") != null) {
			return "/main";
		}
		
		if (rememberEamil != null) {
			loginCommand.setEmail(rememberEamil.getValue());
			loginCommand.setRemeberEmail(true);
		}
		
		
		return "login/loginForm";
		
	}
	
	@PostMapping("login")
	public String submit(LoginCommand loginCommand,
			Errors errors, HttpSession session, HttpServletResponse res) {
		
		
		// 로그인 성공 여부와 관계 없이 이메일 저장
		Cookie rememberCookie = new Cookie("remember", loginCommand.getEmail());
		if (loginCommand.isRemeberEmail()) {
			rememberCookie.setMaxAge(60*60*24*30);
		} else {
			rememberCookie.setMaxAge(0);
		}
	
		res.addCookie(rememberCookie);
		
		new LoginCommandValidator().validate(loginCommand, errors);
		
		if (errors.hasErrors()) {
			return "login/loginForm";
		}
		
		try {
			AuthInfo authInfo = authService.authenticate(loginCommand.getEmail(), loginCommand.getPassword());
			
			// 로그인 처리
			session.setAttribute("authInfo", authInfo);
			// 로그인 성공한 사람만 이메일 저장
			
			return "login/loginSuccess";
			
		} catch(IdPasswordNotMatchingException e) {
			errors.reject("IdPasswordNotMatching");
			return "login/loginForm";
		}

	}
}
