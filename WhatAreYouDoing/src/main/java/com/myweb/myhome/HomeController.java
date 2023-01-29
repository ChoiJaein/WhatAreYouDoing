package com.myweb.myhome;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.myweb.myhome.common.util.Paging;
import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.member.service.MemberService;
import com.myweb.myhome.member.vo.MemberVO;
import com.myweb.myhome.post.model.PostDTO;
import com.myweb.myhome.post.service.PostService;
import com.myweb.myhome.upload.model.PhotoUploadDTO;

@Controller
public class HomeController {
	
	@Autowired
	private PostService service;
	
	@Autowired
	private MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping(value="/")
	public String getList(HttpServletRequest request, Model model, HttpSession session, LoginDTO loginDto
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		logger.info("GET Main page getList");
		
		session = request.getSession();
		loginDto = (LoginDTO) session.getAttribute("loginData");
		String userId = loginDto.getUserId();
		String userName = loginDto.getUserName();
		logger.info("getList(userId={})", userId);
		

		PhotoUploadDTO photo = memberService.getUserPhoto(userId);
		model.addAttribute("photo", photo);
		
		List datas = service.getAll(userId);
		System.out.println(datas);
		
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		if(pageCount > 0 ) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);	// datas, 첫번째 페이지, 한 페이지에 다섯개씩
		
		model.addAttribute("datas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("userName", userName);
		
		return "home";
	}
	
	@GetMapping(value="/detail")
	public String getDetail(Model model
			, HttpSession session
			, @RequestParam int postId) {
		logger.info("getDetail(postId={})", postId);
		
		PostDTO data = service.getData(postId);
		
		if(data != null) {
			model.addAttribute("data", data);
			return "post/detail";
		} else {
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/notExists";
		}
	}
	
	@GetMapping(value="/add")
	public String add() {
		logger.info("add()");
		return "post/add";
	}
	
	@PostMapping(value="/add")
	public String add(@SessionAttribute("loginData") LoginDTO loginDto
			, @ModelAttribute PostDTO postDto) {
		logger.info("add(PostDto={})", postDto);
		
		PostDTO data = new PostDTO();
		data.setUserId(loginDto.getUserId());
		data.setPostTitle(postDto.getPostTitle());
		data.setPostContent(postDto.getPostContent());
		
		logger.info("first check(PostDto={})", postDto);
		
		int postId = service.add(data);
		logger.info("second check(postDto={})", postDto);
		if(postId != -1) {
			logger.info("postId check(postId={})", postId);
			return "redirect:/detail?postId=" + postId;
		} else {
			return "post/add";
		}
	}
	
	@GetMapping(value="/postMod")
	public String modify(Model model
			, @RequestParam int postId) {
		
		logger.info("Get modify(postId={})", postId);
		
		PostDTO data = service.getData(postId);	
		if(data != null) {	
			model.addAttribute("data", data);
			return "post/modify";	
		} else {
		model.addAttribute("error", "해당 게시글이 존재하지 않습니다.");
		return "error/noExists";
		}
	}
	
	@PostMapping(value="/postMod")	
	public String modify(Model model
			, @ModelAttribute PostDTO postDto) {	
		logger.info("Post Modify(postDto={})", postDto);
		
		PostDTO data = service.getData(postDto.getPostId());		
		
		if(data != null) {
			data.setPostTitle(postDto.getPostTitle());
			data.setPostContent(postDto.getPostContent());
			boolean result = service.modify(data);
			if(result) {
				return "redirect:/detail?postId=" + data.getPostId();
			} else {	
				return modify(model, postDto.getPostId());
			} 
		} else {					
			model.addAttribute("error", "해당 게시글이 존재하지 않습니다.");
			return "error/noExists";
		}
	}
	
	@PostMapping(value="/delete", produces="application/json; charset=utf-8")
	@ResponseBody
	public String delete(@RequestParam int postId) {
		logger.info("Post delete(postId={})", postId);
		PostDTO data = service.getData(postId);
		JSONObject json = new JSONObject();
		
		if(data == null) {
			// 삭제할 데이터 없음
			json.put("code", "notExists");
			json.put("message", "이미 삭제 된 데이터 입니다.");
		} else {
			boolean result = service.remove(data);
			logger.info("Post delete Result(result={})", result);
			if(result) {
				json.put("code", "success");
				System.out.println(json);
				json.put("message", "삭제가 완료되었습니다.");
			} else {
				json.put("code", "fail");
				System.out.println(json);
				json.put("message", "삭제 작업 중 문제가 발생하였습니다.");
			}
		}
		System.out.println(json.toJSONString());
		return json.toJSONString();
	}
	
	
	@GetMapping(value="/postList_search")
	public String postSearch(HttpServletRequest request, Model model, HttpSession session, LoginDTO loginDto
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount
			, @RequestParam("keyword") String keyword) {
		logger.info("GET postSearch");
		Map<String, String> map = new HashMap<String, String>();
		
		session = request.getSession();
		loginDto = (LoginDTO) session.getAttribute("loginData");
		String userId = loginDto.getUserId();
		String userName = loginDto.getUserName();
		map.put("userId", userId);
		map.put("keyword", keyword);
		logger.info("getUserId(userId={})", userId);
		logger.info("getKeyword(keyword={})", keyword);
		logger.info("getMap(map={})", map);
		
		PhotoUploadDTO photo = memberService.getUserPhoto(userId);
		model.addAttribute("photo", photo);

		List datas = service.postSearch(map);
		System.out.println(datas);
		
		
		if(session.getAttribute("pageCount") == null) {
			session.setAttribute("pageCount", 5);
		}
		if(pageCount > 0 ) {
			session.setAttribute("pageCount", pageCount);
		}
		
		pageCount = Integer.parseInt(session.getAttribute("pageCount").toString());
		Paging paging = new Paging(datas, page, pageCount);	// datas, 첫번째 페이지, 한 페이지에 다섯개씩
		
		model.addAttribute("datas", paging.getPageData());
		model.addAttribute("pageData", paging);
		model.addAttribute("userName", userName);
		
		return "post/search";
	}
	
}
