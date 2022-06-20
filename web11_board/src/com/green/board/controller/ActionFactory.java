package com.green.board.controller;

import com.green.board.controller.action.Action;
import com.green.board.controller.action.BoardListAction;

public class ActionFactory { // 요청을 기능으로 연결시켜줄 클래스
	private ActionFactory() {}
	private static ActionFactory af = new ActionFactory();
	public static ActionFactory getInstance() {
		return af;
	}
	
	// 전달받은 기능을 수행할 클래스를 연결시켜주는 메서드
	
	public Action getAction(String command) {
		Action action = null;
		
		if(command.equals("")) {
			action = new BoardListAction();
		} else if (command.equals("")) {
			
		} else if (command.equals("")) {
			
		}
		
		return action;
		
	}
}
