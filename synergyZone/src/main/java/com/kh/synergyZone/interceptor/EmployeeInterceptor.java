package com.kh.synergyZone.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.synergyZone.advice.RequireLoginException;

//비회원이 회원 기능에 접근하는 것을 차단하기 위한 인터셉터
@Service
public class EmployeeInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		//로그인 상태 = 세션에 있는 memberId가 null이 아닌 경우
		HttpSession session = request.getSession();
		String empNo = (String)session.getAttribute("empNo");
		
		if(empNo != null) {//회원이라면
			return true;
		}
		else {//비회원이라면 - 로그인 페이지로 이동시키면서 차단
			//리다이렉트 코드
			//response.sendRedirect("/member/login");//return "redirect:/member/login"
			//response.sendError(401);
			//return false;
			throw new RequireLoginException("로그인 후 이용 가능합니다");
		}
	}
}




