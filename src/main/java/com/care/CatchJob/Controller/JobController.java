package com.care.CatchJob.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.care.CatchJob.DTO.Job;
import com.care.CatchJob.IDAO.JobDao;

@Controller
@RequestMapping("job")
@SessionAttributes("sessionMember")
public class JobController {
	@Autowired
	private JobDao jobdao;

	@RequestMapping("add")
	public String addjob(Job job, Model model) {
		jobdao.AddJob(job);
		return "forward:/job/confirm_add";
	}

	@RequestMapping("find")
	public String findjob(Model model) {
		model.addAttribute("List", jobdao.FindJob());
		model.addAttribute("Listsize", jobdao.FindJob().size());

		return "forward:/findjob";
	}

	@RequestMapping("confirm_add")
	public String confirm_job(Job job, Model model) {
		model.addAttribute("add_list", jobdao.InfoJob("chul"));
		model.addAttribute("add_listsize", jobdao.InfoJob("chul").size());
		return "forward:/jobInfo";
	}

	@RequestMapping("delete")
	public String delete(@RequestParam("no") String no) {
		jobdao.DeleteJob(no);
		return "redirect:/job/confirm_add";
	}

	@RequestMapping("update")
	public String update(Job job) {
		jobdao.UpdateJob(job);
		return "redirect:/job/confirm_add";
	}
}
