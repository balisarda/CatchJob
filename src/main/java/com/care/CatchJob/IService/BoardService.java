package com.care.CatchJob.IService;

import java.util.List;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;

public interface BoardService {
	// �˹� ��Ͽ� ���� ����
	public List<Board> selectBoard();
	public Board detailView(String board_idx);
	public void insertProc(Board board);
	public void boardupdateProc(Board board);
	public void boarddeleteProc(int board_idx);
	
	// �������� �Խ��ǿ� ���� ����	
	public List<Board_Notice> noticeselectBoard();
	public Board_Notice noticedetailView(String notice_idx);
	public void noticewriteProc(Board_Notice board_notice);
	public void noticeupdateProc(Board_Notice board_notice);
	public void noticedeleteProc(int notice_idx);
	// �ϵ�� �Խ��� ����
	public List<Job> selectjobBoard();
}






