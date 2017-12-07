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
	
	private final int BLOCKSIZE = 3;
			
	@Autowired
	private BoardDao boardDao;
	
	///////////// 알바등록 게시판
	@Override	// 게시판 불러오기
	public List<Board> boardSelectProc(
			String curPage, String searchOpt, String boardsearchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int pageNum=0;
		if(curPage!=null)
			pageNum = Integer.parseInt(curPage)-1;
		map.put("start", pageNum * BLOCKSIZE);
		map.put("end", (pageNum+1) * BLOCKSIZE);
		map.put("searchOpt", searchOpt);
		map.put("boardsearchWord", boardsearchWord);
		
		return boardDao.boardSelectProc(map);
	}

	@Override	// 상세정보 불러오기
	public Board boardDetailProc(String board_idx) {
		return boardDao.boardDetailProc(Integer.parseInt(board_idx));
	}

	@Override	// 정보 인서트
	public void boardInsertProc(Board board) {
		boardDao.boardInsertProc(board);
	}

	@Override	// 업데이트 확인
	public void boardUpdateProc(Board board) {	
		boardDao.boardUpdateProc(board);
	}
	
	@Override	// 삭제
	public void boardDeleteProc(int board_idx) {
		boardDao.boardDeleteProc(board_idx);
	}
	
	////////// 공지 사항 게시판
	@Override
	public List<Board_Notice> noticeSelectProc(
			String curPage, String searchOpt, String noticesearchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int pageNum=0;
		if(curPage!=null)
			pageNum = Integer.parseInt(curPage)-1;
		map.put("start", pageNum * BLOCKSIZE);
		map.put("end", (pageNum+1) * BLOCKSIZE);
		map.put("searchOpt", searchOpt);
		map.put("noticesearchWord", noticesearchWord);
		
		return boardDao.noticeSelectProc(map);
	}

	@Override
	public Board_Notice noticeDetailProc(String notice_idx) {
		return boardDao.noticeDetailProc(Integer.parseInt(notice_idx));
	}

	@Override
	public void noticeInsertProc(Board_Notice board_notice) {
		boardDao.noticeInsertProc(board_notice);
	}
	
	@Override
	public void noticeUpdateProc(Board_Notice board_notice){
		boardDao.noticeUpdateProc(board_notice);
	}
	
	@Override
	public void noticeDeleteProc(int notice_idx) {
		boardDao.noticeDeleteProc(notice_idx);
	}
		
	//////// 구인 게시판
	@Override
	public List<Job> jobSelectProc(
			String curPage, String searchOpt, String jobsearchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int pageNum=0;
		if(curPage!=null)
			pageNum = Integer.parseInt(curPage)-1;
		map.put("start", pageNum * BLOCKSIZE);
		map.put("end", (pageNum+1) * BLOCKSIZE);
		map.put("searchOpt", searchOpt);
		map.put("jobsearchWord", jobsearchWord);
		
		return boardDao.jobSelectProc(map);
	}
	// 구인 게시판 상세보기
	@Override
	public Job jobDetailProc(String Job_no) {
		return boardDao.jobDetailProc(Integer.parseInt(Job_no));
	}
	
//////// 메인화면 구인,구직,공지 미리보기
	@Override
	public JSONObject loadBoard() {
		JSONObject result = new JSONObject();
		JSONArray noticeArray = new JSONArray();
		JSONArray boardArray = new JSONArray();
		JSONArray jobArray = new JSONArray();

		List<HashMap<String, Object>> notice = boardDao.loadNotice();
		List<HashMap<String, Object>> board = boardDao.loadBoard();
		List<HashMap<String, Object>> job = boardDao.loadJob();
					
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
		
		for(int i = 0; i<job.size();i++) {
			HashMap<Integer, Object> str = new HashMap<Integer, Object>();
			HashMap<String, Object> b = new HashMap<String, Object>();

			JSONObject jobObj = new JSONObject();
			str.put(i, job.get(i));

			b = (HashMap<String, Object>) str.get(i);

			jobObj.put("num", b.get("NO"));
			jobObj.put("title", b.get("JOB_NAME"));
			jobObj.put("nickname", b.get("MEMBER_NICKNAME"));
			
			jobArray.add(jobObj);
			
		}
		result.put("joblist", jobArray);
		
		return result;
	}


}



















