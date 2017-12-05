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
					session.setComplete();
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
		String result = memberDao.findIdInfo(member);
		if(result==null) {
			return null;
		}
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
		JSONArray licenseArray = new JSONArray();
		JSONArray empinfoArray = new JSONArray();
		
		List<HashMap<String, Object>> record = submemberDao.loadInfo_record(nickname);
		List<HashMap<String, Object>> license = submemberDao.loadInfo_license(nickname);
		List<HashMap<String, Object>> empinfo = submemberDao.loadInfo_empinfo(nickname);

		for(int i = 0; i<record.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> a = new HashMap<String, Object>();

			JSONObject recordInfo = new JSONObject();
			str.put(i, record.get(i));

			a = (HashMap<String, Object>) str.get(i);

			recordInfo.put("num", a.get("RECORD_NUM"));
			recordInfo.put("emp", a.get("RECORD_EMP"));
			recordInfo.put("year1", a.get("RECORD_YEAR1"));
			recordInfo.put("month1", a.get("RECORD_MONTH1"));
			recordInfo.put("year2", a.get("RECORD_YEAR2"));
			recordInfo.put("month2", a.get("RECORD_MONTH2"));
			recordInfo.put("duty", a.get("RECORD_DUTY"));
			recordInfo.put("comment", a.get("RECORD_COMMENT"));
			
			recordArray.add(recordInfo);
			
		}
		result.put("recordlist", recordArray);

		for(int i = 0; i<license.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> b = new HashMap<String, Object>();

			JSONObject licenseInfo = new JSONObject();
			str.put(i, license.get(i));

			b = (HashMap<String, Object>) str.get(i);

			licenseInfo.put("num", b.get("LICENSE_NUM"));
			licenseInfo.put("name", b.get("LICENSE_NAME"));
			licenseInfo.put("date", b.get("LICENSE_DATE"));
			
			licenseArray.add(licenseInfo);
			
		}
		result.put("licenselist", licenseArray);
		
		for(int i = 0; i<empinfo.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> c = new HashMap<String, Object>();

			JSONObject empinfoInfo = new JSONObject();
			str.put(i, empinfo.get(i));
			c = (HashMap<String, Object>) str.get(i);
			empinfoInfo.put("num", c.get("EMP_NUM"));
			empinfoInfo.put("emp_name", c.get("EMP_NAME"));
			empinfoInfo.put("postcode", c.get("EMP_ZIPCODE"));
			empinfoInfo.put("addr1", c.get("EMP_ADDR1"));
			empinfoInfo.put("addr2", c.get("EMP_ADDR2"));
			
			empinfoArray.add(empinfoInfo);
		}
		result.put("empinfolist", empinfoArray);

		return result;
	}
	@Override
	public void delete_record(String nickname, int num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		map.put("num", num);
		submemberDao.deleteRecord(map);
	}
	@Override
	public void delete_license(String nickname, int num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		map.put("num", num);
		submemberDao.deleteLicense(map);
	}
	@Override
	public void delete_empinfo(String nickname, int num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		map.put("num", num);
		submemberDao.deleteEmpinfo(map);
	}
	@Override
	public JSONObject memeberInfo(String nickname) {
		JSONObject result = new JSONObject();
		HashMap<String, Object> info = memberDao.memberInfo(nickname);

		result.put("name", info.get("MEMBER_NAME"));
		result.put("pw", info.get("MEMBER_PW"));
		result.put("nickname", info.get("MEMBER_NICKNAME"));
		result.put("email", info.get("MEMBER_EMAIL"));
		result.put("phone", info.get("MEMBER_PHONE"));

		return result;
	}
	@Override
	public int memberInfo_modi(Member member, Map<String, Object> sMember, String oldemail, String oldphone) {
		String email = (String)sMember.get("checkedEmail");
		boolean authNumchk = (Boolean)sMember.get("authNumOk");
		member.setPw(encryptSHA512(member));
		if(email.equals(oldemail)) {
			member.setEmail(null);
		}
		if(member.getPhone().equals(oldphone)) {
			member.setPhone(null);
		}
		if(authNumchk) {
			memberDao.memberInfo_modi(member);
			return 1;
		}
		return 2;
		
	}
	
}