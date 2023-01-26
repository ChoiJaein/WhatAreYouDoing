package com.myweb.myhome.login.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.myhome.login.model.LoginDAO;
import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.login.service.LoginService;
import com.myweb.myhome.login.vo.LoginVO;
import com.myweb.myhome.member.model.MemberDAO;
import com.myweb.myhome.member.vo.MemberVO;

@Service
public class LoginService<loginDTO> {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);

	@Autowired
	 private LoginDAO dao;
	
	@Autowired
	private MemberDAO mdao;

	// 로그인
	public boolean getLogin(HttpSession session, LoginVO loginVo) {
		logger.info("getLogin({},{}" ,session, loginVo);
		LoginDTO data = new LoginDTO();
		data.setUserId(loginVo.getUserId());
		data.setUserPw(loginVo.getUserPw());
		
		data = dao.selectLogin(data);
		
		if(data != null) {
			session.setAttribute("loginData", data);
			return true;
		} else {
			return false;
		}
	}

	// 아이디 찾기
	public boolean findId(HttpServletResponse response, HttpSession session, String email) throws IOException {
		logger.info("findId({})", email);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		LoginDTO data = new LoginDTO();
		data.setUserEmail(email);
		
		data = dao.findId(email);
		if(data != null) {
			session.setAttribute("emailData", data);
			return true;
		}
		out.println("<script>");
		out.println("alert('가입된 아이디가 없습니다.');");
		out.println("history.go(-1);");
		out.println("</script>");
		out.close();
		return false;
	}
	
	// 임시 비밀번호 이메일 보내기
	public void sendEmail(MemberVO vo, String div) {
		logger.info("sendEmail(vo={}, div={})", vo, div);

		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "official.WYD01";
		String hostSMTPpwd = "cqgvbkodhdwpmrlk";
		
		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "official.WYD01@gmail.com";
		String fromName = "official_WYD";
		String subject = "";
		String msg = "";
		
		if(div.equals("findPw")) {
			subject = "WYD 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getUserId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getUserPw() + "</p></div>";
		}
		
		// 받는 사람 E-Mail 주소
		String mail = vo.getUserEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
//			email.setSslSmtpPort("587");;
			email.setSmtpPort(465);
			//네이버 이용시 587

			
			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
		
	}
	
	
	// 비밀번호 찾기
	public void findPw(HttpServletResponse response, HttpSession session, MemberVO vo) throws IOException {
		logger.info("sendEmail(vo={})", vo);
		
		response.setContentType("text/html;charset=utf-8");
		MemberVO ck = mdao.selectAll(vo.getUserId());
		PrintWriter out = response.getWriter();
		// 가입된 아이디가 없으면
		if(mdao.idOverlap(vo) != 1) {
			out.print("등록되지 않은 아이디입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!vo.getUserEmail().equals(ck.getUserEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo.setUserPw(pw);
			// 비밀번호 변경
			dao.updatePw(vo);
			// 비밀번호 변경 메일 발송
			sendEmail(vo, "findPw");

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
		
	}
}
