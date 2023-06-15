package com.kh.synergyZone.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

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
		
		if(empNo != null) {
			return true;
		}
		else {

			response.sendRedirect("login");
			return false;

		}
	}
}




