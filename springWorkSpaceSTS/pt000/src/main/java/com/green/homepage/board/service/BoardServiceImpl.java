package com.green.homepage.board.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.green.homepage.board.db.BoardDAO;
import com.green.homepage.board.db.BoardDTO;

public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO manager;
	
	// 게시판 글 작성
	@Override
	public int board_write(BoardDTO board) throws Exception {
		return manager.board_write(board);
	}

}
