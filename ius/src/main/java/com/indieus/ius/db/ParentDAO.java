package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.ParentVO;

@Repository
public class ParentDAO {

	@Autowired
	private SqlSession sqlsession;

	// 원생 명단(학부모 성명 포함된) 리스트 가져오기
	public List<KinderVO> selectKinderListIncludeParentName() throws Exception {
		return sqlsession.selectList("parent.select_kinder_list_include_parent_name");
	}

	// 전체 학급 리스트 가져오기
	public List<ClassVO> selectAllClassNumName() throws Exception {
		return sqlsession.selectList("parent.select_all_class_num_name");
	}

	// 원생별 부모 정보 받아오기
	public KinderVO selectKinderParents(String kinder_num) throws Exception {
		return sqlsession.selectOne("parent.select_kinder_parents", kinder_num);
	}

	// 원생 명단 검색
	public List<KinderVO> selectKinderByName(String kinder_name) throws Exception {
		return sqlsession.selectList("parent.select_kinder_by_name", kinder_name);
	}

	// 원생의 부모 데이터가 이미 있는지 조사
	public int selectKinderGetParent(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("parent.select_kinder_get_parent", map);
	}

	// 학부모 정보 등록
	@Transactional
	public int insertParent(ParentVO pVo) throws Exception {
		return sqlsession.insert("parent.insert_parent", pVo);
	}

	// 원생 번호로 간략한 원생 정보 가져오기
	public KinderVO selectKinderInfoByKinderNum(String kinder_num) throws Exception {
		return sqlsession.selectOne("parent.select_kinder_info_by_kinder_num", kinder_num);
	}

	// 학부모 정보 삭제
	@Transactional
	public void deleteParentInfo(Map<String, Object> map) throws Exception {
		sqlsession.delete("parent.delete_parent_info", map);
	}

	// 학부모 정보 수정
	@Transactional
	public void updateParentInfo(Map<String, Object> map) throws Exception {
		sqlsession.update("parent.update_parent_info", map);

	}


}
