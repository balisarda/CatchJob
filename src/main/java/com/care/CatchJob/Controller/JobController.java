package com.care.CatchJob.Controller;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.care.CatchJob.DTO.Apply;
import com.care.CatchJob.DTO.Job;
import com.care.CatchJob.IDAO.JobDao;
import com.care.CatchJob.IService.JobService;


	@Controller
	@RequestMapping("job")
	@SessionAttributes("sessionMember")
	public class JobController {
		@Autowired		
		private JobDao jobdao;
		//일등록
		@Autowired
		private JobService jobSrv;
		@RequestMapping("jobaddForm")
		public String jobaddForm(Job job, Model model) {		
			jobdao.AddJob(job);									
			return "redirect:/job/jobInfoForm";
		}
		//일찾기
		@RequestMapping("jobfindForm")
		public String jobFindForm(Model model) {
			model.addAttribute("List", jobdao.FindJob());
			model.addAttribute("Listsize", jobdao.FindJob().size());
			return "forward:/job_findForm";
		}
		//일등록 확인
		@RequestMapping("jobInfoForm")
		public String jobInfoForm(Model model,
				@ModelAttribute("sessionMember") Map<String, Object> sessionNickname ) {
			String sessionId=(String)sessionNickname.get("nickname");
			model.addAttribute("add_list", jobdao.InfoJobById(sessionId));
			model.addAttribute("add_listsize", jobdao.InfoJobById(sessionId).size());
			return "forward:/job_InfoForm";
		}
		//지원 확인
		@RequestMapping("jobapplyForm")
		public String confirm_apply(Model model,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname ) {
				String sessionId=(String)sessionNickname.get("nickname");
				model.addAttribute("apply_list",jobdao.InfoJobByNo(sessionId));
				model.addAttribute("apply_listsize",jobdao.InfoJobByNo(sessionId).size());
			return "forward:/job_applyForm";
		}
		//지원자수 가지고 오기
		@RequestMapping("getapplyNumProc")
		public @ResponseBody String getapplyNumProc(@RequestParam("no")String no
				) {			
			return jobdao.GetApplyNum(no);
		}
		//지원자 등록하기
		@RequestMapping("addapplyProc")
		public @ResponseBody String addapplyProc(Apply apply){
			jobdao.applyInfo(apply);
			return "";
		}
		//지원 삭제 하기
		@RequestMapping("applydeleteProc")
		public String applydeleteProc(Apply apply){
			jobdao.DeleteApply(apply);
			return "redirect:/job/jobapplyForm";
		}
		//지원 중복 검사
		@RequestMapping("chkapplyProc")
		public @ResponseBody String chkapply(Apply apply) {
			return jobSrv.getApplyId(apply);
		}
		//일등록 삭제
		@RequestMapping("jobdeleteProc")
		public String delete(@RequestParam("no")String no) {
			jobdao.DeleteJob(no);
			return "redirect:/job/jobInfoForm";
		}
		//일등록 수정
		@RequestMapping("jobupdateProc")
		public String update(Job job){
			jobdao.UpdateJob(job);
			return "redirect:/job/jobInfoForm";
		}
		
}
