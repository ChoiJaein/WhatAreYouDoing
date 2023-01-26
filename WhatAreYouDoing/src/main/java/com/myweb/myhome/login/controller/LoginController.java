package com.myweb.myhome.login.controller;




import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.login.service.LoginService;
import com.myweb.myhome.login.vo.LoginVO;
import com.myweb.myhome.member.vo.MemberVO;






@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService service;
	
	
	// 로그인
	@GetMapping(value="/login")
	public String login(Model model) {
		logger.info("GET Login");
		return "login/login";
	}
	
	@PostMapping(value="/login")
	public String login(LoginVO loginVo, Model model
			, HttpServletRequest request
			, HttpSession session) {
		
		logger.info("POST Login({},{})",loginVo.getUserId(), loginVo.getUserPw());
		boolean result = service.getLogin(session,loginVo);
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("login");
		
		if(result) {
			return "redirect:/";
		} else {
			return"login/login";
		}
		
	}
	
	

	//로그아웃
	@GetMapping(value="/logout")
	public String logout(HttpSession session) {
		logger.info("logout()");
		session.invalidate();
		
		return "redirect:/login";
	}
	
	
	@GetMapping(value="/findIdPw")
	public String findIdPw() {
		logger.info("findIdPw()");
		return "/login/findIdPw";
	}
	
	@GetMapping(value="/findId")
	public String findId(Model model) {
		logger.info("GET findId(model={})",model);
		return "/login/findId";
	}
	
	@PostMapping(value="/findId")
	public String findId(@RequestParam("email")String email
			, HttpServletResponse response
			, HttpSession session) throws IOException {
		logger.info("POST findId(email={})",email);
		
		boolean result = service.findId(response,session,email);
		
		if(result) {
			//성공 
			System.out.println("성공");
			return "/login/findId";
		} else {
			//실패
			System.out.println("실패");
			return"login/login";
		}
	}
	
	@GetMapping(value="/findPw")
	public String findPw() {
		logger.info("findPw()");
		return "/login/findPw";
	}
	
	//비밀번호 찾기 성공
	@PostMapping(value = "/findPw")
	public String findPw(@ModelAttribute MemberVO vo
			, HttpServletResponse response
			,HttpSession session) throws Exception{
		logger.info("POST findPw(vo={})",vo);
		
		service.findPw(response, session, vo);
		
		return "/login/findPw";
    }
	
	
	
	
	
	
}