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

	// ����
	@ModelAttribute("sessionMember")
	public Map<String, Object> getSessionInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authNumOk", false);
		return map;
	}

	//////////// ���� ���� �Խ���
	@RequestMapping("selectBoard")
	public String selectBoard(Model model) {
		// ���� �Խ���
		model.addAttribute("boardLst", boardSrv.selectBoard());
		// ���� �Խ���
		model.addAttribute("jobLst", boardSrv.selectjobBoard());
		
		return "forward:/board_findForm";
	}

	// ���� �Խ��� ������ ����
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

	// ���� �Խ��� �۾���
	@RequestMapping("writeProc")
	public String writeProc(Model model, Board board,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		// ���� �޾Ƽ� �� ����

		if (sessionNickname.get("nickname") == null) { // ���� ���� ������ �α��� �ش޶�� ��û
			model.addAttribute("msg", "�α����� �� ��� ������ ���� �Դϴ�.");
			return "forward:/board_writeForm";
		} else if (board.getBoard_title().length() == 0) { // ���� �ʼ� �Է»��� ��û
			model.addAttribute("msg", "������ �Է��ϼ���.");
			return "forward:/board_writeForm";
		} else {
			boardSrv.insertProc(board);
			return "redirect:/board/selectBoard";
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
			boardSrv.boardupdateProc(board);
			return "redirect:/board/selectBoard";
		}
	}

	// ���� ����
	@RequestMapping("boardDeleteProc")
	public String boardDeleteProc(Model model, @RequestParam("deleteNo") int board_idx) {
		boardSrv.boarddeleteProc(board_idx);
		return "redirect:/board/selectBoard";
	}

	// ���� ���� �Խ���
	@RequestMapping("noticeBoard")
	public String noticeBoard(Model model,
			@RequestParam(value="curPage", defaultValue="1") String curPage,
			@RequestParam(value="selectOpt", defaultValue="all") String selectOpt,
			@RequestParam(value="searchWord", defaultValue="") String searchWord) throws Exception {
		
		model.addAttribute("noticeLst", 
				boardSrv.noticeselectBoard(curPage, selectOpt, searchWord));
		return "forward:/board_noticeForm";
	}

	// ���� ���� �Խ��� �� ��
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

	// ���� ���� �Խ��� �۾���
	@RequestMapping("noticeWriteProc")
	public String noticeWriteProc(Model model, Board_Notice noticeBoard,
			@ModelAttribute("sessionMember") Map<String, Object> sessionNickname) {
		if (noticeBoard.getNotice_title().length() == 0) {
			model.addAttribute("msg", "������ �Է��ϼ���");
			return "forward:/board_noticewriteForm";
		} else {
			boardSrv.noticewriteProc(noticeBoard);
			return "redirect:/board/noticeBoard";
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
			boardSrv.noticeupdateProc(noticeBoard);
			return "redirect:/board/noticeBoard";
		}
	}

	// ���� ���� �Խ��� �� ����
	@RequestMapping("noticeDeleteProc")
	public String noticeDeleteProc(Model model, @RequestParam("deleteNo") int notice_idx) {
		boardSrv.noticedeleteProc(notice_idx);
		return "redirect:/board/noticeBoard";
	}

	// ���� ����,����,���� �̸�����
	@RequestMapping("mainBoard")
	@ResponseBody
	public JSONObject mainBoard() {
		return boardSrv.loadBoard();
	}
	
	
	// ���� �Խ��ǿ��� �� �󼼺���
	@RequestMapping("jobdetailView")
	public String jobdetailView(Model model,
			@RequestParam("jobNo") String job_No) {
		model.addAttribute("job_list", boardSrv.jobdetailView(job_No));
		return "forward:/job_findViewForm";
	}

}
