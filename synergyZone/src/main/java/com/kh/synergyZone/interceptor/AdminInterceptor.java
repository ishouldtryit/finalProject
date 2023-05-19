//package com.kh.synergyZone.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.stereotype.Service;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//@Service
//public class AdminInterceptor implements HandlerInterceptor{
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		HttpSession session = request.getSession();
//		String deptNo = (String) session.getAttribute("deptNo");
//		
//		
//	}
//}
