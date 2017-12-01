package com.care.CatchJob.Service;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.CatchJob.DTO.Member;
import com.care.CatchJob.IDAO.MemberDao;
import com.care.CatchJob.IService.MailService;

@Service
public class MailServiceImpl implements MailService {
	@Autowired
	private MemberDao memberDao;
	String id = "balisarda88";
	String pw = "vhshvhsh1";
	public String sndUsrName = "administrator";
	public String sndUsrEmail = "balisarda88@gmail.com";
	public String authNum = String.format("%04d", (int)(Math.random()*10000));
	
	@Override
	public String reqAuthNum(Member member, Map<String, Object> sMember) {
		String title = "인증 번호";
		String contents = "인증 번호는 [ "+authNum+" ] 입니다.";

		SendMail(sndUsrName, sndUsrEmail, member, title, contents);
		/*SendMail(sndUsrName, sndUsrEmail, recvUsrEmail, title, contents);*/
		
		sMember.put("authNum", authNum);
		sMember.put("checkedEmail", member.getEmail());
		return "입력하신 이메일로 인증 번호가 발송되었습니다.";
	}
	public boolean SendMail(String sndUsrName, String sndUsrEmail, Member member, String title, String contents) {
		getProperties(sndUsrEmail);
		
		Session session = getAuthentication();
		
		Message msg = new MimeMessage(session);
		try {
			msg.setFrom(new InternetAddress(sndUsrEmail, MimeUtility.encodeText(sndUsrName, "UTF-8", "B")));
			InternetAddress [] address = {new InternetAddress(member.getEmail())};

			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(title);
			msg.setSentDate(new java.util.Date());
			msg.setContent(contents, "text/html;charset=UTF-8");
			Transport.send(msg);
			} catch (UnsupportedEncodingException | MessagingException e) {
				e.printStackTrace();
				return false;
		}
		return true;
	}
	Properties props = new Properties();
	private void getProperties(String sndUsrEmail) {
		props.put("mail.smtp.starttls.enalble", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		//보내는 사람 주소 설정
		props.put("mail.smtp.user", sndUsrEmail);
	}
	private Session getAuthentication() {
		if(id.equals("") || pw.equals(""))
			return null;
		return Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(id, pw);
			}
		});
	}
	@Override
	public boolean findPw(Member member) {
		String title = "문의하신 사항입니다.";
		String contents = "";
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname", member.getNickname());
		map.put("email", member.getEmail());
		
		if(memberDao.findPw(member)==0) {
			return false;
		}else {
			String pw = initPw();
			String enPw = encryptSHA512(pw);
			map.put("pw", enPw);
			memberDao.findPwInfo(map);
			contents = "변경된 패스워드는 " + pw +"입니다.";
			SendMail(sndUsrName, sndUsrEmail, member, title, contents);
			return true;
		}
	}
	public String encryptSHA512(String passwd) {
		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-512");
			sha.update(passwd.getBytes());
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
	public String initPw() {
		StringBuffer sb = new StringBuffer();
		Random rNum = new Random();
		
		for(int i=0;i<7;i++) {
			int rIndex = rNum.nextInt(3);
			switch(rIndex) {
			case 0:
				sb.append((char)((int)(rNum.nextInt(26))+97));
				break;
			case 1:
				sb.append((char)((int)(rNum.nextInt(26))+65));
				break;
			case 2:
				sb.append((rNum.nextInt(10)));
				break;
			}
		}
		return sb.toString();
	}
}
