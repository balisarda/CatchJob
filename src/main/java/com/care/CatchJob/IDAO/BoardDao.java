package com.care.CatchJob.IDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardDao {
	
	// �˹� ��Ͽ� ���� ����
	public List<Board> selectBoard(Map<String, Object> map);
	public int selectBoardCnt(Map<String, String> map);
	public Board detailView(int board_idx);
	public void insertProc(Board board);
	public void boardupdateProc(Board board);
	public void boarddeleteProc(int board_idx);
	
	// �������� �Խ��ǿ� ���� ����
	public List<Board_Notice> noticeselectBoard(Map<String, Object> map);
	public int noticeselectCnt(int map);
	public Board_Notice noticedetailView(int notice_idx);
	public void noticewriteProc(Board_Notice board_notice);
	public void noticeupdateProc(Board_Notice board_notice);
	public void noticedeleteProc(int notice_idx);
	public void noticehitsProc(int notice_idx);
	
	// �ϵ�� �Խ��� ����
	public List<Job> selectjobBoard(Map<String, Object> map);
	public int jobselectCnt(Map<String, String> map);
	public Job jobdetailView(int no);
	
	// ���� ����, ����, ���� �̸�����
	public List<HashMap<String, Object>> loadBoard();
	public List<HashMap<String, Object>> loadNotice();
	public List<HashMap<String, Object>> loadJob();
}






