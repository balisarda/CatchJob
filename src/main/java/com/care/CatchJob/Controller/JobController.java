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
		//�ϵ��
		@Autowired
		private JobService jobSrv;
		@RequestMapping("jobaddForm")
		public String jobaddForm(Job job, Model model) {		
			jobdao.AddJob(job);									
			return "redirect:/job/jobInfoForm";
		}
		//��ã��
		@RequestMapping("jobfindForm")
		public String jobFindForm(Model model) {
			model.addAttribute("List", jobdao.FindJob());
			model.addAttribute("Listsize", jobdao.FindJob().size());
			return "forward:/job_findForm";
		}
		//�ϵ�� Ȯ��
		@RequestMapping("jobInfoForm")
		public String jobInfoForm(Model model,
				@ModelAttribute("sessionMember") Map<String, Object> sessionNickname ) {
			String sessionId=(String)sessionNickname.get("nickname");
			model.addAttribute("add_list", jobdao.InfoJobById(sessionId));
			model.addAttribute("add_listsize", jobdao.InfoJobById(sessionId).size());
			return "forward:/job_InfoForm";
		}
		//���� Ȯ��
		@RequestMapping("jobapplyForm")
		public String confirm_apply(Model model,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname ) {
				String sessionId=(String)sessionNickname.get("nickname");
				model.addAttribute("apply_list",jobdao.InfoJobByNo(sessionId));
				model.addAttribute("apply_listsize",jobdao.InfoJobByNo(sessionId).size());
			return "forward:/job_applyForm";
		}
		//�����ڼ� ������ ����
		@RequestMapping("getapplyNumProc")
		public @ResponseBody String getapplyNumProc(@RequestParam("no")String no
				) {			
			return jobdao.GetApplyNum(no);
		}
		//������ ����ϱ�
		@RequestMapping("addapplyProc")
		public @ResponseBody String addapplyProc(Apply apply){
			jobdao.applyInfo(apply);
			return "";
		}
		//���� ���� �ϱ�
		@RequestMapping("applydeleteProc")
		public String applydeleteProc(Apply apply){
			jobdao.DeleteApply(apply);
			return "redirect:/job/jobapplyForm";
		}
		//���� �ߺ� �˻�
		@RequestMapping("chkapplyProc")
		public @ResponseBody String chkapply(Apply apply) {
			return jobSrv.getApplyId(apply);
		}
		//�ϵ�� ����
		@RequestMapping("jobdeleteProc")
		public String delete(@RequestParam("no")String no) {
			jobdao.DeleteJob(no);
			return "redirect:/job/jobInfoForm";
		}
		//�ϵ�� ����
		@RequestMapping("jobupdateProc")
		public String update(Job job){
			jobdao.UpdateJob(job);
			return "redirect:/job/jobInfoForm";
		}
		
}
