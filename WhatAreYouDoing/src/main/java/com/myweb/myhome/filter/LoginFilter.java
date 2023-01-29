package com.myweb.myhome.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(
		urlPatterns = {
				"/add",
				"/postMod", "/modify",
				"/", "/postList*"
		}
)
public class LoginFilter extends HttpFilter implements Filter {

	// 로그인 안 하면 각 메뉴로 바로 접근하지 못하게 함.
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// ServletRequest와 HttpServletRequest는 상속관계. 따라서 HttpServletRequest로 다운캐스팅 시켜줌.
		HttpSession session = ((HttpServletRequest)request).getSession();
		
		if(session.getAttribute("loginData") != null) {
			chain.doFilter(request, response);	// 다음 기능(Servlet)으로 연결시켜주는 메소드. Servlet은 항상 filter를 거쳐야함.
		} else {
			((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getContextPath() + "/login");
		}
	}
}
