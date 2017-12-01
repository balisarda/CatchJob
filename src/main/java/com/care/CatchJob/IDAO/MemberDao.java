package com.care.CatchJob.IDAO;

import java.util.Map;

import com.care.CatchJob.DTO.Member;

public interface MemberDao {
	public int loginProc(Member member);
	public void memberProc(Member member);
	public void insertMember(Member member);
	public int chkNickname(String nickname);
	public int findPw(Member member);
	public String findIdInfo(Member member);
	public void findPwInfo(Map<String, String> map);
	
}
