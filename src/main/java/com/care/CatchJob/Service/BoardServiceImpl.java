package com.care.CatchJob.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.DTO.Job;
import com.care.CatchJob.IDAO.BoardDao;
import com.care.CatchJob.IService.BoardService;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;
	// 알바등록 게시판
	@Override	// 게시판 불러오기
	public List<Board> selectBoard() {
		Map<String, Object> map = new HashMap<String, Object>();
		return boardDao.selectBoard(map);
	}

	@Override	// 상세정보 불러오기
	public Board detailView(String board_idx) {
		return boardDao.detailView(Integer.parseInt(board_idx));
	}

	@Override	// 정보 인서트
	public void insertProc(Board board) {
		boardDao.insertProc(board);
	}

	@Override	// 업데이트 확인
	public void boardupdateProc(Board board) {	
		boardDao.boardupdateProc(board);
	}
	
	@Override	// 삭제
	public void boarddeleteProc(int board_idx) {
		boardDao.boarddeleteProc(board_idx);
	}
	
	// 공지 사항 게시판/////////////////////
	@Override
	public List<Board_Notice> noticeselectBoard() {
		Map<String, Object> map = new HashMap<String, Object>();
		return boardDao.noticeselectBoard(map);
	}

	@Override
	public Board_Notice noticedetailView(String notice_idx) {
		return boardDao.noticedetailView(Integer.parseInt(notice_idx));
	}

	@Override
	public void noticewriteProc(Board_Notice board_notice) {
		boardDao.noticewriteProc(board_notice);
	}
	
	@Override
	public void noticeupdateProc(Board_Notice board_notice){
		boardDao.noticeupdateProc(board_notice);
	}
	
	@Override
	public void noticedeleteProc(int notice_idx) {
		boardDao.noticedeleteProc(notice_idx);
	}
		
	// 일 등록 게시판 서비스
	@Override
	public List<Job> selectjobBoard() {
		Map<String, Object> map = new HashMap<String, Object>();
		return boardDao.selectjobBoard(map);
	}
}
