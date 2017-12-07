package com.care.CatchJob.IService;

import java.util.List;

import org.json.simple.JSONObject;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardService {
	// 알바 등록에 관한 서비스
	public List<Board> selectBoard(
			String curPage, String searchOpt, String boardsearchWord);
	public Board detailView(String board_idx);
	public void insertProc(Board board);
	public void boardupdateProc(Board board);
	public void boarddeleteProc(int board_idx);
	
	// 공지사항 게시판에 관한 서비스	
	public List<Board_Notice> noticeselectBoard(
			String curPage, String searchOpt, String noticesearchWord);
	public Board_Notice noticedetailView(String notice_idx);
	public void noticewriteProc(Board_Notice board_notice);
	public void noticeupdateProc(Board_Notice board_notice);
	public void noticedeleteProc(int notice_idx);
	
	// 일등록 게시판 서비스
	public List<Job> selectjobBoard(
			String curPage, String searchOpt, String boardsearchWord);
	public Job jobdetailView(String Job_no);
	
	// 메인 화면 게시판 미리보기
	public JSONObject loadBoard();

}






