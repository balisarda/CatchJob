package com.care.CatchJob.IService;

import java.util.List;

import org.json.simple.JSONObject;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardService {
	// �˹� ��Ͽ� ���� ����
	public List<Board> boardSelectProc(
			String curPage, String searchOpt, String boardsearchWord);
	public Board boardDetailProc(String board_idx);
	public void boardInsertProc(Board board);
	public void boardUpdateProc(Board board);
	public void boardDeleteProc(int board_idx);
	
	// �������� �Խ��ǿ� ���� ����	
	public List<Board_Notice> noticeSelectProc(
			String curPage, String searchOpt, String noticesearchWord);
	public Board_Notice noticeDetailProc(String notice_idx);
	public void noticeInsertProc(Board_Notice board_notice);
	public void noticeUpdateProc(Board_Notice board_notice);
	public void noticeDeleteProc(int notice_idx);
	
	// �ϵ�� �Խ��� ����
	public List<Job> jobSelectProc(
			String curPage, String searchOpt, String boardsearchWord);
	public Job jobDetailProc(String Job_no);
	
	// ���� ȭ�� �Խ��� �̸�����
	public JSONObject loadBoard();

}






