package com.kh.synergyZone.advice;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ErrorController {

//	@ExceptionHandler(Exception.class)
//	public String error(Exception ex) {
//		return "/error/404";
//	}
//	
//	@ExceptionHandler(NoHandlerFoundException.class)
//	public String notFound(Exception ex) {
//		ex.printStackTrace();
//		return "/error/404";
//	}
//	
//	@ExceptionHandler(RequirePermissionException.class)
//	public String forbidden(Exception ex) {
//		return "/error/404";
//	}
//	
//	@ExceptionHandler(RequireLoginException.class)
//	public String unAuthorized(Exception ex) {
//		return "redirect:login";
//	}
//	
}