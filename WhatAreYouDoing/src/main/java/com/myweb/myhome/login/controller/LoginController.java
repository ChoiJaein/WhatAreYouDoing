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

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.login.model.NaverLoginBO;
import com.myweb.myhome.login.service.LoginService;
import com.myweb.myhome.login.vo.LoginVO;
import com.myweb.myhome.member.vo.MemberVO;






@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;
	
	@Autowired
	private LoginService service;
	
	 @Autowired
	    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
	        this.naverLoginBO = naverLoginBO;
	    }
	
	 
	// 로그인
	@GetMapping(value="/login")
	public String login(Model model, HttpSession session) {
		logger.info("GET Login");
		
		/* 네아로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		/* 인증요청문 확인 */
		System.out.println("네이버:" + naverAuthUrl);
		/* 객체 바인딩 */
		model.addAttribute("urlNaver", naverAuthUrl);
		
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
	
	// 네이버 로그인 api 콜백
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
            throws IOException {
        System.out.println("여기는 callback");
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        model.addAttribute("result", apiResult);
 
        /* 네이버 로그인 성공 페이지 View 호출 */
        return "home";
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