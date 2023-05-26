package com.kh.synergyZone.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.synergyZone.interceptor.AdminInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(adminInterceptor)
								.addPathPatterns("/admin/job/register");
	}
	
	
	
}
