package com.kh.synergyZone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@GetMapping("/")
	public String reservation() {
		return "/reservation/list";
	}
}
