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
import com.care.CatchJob.IDAO.BoardDao;
import com.care.CatchJob.IService.BoardService;

@Controller
@RequestMapping("board")
@SessionAttributes("sessionMember")
public class BoardController {
	
	@Autowired
	private BoardService boardSrv;	
	@Autowired
	private BoardDao boardDao;

	// ����
	@ModelAttribute("sessionMember")
	public Map<String, Object> getSessionInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authNumOk", false);
		return map;
	}

	//////////// ���� ���� �Խ���
	@RequestMapping("boardSelectProc")
	public String boardSelectProc(Model model,
			@RequestParam(value="curPage", defaultValue="1") String curPage,
			@RequestParam(value="selectOpt", defaultValue="all") String selectOpt,
			@RequestParam(value="boardsearchWord", defaultValue="") String boardsearchWord,
			@RequestParam(value="jobsearchWord", defaultValue="") String jobsearchWord) throws Exception {
		// ���� �Խ���
		model.addAttribute("boardLst", 
				boardSrv.boardSelectProc(curPage, selectOpt, boardsearchWord));
		// ���� �Խ���
		model.addAttribute("jobLst", 
				boardSrv.jobSelectProc(curPage, selectOpt, jobsearchWord));
		
		return "forward:/board_findForm";
	}

	// ���� �Խ��� ������ ����
	@RequestMapping("boardDetailProc")
	public String boardDetailProc(Model model, 
			@RequestParam("boardNo") String board_idx,
			@RequestParam("updateGo") String updateGo,
			@ModelAttribute("sessionMember") Map<String, Object> Nickname) {
		boardDao.boardHitsProc(Integer.parseInt(board_idx));
		model.addAttribute("Nickname", Nickname.get("Nickname"));
		model.addAttribute("boardLst", boardSrv.boardDetailProc(board_idx));
		if (updateGo.equals("update")) {
			return "forward:/board_updateForm";
		}
		return "forward:/board_viewForm";
	}

	// ���� �Խ��� �۾���
	@RequestMapping("boardInsertProc")
	public String boardInsertProc(Model model, Board board,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		// ���� �޾Ƽ� �� ����

		if (sessionNickname.get("nickname") == null) { // ���� ���� ������ �α��� �ش޶�� ��û
			model.addAttribute("msg", "�α����� �� ��� ������ ���� �Դϴ�.");
			return "forward:/board_writeForm";
		} else if (board.getBoard_title().length() == 0) { // ���� �ʼ� �Է»��� ��û
			model.addAttribute("msg", "������ �Է��ϼ���.");
			return "forward:/board_writeForm";
		} else {
			boardSrv.boardInsertProc(board);
			return "redirect:/board/boardSelectProc";
		}
	}

	// ���� ������Ʈ
	@RequestMapping("boardUpdateProc")
	public String boardUpdateProc(Model model, Board board,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		if (board.getBoard_title().length() == 0) {
			model.addAttribute("msg", "������ �Է��ϼ���");
			return "forward:/board_updateForm";
		} else {
			boardSrv.boardUpdateProc(board);
			return "redirect:/board/boardSelectProc";
		}
	}

	// ���� ����
	@RequestMapping("boardDeleteProc")
	public String boardDeleteProc(Model model, 
			@RequestParam("deleteNo") int board_idx) {
		boardSrv.boardDeleteProc(board_idx);
		return "redirect:/board/boardSelectProc";
	}

	// ���� ���� �Խ���
	@RequestMapping("noticeSelectProc")
	public String noticeSelectProc(Model model,
			@RequestParam(value="curPage", defaultValue="1") String curPage,
			@RequestParam(value="selectOpt", defaultValue="all") String selectOpt,
			@RequestParam(value="noticesearchWord", defaultValue="") String noticesearchWord) throws Exception {

		model.addAttribute("noticeLst",
				boardSrv.noticeSelectProc(curPage, selectOpt, noticesearchWord));
		return "forward:/board_noticeForm";
	}

	// ���� ���� �Խ��� �� ��
	@RequestMapping("noticeDetailProc")
	public String noticeDetailProc(Model model, 
			@RequestParam("noticeNo") String notice_idx,
			@RequestParam("updateGo") String updateGo,
			@ModelAttribute("sessionMember") Map<String, Object> Nickname) {
		boardDao.noticeHitsProc(Integer.parseInt(notice_idx));
		model.addAttribute("Nickname", Nickname.get("Nickname"));
		model.addAttribute("noticeLst", boardSrv.noticeDetailProc(notice_idx));
		if (updateGo.equals("noticeUp")) {
			return "forward:/board_noticeupdateForm";
		}
		return "forward:/board_noticeviewForm";
	}

	// ���� ���� �Խ��� �۾���
	@RequestMapping("noticeInsertProc")
	public String noticeInsertProc(Model model, Board_Notice noticeBoard,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		if (noticeBoard.getNotice_title().length() == 0) {
			model.addAttribute("msg", "������ �Է��ϼ���");
			return "forward:/board_noticewriteForm";
		} else {
			boardSrv.noticeInsertProc(noticeBoard);
			return "redirect:/board/noticeSelectProc";
		}
	}

	// ���� ���� �Խ��� �� ����
	@RequestMapping("noticeUpdateProc")
	public String noticeUpdateProc(Model model, Board_Notice noticeBoard,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {

		if (noticeBoard.getNotice_title().length() == 0) {
			model.addAttribute("msg", "������ �Է��ϼ���");
			return "forward:/board_noticeupdateForm";
		} else {
			boardSrv.noticeUpdateProc(noticeBoard);
			return "redirect:/board/noticeSelectProc";
		}
	}

	// ���� ���� �Խ��� �� ����
	@RequestMapping("noticeDeleteProc")
	public String noticeDeleteProc(Model model, @RequestParam("deleteNo") int notice_idx) {
		boardSrv.noticeDeleteProc(notice_idx);
		return "redirect:/board/noticeSelectProc";
	}

	// ���� ����,����,���� �̸�����
	@RequestMapping("mainBoard")
	@ResponseBody
	public JSONObject mainBoard() {
		return boardSrv.loadBoard();
	}
	
	
	// ���� �Խ��ǿ��� �� �󼼺���
	@RequestMapping("jobDetailProc")
	public String jobDetailProc(Model model,
			@RequestParam("jobNo") String no) {
		boardDao.jobHitsProc(Integer.parseInt(no));
		model.addAttribute("jobLst", boardSrv.jobDetailProc(no));
		return "forward:/job_findViewForm";
	}

}
