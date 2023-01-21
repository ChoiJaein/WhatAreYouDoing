package com.myweb.myhome;

import java.util.List;

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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.myweb.myhome.common.util.Paging;
import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.member.vo.MemberVO;
import com.myweb.myhome.post.model.PostDTO;
import com.myweb.myhome.post.service.PostService;

@Controller
public class HomeController {
	
	@Autowired
	private PostService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping(value="/")
	public String getList(Model model, HttpSession session
			, @RequestParam(defaultValue="1", required=false) int page
			, @RequestParam(defaultValue="0", required=false) int pageCount) {
		logger.info("GET Main page getList");
		
		List datas = service.getAll();
		
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
		model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
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
			model.addAttribute("error", "해당 데이터가 존재하지 않습니다.");
			return "error/noExists";
		}
	}
}
