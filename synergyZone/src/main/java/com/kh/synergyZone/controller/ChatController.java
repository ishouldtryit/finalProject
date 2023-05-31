package com.kh.synergyZone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.synergyZone.repo.ChatRoomRepoImpl;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatRoomRepoImpl chatRoomRepo;
	
	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("chatRoomList", chatRoomRepo.list());
		
		//return "/WEB-INF/views/home.jsp";
		return "chat/home";
	}
	
	@GetMapping("/channel6")
	public String main() {
		return "chat/chat";
	}
	
	
}
