package com.care.CatchJob.Controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.care.CatchJob.DTO.*;
import com.care.CatchJob.IService.MailService;
import com.care.CatchJob.IService.MemberService;

@Controller
@RequestMapping("member")
@SessionAttributes("sessionMember")
public class MemberController {
	@Autowired
	private MemberService memberSrv;
	@Autowired
	private MailService mailSrv;
	
	@ModelAttribute("sessionMember")
	public Map<String, Object> getSessionInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authNumOk", false);
		return map;
	}
	@RequestMapping("loginProc")// �α���
	public String loginProc(Model model, Member member, @ModelAttribute("sessionMember") Map<String, Object> Login) {
		if(memberSrv.loginProc(member)) {
			Login.put("nickname", member.getNickname());
			return "redirect:/";
		}
		model.addAttribute("msg", "��ϵ� ȸ�� ������ ���ų� �н����尡 ��ġ���� �ʽ��ϴ�.");
		return "forward:/login";
	}
	@RequestMapping("logOut")//�α׾ƿ�
	public String logOut(@ModelAttribute("sessionMember") Map<String, Object> Login, SessionStatus session) {
		Login.remove("nickname");
		session.isComplete();
		return "redirect:/";
	}
	@RequestMapping("memberProc")//ȸ������
	public String memberProc(Model model, Member member, @ModelAttribute("sessionMember") Map<String, Object> sMember, SessionStatus session) {
		int result = memberSrv.memberProc(member, sMember, session);
		
		switch (result) {
		case 1:
			sMember.put("nickname", member.getNickname());
			return "redirect:/login";
		case 2:
			model.addAttribute("msg", "�̸��Ͽ� ���� ������ �ʿ��մϴ�.");
			return "forward:/memberForm";
		case 3:
			model.addAttribute("msg", "�������� �̸��� �ּҸ� ����ؾ��մϴ�..");
			return "forward:/memberForm";
		case 4:
			model.addAttribute("msg", "���̵� �ߺ� Ȯ���� �ʿ��մϴ�.");
			return "forward:/memberForm";
		}
		return null;
	}
	@RequestMapping("reqAuthNum") // �̸��� ������ȣ ��û
	public String reqAuthNum(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember) {
		model.addAttribute("msg", mailSrv.reqAuthNum(member, sMember));
		return "forward:/memberForm";
	}
	@RequestMapping("chkNickname") // ���̵� �ߺ� Ȯ��
	public String chkNickname(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember) {
		model.addAttribute("msg", memberSrv.chkNickname(member, sMember));
		model.addAttribute("member", member);
		
		return "forward:/memberForm";
	}
	@RequestMapping("chkAuthNum") // ������ȣ Ȯ��
	public String chkAuthNum(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember, @RequestParam("authNum") String inputAuthNum) {
		model.addAttribute("member", member);
		model.addAttribute("inputAuthNum", inputAuthNum);
		model.addAttribute("msg", memberSrv.chkAuthNum(sMember, inputAuthNum));
		return "forward:/memberForm";
	}
	@RequestMapping("findId") // �̸��� �̸����� ��ġ�� ��� ���̵� �˾�
	public String findId(Member member, Model model) {
		if(memberSrv.findId(member)!=null) {
			String nickname = memberSrv.findId(member);
			model.addAttribute("msg", "�����Ͻ� ������ "+nickname+"�Դϴ�.");
			return "forward:/findInfoForm";
		}
		model.addAttribute("msg", "��û�Ͻ� ������ ���Ե� ���̵� �������� �ʽ��ϴ�.");
		return "forward:/findInfoForm";
	}
	@RequestMapping("findPw") // �н����� �ʱ�ȭ �� �̸��� ����
	public String findPw(Member member, Model model) {
		if(mailSrv.findPw(member)) {
			model.addAttribute("msg", "�Է��Ͻ� �̸��Ϸ� �ʱ�ȭ�� �н����带 �߼��Ͽ����ϴ�.");
			return "forward:/findInfoForm";
		}
		model.addAttribute("msg", "��û�Ͻ� ������ ��ġ���� �ʽ��ϴ�.");
		return "redirect:/loginForm";
	}
	@RequestMapping("insert_record")
	public String insert_record(Record record) {
		memberSrv.record(record);
		return "forward:/submemberForm";
	}
	@RequestMapping("insert_license")
	public String insert_license(License license) {
		memberSrv.license(license);
		return "forward:/submemberForm";
	}
	@RequestMapping("insert_empinfo")
	public String insert_empinfo(Empinfo empinfo) {
		memberSrv.empinfo(empinfo);
		return "forward:/submemberForm";
	}
	@RequestMapping("/member/loadInfo")
	@ResponseBody
	public JSONObject loadInfo(@ModelAttribute("sessionMember") Map<String, Object> Login) {
		String nickname = (String)Login.get("nickname");
		return memberSrv.loadInfo(nickname);
	}
	@RequestMapping("memberInfo")
	public String memberInfo(Model model, @ModelAttribute("sessionMember") Map<String, Object> Login) {
		return "forward:/submemberForm";
	}
	@RequestMapping("delete_record")
	public String delete_record(@ModelAttribute("sessionMember") Map<String, Object> Login, @RequestParam("recordnum") int num) {
		String nickname = (String)Login.get("nickname");
		memberSrv.delete_record(nickname, num);
		return "forward:/submemberForm";
	}
	@RequestMapping("delete_license")
	public String delete_license(@ModelAttribute("sessionMember") Map<String, Object> Login, @RequestParam("licensenum") int num) {		
		String nickname = (String)Login.get("nickname");
		memberSrv.delete_license(nickname, num);
		return "forward:/submemberForm";
	}
	@RequestMapping("delete_empinfo")
	public String delete_empinfo(@ModelAttribute("sessionMember") Map<String, Object> Login, @RequestParam("empinfonum") int num) {		
		String nickname = (String)Login.get("nickname");
		memberSrv.delete_empinfo(nickname, num);
		return "forward:/submemberForm";
	}
}