package com.myweb.myhome.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.member.service.MemberService;
import com.myweb.myhome.member.vo.MemberVO;
import com.myweb.myhome.upload.model.PhotoUploadDTO;
import com.myweb.myhome.upload.service.PhotoUploadService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService service;
	
	@Autowired
	private PhotoUploadService photoUploadService;
	
	// 회원 가입
	@GetMapping(value="/register")
	public String register(Model model) {
		logger.info("get register");
		return "login/register";
	}
	
	@PostMapping(value="/register")
	public String register(Model model, RedirectAttributes ra
			, HttpServletRequest request
			, @ModelAttribute MemberVO vo
			, @RequestParam("photoUpload") MultipartFile[] files) {
		logger.info("post register(Model={}, MemberVO={})", model, vo);
		
		
		
		String userId = vo.getUserId();
		System.out.println(userId);
		
		for(MultipartFile file: files) {
			String location = request.getServletContext().getRealPath("/resources/img/profile");
			String url = "/static/img/profile";
			PhotoUploadDTO fileData = new PhotoUploadDTO(userId, location, url);
			logger.info("check fileData(fileData={})", fileData);
			
			try {
				int fileResult = photoUploadService.profileupload(file, fileData);
				if(fileResult == -1) {
					request.setAttribute("error", "파일 업로드 수량을 초과하였습니다.");
					System.out.println("업로드 수량 에러");
					return "login/register";
				}
			} catch(Exception e) {
				request.setAttribute("error", "파일 업로드 작업중 예상치 못한 에러가 발생하였습니다.");
				System.out.println("예상치 못한 에러");
				return "login/register";
			}
		}
		
		int result = service.idOverlap(vo);
		
		if(result == 1) {
//			photoUploadService.defaultProfile(userId);
			ra.addFlashAttribute("result", "registerFalse");
			return "login/register";
		} else if(result == 0) {
			service.register(vo);
			ra.addFlashAttribute("result", "registerOK");
		}
		return "login/login";
	}
	
	
	
	// 아이디 중복 확인
	@PostMapping(value="/idOverlap", produces="application/json; charset=utf-8")
	@ResponseBody
	public String idOverlap(MemberVO vo) {
		logger.info("idOverlap(MemberVO={})", vo);
		
		int result = service.idOverlap(vo);
		
		JSONObject json = new JSONObject();
		
		if(result == 1) {
			json.put("code", "fail");
		} else {
			json.put("code", "success");
		}
		
		return json.toJSONString();
	}

	
	// 회원정보 수정
	
	@GetMapping(value="/modify")
	public String userModify(HttpServletRequest request, Model model
			, LoginDTO loginDto) {
		logger.info("get modify(model={}, loginDto={})", model, loginDto);
		
		HttpSession session = request.getSession();
		loginDto = (LoginDTO) session.getAttribute("loginData");
		
		String userId = loginDto.getUserId();
		
		MemberVO data = service.getAll(userId);
		PhotoUploadDTO photo = service.getUserPhoto(userId);
		
		String fileName = photo.getFileName();
		System.out.println(fileName);
		if(fileName == null) {
			photo.setFileName("default_profile.png");
			System.out.println(photo.getFileName());
			model.addAttribute("data", data);
			model.addAttribute("photo", photo);
		} else {
			model.addAttribute("data", data);
			model.addAttribute("photo", photo);
		}
		return "login/userModify";
	}
	
	
	@PostMapping(value="/modify")
	public String userModify(Model model, HttpServletRequest request
			, @ModelAttribute MemberVO vo
			, @SessionAttribute("loginData") LoginDTO loginDto
			, @RequestParam("photoUpload") MultipartFile[] files) {
		logger.info("post userModify(Model={}, MemberVO={})", model, vo);
		String userId = vo.getUserId();
		System.out.println(userId);
		
		for(MultipartFile file: files) {
			String location = request.getServletContext().getRealPath("/resources/img/profile");
			String url = "/static/img/profile";
			PhotoUploadDTO fileData = new PhotoUploadDTO(userId, location, url);
			logger.info("check fileData(fileData={})", fileData);
			
			try {
				boolean del = photoUploadService.profileDelete(userId);
				logger.info("check delete result(del={})", del);
				int fileResult = photoUploadService.profileupload(file, fileData);
				if(fileResult == -1) {
					request.setAttribute("error", "파일 업로드 수량을 초과하였습니다.");
					System.out.println("업로드 수량 에러");
					return "login/userModify";
				}
			} catch(Exception e) {
				request.setAttribute("error", "파일 업로드 작업중 예상치 못한 에러가 발생하였습니다.");
				System.out.println("예상치 못한 에러");
				return "login/userModify";
			}
		}		
		
		boolean result = service.userModify(vo);
		
		if(result) {
			model.addAttribute("msg", "수정이 완료되었습니다.");
			model.addAttribute("url", "/");
			return "alert";
		} else {
			model.addAttribute("msg", "수정을 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/modify");
			return "alert";
			}
		
	}
	
	
	// 회원 탈퇴
	@GetMapping(value="/signout")
	public String signout(HttpServletRequest request, Model model, LoginDTO loginDto) {
		logger.info("get signout(model={}, LoginDTO={})", model, loginDto);
		
		HttpSession session = request.getSession();
		loginDto = (LoginDTO) session.getAttribute("loginData");
		
		String userId = loginDto.getUserId();
		
		MemberVO data = service.getAll(userId);
		
		model.addAttribute("data", data);
		
		return "/login/signout";
	}
	
	@PostMapping(value="/signout")
	public String signout(Model model, @ModelAttribute MemberVO vo, HttpSession session) {
		logger.info("post signout");
		
		boolean result = service.signout(vo);
		
		if(result) {
			model.addAttribute("msg", "탈퇴가 완료되었습니다.");
			session.invalidate();
			model.addAttribute("url", "/login");
			return "alert";
		} else {
			model.addAttribute("msg", "탈퇴를 실패하였습니다. 다시 시도해주세요.");
			model.addAttribute("url", "/signout");
			return "alert";
		}
		
	}
	
	
	
