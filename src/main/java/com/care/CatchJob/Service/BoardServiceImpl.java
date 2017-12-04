package com.care.CatchJob.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

	@Override
	public JSONObject loadBoard() {
		JSONObject result = new JSONObject();
		JSONArray noticeArray = new JSONArray();
		JSONArray boardArray = new JSONArray();

		List<HashMap<String, Object>> notice = boardDao.loadNotice();
		List<HashMap<String, Object>> board = boardDao.loadBoard();
					
		for(int i = 0; i<notice.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> a = new HashMap<String, Object>();

			JSONObject noticeObj = new JSONObject();
			str.put(i, notice.get(i));

			a = (HashMap<String, Object>) str.get(i);

			noticeObj.put("num", a.get("NOTICE_IDX"));
			noticeObj.put("title", a.get("NOTICE_TITLE"));
			noticeObj.put("nickname", a.get("MEMBER_NICKNAME"));
			
			noticeArray.add(noticeObj);
			
		}
		result.put("noticelist", noticeArray);

		for(int i = 0; i<board.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> b = new HashMap<String, Object>();

			JSONObject boardObj = new JSONObject();
			str.put(i, board.get(i));

			b = (HashMap<String, Object>) str.get(i);

			boardObj.put("num", b.get("BOARD_IDX"));
			boardObj.put("title", b.get("BOARD_TITLE"));
			boardObj.put("nickname", b.get("MEMBER_NICKNAME"));
			
			boardArray.add(boardObj);
			
		}
		result.put("boardlist", boardArray);
		
		return result;
	}
}



















