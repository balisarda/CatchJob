package com.care.CatchJob.Controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.care.CatchJob.DTO.Board;
import com.care.CatchJob.DTO.Board_Notice;
import com.care.CatchJob.IService.BoardService;

@Controller
@RequestMapping("board")
@SessionAttributes("sessionMember")
public class BoardController {
	
	@Autowired
	private BoardService boardSrv;

	// 세션
	@ModelAttribute("sessionMember")
	public Map<String, Object> getSessionInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authNumOk", false);
		return map;
	}

	//////////// 구인 구직 게시판
	@RequestMapping("selectBoard")
	public String selectBoard(Model model) {
		// 구직 게시판
		model.addAttribute("boardLst", boardSrv.selectBoard());
		// 구인 게시판
		model.addAttribute("jobLst", boardSrv.selectjobBoard());
		
		return "forward:/board_findForm";
	}

	// 구직 게시판 상세정보 보기
	@RequestMapping("detailView")
	public String detailView(Model model, @RequestParam("boardNo") String board_idx,
			@RequestParam("updateNo") String updateNo, @ModelAttribute("sessionMember") Map<String, Object> Nickname) {
		model.addAttribute("Nickname", Nickname.get("Nickname"));
		model.addAttribute("detailView", boardSrv.detailView(board_idx));
		if (updateNo.equals("update")) {
			return "forward:/board_updateForm";
		}
		return "forward:/board_viewForm";
	}

	// 구직 게시판 글쓰기
	@RequestMapping("writeProc")
	public String writeProc(Model model, Board board,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		// 세션 받아서 값 저장

		if (sessionNickname.get("nickname") == null) { // 세션 값이 없으면 로그인 해달라고 요청
			model.addAttribute("msg", "로그인을 후 사용 가능한 서비스 입니다.");
			return "forward:/board_writeForm";
		} else if (board.getBoard_title().length() == 0) { // 제목 필수 입력사항 요청
			model.addAttribute("msg", "제목을 입력하세요.");
			return "forward:/board_writeForm";
		} else {
			boardSrv.insertProc(board);
			return "redirect:/board/selectBoard";
		}
	}

	// 구직 업데이트
	@RequestMapping("boardUpdateProc")
	public String boardUpdateProc(Model model, Board board,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		if (board.getBoard_title().length() == 0) {
			model.addAttribute("msg", "제목을 입력하세요");
			return "forward:/board_updateForm";
		} else {
			boardSrv.boardupdateProc(board);
			return "redirect:/board/selectBoard";
		}
	}

	// 구직 삭제
	@RequestMapping("boardDeleteProc")
	public String boardDeleteProc(Model model, @RequestParam("deleteNo") int board_idx) {
		boardSrv.boarddeleteProc(board_idx);
		return "redirect:/board/selectBoard";
	}

	// 공지 사항 게시판
	@RequestMapping("noticeBoard")
	public String noticeBoard(Model model,
			@RequestParam(value="curPage", defaultValue="1") String curPage,
			@RequestParam(value="selectOpt", defaultValue="all") String selectOpt,
			@RequestParam(value="searchWord", defaultValue="") String searchWord) throws Exception {
		
		model.addAttribute("noticeLst", 
				boardSrv.noticeselectBoard(curPage, selectOpt, searchWord));
		return "forward:/board_noticeForm";
	}

	// 공지 사항 게시판 뷰 폼
	@RequestMapping("noticeDetailView")
	public String noticeDetailView(Model model, @RequestParam("noticeNo") String notice_idx,
			@RequestParam("updateNo") String updateNo, @ModelAttribute("sessionMember") Map<String, Object> Nickname) {
		model.addAttribute("Nickname", Nickname.get("Nickname"));
		model.addAttribute("noticedetail", boardSrv.noticedetailView(notice_idx));
		if (updateNo.equals("update")) {
			return "forward:/board_noticeupdateForm";
		}
		return "forward:/board_noticeviewForm";
	}

	// 공지 사항 게시판 글쓰기
	@RequestMapping("noticeWriteProc")
	public String noticeWriteProc(Model model, Board_Notice noticeBoard,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		if (noticeBoard.getNotice_title().length() == 0) {
			model.addAttribute("msg", "제목을 입력하세요");
			return "forward:/board_noticewriteForm";
		} else {
			boardSrv.noticewriteProc(noticeBoard);
			return "redirect:/board/noticeBoard";
		}
	}

	// 공지 사항 게시판 글 수정
	@RequestMapping("noticeUpdateProc")
	public String noticeUpdateProc(Model model, Board_Notice noticeBoard,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {

		if (noticeBoard.getNotice_title().length() == 0) {
			model.addAttribute("msg", "제목을 입력하세요");
			return "forward:/board_noticeupdateForm";
		} else {
			boardSrv.noticeupdateProc(noticeBoard);
			return "redirect:/board/noticeBoard";
		}
	}

	// 공지 사항 게시판 글 삭제
	@RequestMapping("noticeDeleteProc")
	public String noticeDeleteProc(Model model, @RequestParam("deleteNo") int notice_idx) {
		boardSrv.noticedeleteProc(notice_idx);
		return "redirect:/board/noticeBoard";
	}

	// 메인 공지,구인,구직 미리보기
	@RequestMapping("mainBoard")
	@ResponseBody
	public JSONObject mainBoard() {
		return boardSrv.loadBoard();
	}
	
	
	// 구인 게시판에서 글 상세보기
	@RequestMapping("jobdetailView")
	public String jobdetailView(Model model,
			@RequestParam("jobNo") String job_No) {
		model.addAttribute("job_list", boardSrv.jobdetailView(job_No));
		return "forward:/job_findViewForm";
	}

}
