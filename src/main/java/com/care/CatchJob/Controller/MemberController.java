package com.care.CatchJob.Controller;

import java.util.HashMap;
import java.util.Map;

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
	@RequestMapping("loginProc")// 로그인
	public String loginProc(Model model, Member member, @ModelAttribute("sessionMember") Map<String, Object> Login) {
		if(memberSrv.loginProc(member)) {
			Login.put("nickname", member.getNickname());
			return "redirect:/";
		}
		model.addAttribute("msg", "등록된 회원 정보가 없거나 패스워드가 일치하지 않습니다.");
		return "forward:/login";
	}
	@RequestMapping("logOut")//로그아웃
	public String logOut(@ModelAttribute("sessionMember") Map<String, Object> Login, SessionStatus session) {
		Login.remove("nickname");
		session.isComplete();
		return "redirect:/";
	}
	@RequestMapping("memberProc")//회원가입
	public String memberProc(Model model, Member member, @ModelAttribute("sessionMember") Map<String, Object> sMember, SessionStatus session) {
		int result = memberSrv.memberProc(member, sMember, session);
		
		switch (result) {
		case 1:
			sMember.put("nickname", member.getNickname());
			return "redirect:/login";
		case 2:
			model.addAttribute("msg", "이메일에 대한 인증이 필요합니다.");
			return "forward:/memberForm";
		case 3:
			model.addAttribute("msg", "인증받은 이메일 주소를 사용해야합니다..");
			return "forward:/memberForm";
		case 4:
			model.addAttribute("msg", "아이디 중복 확인이 필요합니다.");
			return "forward:/memberForm";
		}
		return null;
	}
	@RequestMapping("reqAuthNum") // 이메일 인증번호 요청
	public String reqAuthNum(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember) {
		model.addAttribute("msg", mailSrv.reqAuthNum(member, sMember));
		return "forward:/memberForm";
	}
	@RequestMapping("chkNickname") // 아이디 중복 확인
	public String chkNickname(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember) {
		model.addAttribute("msg", memberSrv.chkNickname(member, sMember));
		model.addAttribute("member", member);
		
		return "forward:/memberForm";
	}
	@RequestMapping("chkAuthNum") // 인증번호 확인
	public String chkAuthNum(Member member, Model model, @ModelAttribute("sessionMember") Map<String, Object> sMember, @RequestParam("authNum") String inputAuthNum) {
		model.addAttribute("member", member);
		model.addAttribute("inputAuthNum", inputAuthNum);
		model.addAttribute("msg", memberSrv.chkAuthNum(sMember, inputAuthNum));
		return "forward:/memberForm";
	}
	@RequestMapping("findId") // 이름과 이메일이 일치할 경우 아이디 팝업
	public String findId(Member member, Model model) {
		if(memberSrv.findId(member)!=null) {
			String nickname = memberSrv.findId(member);
			model.addAttribute("msg", "가입하신 계정은 "+nickname+"입니다.");
			return "forward:/findInfoForm";
		}
		model.addAttribute("msg", "요청하신 정보로 가입된 아이디가 존재하지 않습니다.");
		return "forward:/findInfoForm";
	}
	@RequestMapping("findPw") // 패스워드 초기화 후 이메일 전송
	public String findPw(Member member, Model model) {
		if(mailSrv.findPw(member)) {
			model.addAttribute("msg", "입력하신 이메일로 초기화된 패스워드를 발송하였습니다.");
			return "forward:/findInfoForm";
		}
		model.addAttribute("msg", "요청하신 정보가 일치하지 않습니다.");
		return "redirect:/loginForm";
	}
	@RequestMapping("subMemberProc1")
	public String subMemberProc1(Record record) {
		memberSrv.record(record);
		return "forward:/submemberForm";
	}
	@RequestMapping("subMemberProc2")
	public String subMemberProc4(License license) {
		memberSrv.license(license);
		return "forward:/submemberForm";
	}
	@RequestMapping("subMemberProc3")
	public String subMemberProc3(Empinfo empinfo) {
		memberSrv.empinfo(empinfo);
		return "forward:/submemberForm";
	}
	@RequestMapping("searchPostCode")
	public String searchPostCode() {
		return "/form/searchPostCode";
	}
	@RequestMapping("skip")
	public String skip(SessionStatus session) {
		session.setComplete();
		return "/redirect:/";
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
}




















