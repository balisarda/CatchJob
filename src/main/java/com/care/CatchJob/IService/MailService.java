package com.care.CatchJob.IService;

import java.util.Map;

import com.care.CatchJob.DTO.Member;

public interface MailService {
	public String reqAuthNum(Member member, Map<String, Object> sMember);
	public boolean findPw(Member member);
}
