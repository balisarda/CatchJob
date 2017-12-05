package com.care.CatchJob.DTO;

public class Apply {
	private String no;
	private String member_nickname;
	private String apply_contents;
	private String apply_status;
	public String getApply_contents() {
		return apply_contents;
	}
	public void setApply_contents(String apply_contents) {
		this.apply_contents = apply_contents;
	}	
	public String getApply_status() {
		return apply_status;
	}
	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
}	