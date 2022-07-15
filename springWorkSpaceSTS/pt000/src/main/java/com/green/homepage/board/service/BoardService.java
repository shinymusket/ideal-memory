package com.green.homepage.board.service;

import com.green.homepage.board.db.BoardDTO;

public interface BoardService {
	
	public int board_write(BoardDTO board) throws Exception;
	
}
