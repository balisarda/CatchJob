package com.care.CatchJob.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping(value = "/")
	public String main() {
		return "redirect:main";
	}
	@RequestMapping(value = "/{formPath}")
	public String homeForm(@PathVariable("formPath") String formPath, Model model) {
		model.addAttribute("formPath", formPath);
		return "index";
	}
	@RequestMapping(value = "/form/{formPath}")
	public String moveForm(@PathVariable("formPath") String formPath) {
		String[] array = formPath.split("_");

		if(array[0].equals("board")) {
			return "/form/board/"+formPath;
		}
		return "/form/"+formPath;
	}
	@RequestMapping(value = "/sidebar")
	public String sidebar() {
		return "common/sidebar";
	}
	@RequestMapping(value = "/top")
	public String top() {
		return "common/top";
	}

}
