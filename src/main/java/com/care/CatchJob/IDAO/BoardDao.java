package com.care.CatchJob.IDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardDao {
	
	// 알바 등록에 관한 서비스
	public List<Board> boardSelectProc(Map<String, Object> map);
	public int boardSelectCnt(Map<String, String> map);
	public Board boardDetailProc(int board_idx);
	public void boardInsertProc(Board board);
	public void boardUpdateProc(Board board);
	public void boardDeleteProc(int board_idx);
	public void boardHitsProc(int board_idx);
	
	// 공지사항 게시판에 관한 서비스
	public List<Board_Notice> noticeSelectProc(Map<String, Object> map);
	public int noticeSelectCnt(int map);
	public Board_Notice noticeDetailProc(int notice_idx);
	public void noticeInsertProc(Board_Notice board_notice);
	public void noticeUpdateProc(Board_Notice board_notice);
	public void noticeDeleteProc(int notice_idx);
	public void noticeHitsProc(int notice_idx);
	
	// 일등록 게시판 서비스
	public List<Job> jobSelectProc(Map<String, Object> map);
	public int jobDelectCnt(Map<String, String> map);
	public Job jobDetailProc(int no);
	public void jobHitsProc(int job_idx);
	
	// 메인 공지, 구인, 구직 미리보기
	public List<HashMap<String, Object>> loadBoard();
	public List<HashMap<String, Object>> loadNotice();
	public List<HashMap<String, Object>> loadJob();
}






