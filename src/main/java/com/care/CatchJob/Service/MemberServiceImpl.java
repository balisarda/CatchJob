package com.care.CatchJob.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.support.SessionStatus;

import com.care.CatchJob.DTO.*;
import com.care.CatchJob.IDAO.MemberDao;
import com.care.CatchJob.IDAO.subMemberDao;
import com.care.CatchJob.IService.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private subMemberDao submemberDao;
	@Override
	public boolean loginProc(Member member) {
		member.setPw(encryptSHA512(member));
		if(memberDao.loginProc(member)==0)
			return false;
		return true;
	}
	@Override
	public int memberProc(Member member, Map<String, Object> sMember, SessionStatus session) {
		String nickname = (String)sMember.get("checkedNickname");
		String email = (String)sMember.get("checkedEmail");
		boolean authNumchk = (Boolean)sMember.get("authNumOk");
		member.setPw(encryptSHA512(member));
		if(nickname.equals(member.getNickname())) {
			if(email.equals(member.getEmail())) {
				if(authNumchk) {
					memberDao.memberProc(member);
					return 1;
				}return 2;
			}return 3;
		}return 4;
	}
	public String encryptSHA512(Member member) {
		String enPw = member.getPw(); 
		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-512");
			sha.update(enPw.getBytes());
			StringBuffer sb = new StringBuffer();
			for(byte b : sha.digest()) {
				sb.append(Integer.toHexString(0xff & b));
			}
			return sb.toString();
		}catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}
	@Override
	public String chkAuthNum(Map<String, Object> sMember, String inputAuthNum) {
		String sessionAuthNum = (String)sMember.get("authNum");
		
		if(inputAuthNum.equals(sessionAuthNum)) {
			sMember.remove("authNum");
			sMember.put("authNumOk", true);
			return "인증 성공";
		}
		return "인증 실패";
	}
	@Override
	public String chkNickname(Member member, Map<String, Object> sMember) {
		if(memberDao.chkNickname(member.getNickname())==0) {
			sMember.put("checkedNickname", member.getNickname());
			return "사용가능한 아이디입니다.";
		}
		return "이미 사용중이거나 탈퇴한 아이디입니다.";
	}
	@Override
	public String findId(Member member) {
		if(memberDao.findIdInfo(member)==null) {
			return null;
		}
		String result = memberDao.findIdInfo(member);
		return result;
	}
	@Override
	public String record(Record record) {
		submemberDao.record(record);
		return null;
	}
	@Override
	public String license(License license) {
		submemberDao.license(license);
		return null;
	}
	@Override
	public String empinfo(Empinfo empinfo) {
		submemberDao.empinfo(empinfo);
		return null;
	}
	@Override
	public JSONObject loadInfo(String nickname) {
		JSONObject result = new JSONObject();
		JSONArray recordArray = new JSONArray();
		JSONObject recordInfo = new JSONObject();
		HashMap<String, Object> a = new HashMap<String, Object>();
		HashMap<String, Object> b = new HashMap<String, Object>();
		HashMap<String, Object> c = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> record = submemberDao.loadInfo_record(nickname);
		List<HashMap<String, Object>> license = submemberDao.loadInfo_license(nickname);
		List<HashMap<String, Object>> empinfo = submemberDao.loadInfo_empinfo(nickname);
//		System.out.println(record);
	//	System.out.println(record.size());
		for(int i = 0; i<record.size()-1;i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			str.put(i, record.get(i));//0=record.get(0)
			a = (HashMap<String, Object>) str.get(i);

			
			//System.out.println(str.get(0));
			//{RECORD_COMMENT=최고, RECORD_EMP=매장관리, RECORD_DUTY=사장, RECORD_MONTH1=12, RECORD_YEAR2=1121, RECORD_YEAR1=1111, RECORD_MONTH2=12}
			//System.out.println(str);
			//{0={RECORD_COMMENT=최고, RECORD_EMP=매장관리, RECORD_DUTY=사장, RECORD_MONTH1=12, RECORD_YEAR2=1121, RECORD_YEAR1=1111, RECORD_MONTH2=12}}
			recordInfo.put("emp", a.get("RECORD_EMP"));
			recordInfo.put("year1", a.get("RECORD_YEAR1"));
			recordInfo.put("month1", a.get("RECORD_MONTH1"));
			recordInfo.put("year2", a.get("RECORD_YEAR2"));
			recordInfo.put("month2", a.get("RECORD_MONTH2"));
			recordInfo.put("duty", a.get("RECORD_DUTY"));
			recordInfo.put("comment", a.get("RECORD_COMMENT"));
			
			recordArray.add(recordInfo);
			result.put("recordlist", recordArray);
		}
/*		a = record.get(0);*/
		b = license.get(0);
		c = empinfo.get(0);
/*						System.out.println(record);
						System.out.println(a);*/
/*		recordInfo.put("emp", a.get("RECORD_EMP"));
		recordInfo.put("year1", a.get("RECORD_YEAR1"));
		recordInfo.put("month1", a.get("RECORD_MONTH1"));
		recordInfo.put("year2", a.get("RECORD_YEAR2"));
		recordInfo.put("month2", a.get("RECORD_MONTH2"));
		recordInfo.put("duty", a.get("RECORD_DUTY"));
		recordInfo.put("comment", a.get("RECORD_COMMENT"));
		
		recordArray.add(recordInfo);
		result.put("recordlist", recordArray);*/

		JSONArray licenseArray = new JSONArray();
		JSONObject licenseInfo = new JSONObject();

		licenseInfo.put("name", b.get("LICENSE_NAME"));
		licenseInfo.put("date", b.get("LICENSE_DATE"));
		licenseArray.add(licenseInfo);
		result.put("licenselist", licenseArray);
		
		JSONArray empinfoArray = new JSONArray();
		JSONObject empinfoInfo = new JSONObject();
		
		empinfoInfo.put("emp_name", c.get("EMP_NAME"));
		empinfoInfo.put("postcode", c.get("EMP_ZIPCODE"));
		empinfoInfo.put("addr1", c.get("EMP_ADDR1"));
		empinfoInfo.put("addr2", c.get("EMP_ADDR2"));
		empinfoArray.add(empinfoInfo);
		result.put("empinfolist", empinfoArray);

		return result;
	}
}








