package com.indieus.ius.db;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.indieus.ius.vo.EworksBoardVO;

@Repository
public class EworksListDAO {

	@Autowired
	private SqlSession sqlsession;

	// 전체 전자결재 리스트 가져오기
	public List<EworksBoardVO> selectAllEworkList() throws Exception {
		return sqlsession.selectList("board.select_all_eWork_list");
	}

}