//	@GetMapping(value="/myinfo/modify")
//	public String userModify(HttpServletRequest request, Model model, AccountDTO accountDto) {
//		logger.info("get modify(HttpServletRequest={}, model={}, accountDto={})", request, model, accountDto);
//		
//		HttpSession session = request.getSession();
//		accountDto = (AccountDTO) session.getAttribute("loginData");
//		
//		String accountid = accountDto.getAccountid();
//		
//		MemberVO data = service.getAll(accountid);
//		InfoDTO photo = photoService.getUserPhoto(accountid);
//		
//		model.addAttribute("data", data);
//		model.addAttribute("photo", photo); // 사진
//		
//		return "login/userModify";
//	}
//	
//	
//	@PostMapping(value="/myinfo/modify")
//	public String userModify(Model model, HttpServletRequest request
//			, @ModelAttribute MemberVO vo , @SessionAttribute("loginData") AccountDTO accDto
//			,@RequestParam("photoUpload") MultipartFile[] files) {
//		logger.info("post userModify(Model={}, MemberVO={})", model, vo);
//		boolean result = service.userModify(vo);
//		
//		String id = accDto.getAccountid();
//		
//		for(MultipartFile file: files) {
//			String location = request.getServletContext().getRealPath("/resources/account/upload");
//			String url = "/static/account/upload";
//			PhotoUploadDTO fileData = new PhotoUploadDTO(id, location, url);
//			
//			try {
//				int fileResult = photoUploadService.Profileupload(file, fileData);
//				if(fileResult == -1) {
//					request.setAttribute("error", "파일 업로드 수량을 초과하였습니다.");
//					return "board/boardUpload";
//				}
//			} catch(Exception e) {
//				request.setAttribute("error", "파일 업로드 작업중 예상치 못한 에러가 발생하였습니다.");
//				return "board/boardUpload";
//			}
//		}
//		
//		
//		if(result) {
//			model.addAttribute("msg", "수정이 완료되었습니다.");
//			model.addAttribute("url", "/home");
//			return "alert";
//		} else {
//			model.addAttribute("msg", "수정을 실패하였습니다. 다시 시도해주세요.");
//			model.addAttribute("url", "/home/myinfo/modify");
//			return "alert";
//			}
//		
//		
//	}
//	
//	
//	// 회원 탈퇴
//	@GetMapping(value="/myinfo/signout")
//	public String signout(HttpServletRequest request, Model model, AccountDTO accountDto) {
//		logger.info("get signout(HttpServletRequest={}, model={}, accountDto={})", request, model, accountDto);
//		
//		HttpSession session = request.getSession();
//		accountDto = (AccountDTO) session.getAttribute("loginData");
//		
//		String accountid = accountDto.getAccountid();
//		
//		InfoDTO photo = photoService.getUserPhoto(accountid);
//		MemberVO data = service.getAll(accountid);
//		
//		model.addAttribute("photo", photo); // 사진
//		model.addAttribute("data", data);
//		
//		return "/login/signout";
//	}
//	
//	@PostMapping(value="/myinfo/signout")
//	public String signout(Model model, @ModelAttribute MemberVO vo, HttpSession session) {
//		logger.info("post signout");
//		
//		boolean result = service.signout(vo);
//		
//		if(result) {
//			model.addAttribute("msg", "탈퇴가 완료되었습니다.");
//			session.invalidate();
//			model.addAttribute("url", "/home");
//			return "alert";
//		} else {
//			model.addAttribute("msg", "탈퇴를 실패하였습니다. 다시 시도해주세요.");
//			model.addAttribute("url", "/home/myinfo/signout");
//			return "alert";
//		}
//		
//	}

	
}
