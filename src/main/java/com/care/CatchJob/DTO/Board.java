package com.care.CatchJob.DTO;

public class Board {
	// 알바 등록폼에 게시판 내용
	private int board_idx;        
	private String member_nickname;
	private String board_title;
	private String board_date;
	private String board_type;
	private String board_time;
	private String board_pay;
	private String board_addr;
	private String board_contents;
	
	private int board_hits;
	
	// 회원정보 가져오기 위한 필드
	private String member_name;
	private String member_age;
	private String member_gender;
	private String member_phone;
	
	public int getBoard_hits() {
		return board_hits;
	}
	public void setBoard_hits(int board_hits) {
		this.board_hits = board_hits;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_age() {
		return member_age;
	}
	public void setMember_age(String member_age) {
		this.member_age = member_age;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getBoard_time() {
		return board_time;
	}
	public void setBoard_time(String board_time) {
		this.board_time = board_time;
	}
	public String getBoard_pay() {
		return board_pay;
	}
	public void setBoard_pay(String board_pay) {
		this.board_pay = board_pay;
	}
	public String getBoard_addr() {
		return board_addr;
	}
	public void setBoard_addr(String board_addr) {
		this.board_addr = board_addr;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}

}