package com.care.CatchJob.IService;

import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.web.bind.support.SessionStatus;

import com.care.CatchJob.DTO.*;

public interface MemberService {
	public boolean loginProc(Member member);
	public int memberProc(Member member, Map<String, Object> sMember, SessionStatus session);
	public String chkAuthNum(Map<String, Object> sMember, String inputAuthNum);
	public String chkNickname(Member member, Map<String, Object> sMember);
	public String encryptSHA512(Member member);
	public String findId(Member member);
	public String record(Record record);
	public String license(License license);
	public String empinfo(Empinfo empinfo);
	public JSONObject loadInfo(String nickname);
	public void delete_record(String nickname, int num);
	public void delete_license(String nickname, int num);
	public void delete_empinfo(String nickname, int num);
}
