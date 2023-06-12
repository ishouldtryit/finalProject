package com.kh.synergyZone.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.synergyZone.advice.RequirePermissionException;

@Service
public class AdminInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String admin = (String) session.getAttribute("empAdmin");
		
		if(admin != null && admin.equals("Y")) {
			return true;
		}
		else {
			throw new RequirePermissionException("관리자만 이용 가능합니다");
		}
	}
}
