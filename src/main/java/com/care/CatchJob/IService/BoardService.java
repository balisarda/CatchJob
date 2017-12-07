package com.care.CatchJob.IService;

import java.util.List;

import org.json.simple.JSONObject;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardService {
	// 알바 등록에 관한 서비스
	public List<Board> boardSelectProc(
			String curPage, String searchOpt, String boardsearchWord);
	public Board boardDetailProc(String board_idx);
	public void boardInsertProc(Board board);
	public void boardUpdateProc(Board board);
	public void boardDeleteProc(int board_idx);
	
	// 공지사항 게시판에 관한 서비스	
	public List<Board_Notice> noticeSelectProc(
			String curPage, String searchOpt, String noticesearchWord);
	public Board_Notice noticeDetailProc(String notice_idx);
	public void noticeInsertProc(Board_Notice board_notice);
	public void noticeUpdateProc(Board_Notice board_notice);
	public void noticeDeleteProc(int notice_idx);
	
	// 일등록 게시판 서비스
	public List<Job> jobSelectProc(
			String curPage, String searchOpt, String boardsearchWord);
	public Job jobDetailProc(String Job_no);
	
	// 메인 화면 게시판 미리보기
	public JSONObject loadBoard();

}






