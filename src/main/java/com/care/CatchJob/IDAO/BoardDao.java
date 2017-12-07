package com.care.CatchJob.IDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardDao {
	
	// 알바 등록에 관한 서비스
	public List<Board> selectBoard(Map<String, Object> map);
	public int selectBoardCnt(Map<String, String> map);
	public Board detailView(int board_idx);
	public void insertProc(Board board);
	public void boardupdateProc(Board board);
	public void boarddeleteProc(int board_idx);
	
	// 공지사항 게시판에 관한 서비스
	public List<Board_Notice> noticeselectBoard(Map<String, Object> map);
	public int noticeselectCnt(int map);
	public Board_Notice noticedetailView(int notice_idx);
	public void noticewriteProc(Board_Notice board_notice);
	public void noticeupdateProc(Board_Notice board_notice);
	public void noticedeleteProc(int notice_idx);
	public void noticehitsProc(int notice_idx);
	
	// 일등록 게시판 서비스
	public List<Job> selectjobBoard(Map<String, Object> map);
	public int jobselectCnt(Map<String, String> map);
	public Job jobdetailView(int no);
	
	// 메인 공지, 구인, 구직 미리보기
	public List<HashMap<String, Object>> loadBoard();
	public List<HashMap<String, Object>> loadNotice();
	public List<HashMap<String, Object>> loadJob();
}






