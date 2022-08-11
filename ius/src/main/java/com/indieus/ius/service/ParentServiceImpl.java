package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.ClassDAO;
import com.indieus.ius.db.KinderDAO;
import com.indieus.ius.db.ParentDAO;
import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.ParentVO;

public class ParentServiceImpl implements ParentService {

	@Inject
	private ParentDAO manager;

	@Inject
	private KinderDAO kinderManager;

	@Inject
	private ClassDAO classManager;


	// 원생 명단(학부모 성명 포함된) 리스트 가져오기 Ajax
	@Override
	public Object getKinderList() throws Exception {
		List<KinderVO> kinderList = manager.selectKinderListIncludeParentName();

//		if(kinderList.size() != 0) {
//			for (KinderVO element : kinderList) {
//				String kinder_num = element.getKinder_num();
//
//				KinderVO kVo = new KinderVO();
//				String father_name;
//				String mather_name;
//
//				Map<String, Object> info = new HashMap();
//				info.put("kinder_num", kinder_num);
//				info.put("relation", "부");
//				father_name = kinderManager.selectParentNameByKinderNum(info);
//				info.put("relation", "모");
//				mather_name = kinderManager.selectParentNameByKinderNum(info);
//
//				if (father_name == null) {
//					father_name = "";
//				}
//
//				if (mather_name == null) {
//					mather_name = "";
//				}
//
//
//				element.setFather_name(father_name);
//				element.setMather_name(mather_name);
//
//			}
//		}



		Map<String, Object> data = new HashMap();
		data.put("kinderList", kinderList);
		return data;
	}

	// 학급 별 원생 명단 리스트 가져오기 Ajax
	@Override
	public Object searchKinderListByClass(Map<String, Object> map) throws Exception {
		String class_number = (String) map.get("class_number");

		List<KinderVO> kinderList = classManager.selectClassKinderByClassNum(class_number);

		if(kinderList.size() != 0) {
			for (KinderVO element : kinderList) {
				String kinder_num = element.getKinder_num();

				KinderVO kVo = new KinderVO();
				String father_name;
				String mather_name;

				Map<String, Object> info = new HashMap();
				info.put("kinder_num", kinder_num);
				info.put("relation", "부");
				father_name = kinderManager.selectParentNameByKinderNum(info);
				info.put("relation", "모");
				mather_name = kinderManager.selectParentNameByKinderNum(info);

				if (father_name == null) {
					father_name = "";
				}

				if (mather_name == null) {
					mather_name = "";
				}


				element.setFather_name(father_name);
				element.setMather_name(mather_name);

			}
		}
		Map<String, Object> data = new HashMap();
		data.put("kinderList", kinderList);
		return data;
	}





	@Override
	// 전체 학급 리스트 가져오기
	public List<ClassVO> selectAllClassNumName() throws Exception {
		return manager.selectAllClassNumName();
	}

	// 원생 검색 Ajax
	@Override
	public Object searchKinder(Map<String, Object> map) throws Exception {
		String kinder_name = (String) map.get("kinder_name");
		List<KinderVO> kinderList = manager.selectKinderByName(kinder_name);

		Map<String, Object> data = new HashMap();
		data.put("kinderList", kinderList);
		return data;

	}

	// 원생 정보 입력시 부모님 데이터가 이미 있는지 조사 Ajax
	@Override
	public Object checkKinderParent(Map<String, Object> map) throws Exception {
		int count = manager.selectKinderGetParent(map);

		Map<String, Object> result = new HashMap();
		result.put("count", count);
		return result;
	}

	// 학부모 정보 등록
	@Override
	public int insertParent(ParentVO pVo) throws Exception {
		return manager.insertParent(pVo);
	}

	// 원생 별 학부모 정보 조회 Ajax
	@Override
	public Object getKinderParentInfo(Map<String, Object> map) throws Exception {
		String kinder_num = (String) map.get("kinder_num");
		KinderVO kinderInfo = manager.selectKinderInfoByKinderNum(kinder_num);

		Map<String, Object> info = new HashMap();
		info.put("kinder_num", kinder_num);
		info.put("relation", "부");

		ParentVO fatherInfo = kinderManager.selectParentInfoByKinderNum(info);

		info.put("relation", "모");
		ParentVO matherInfo = kinderManager.selectParentInfoByKinderNum(info);


		Map<String, Object> data = new HashMap();
		data.put("kinderInfo", kinderInfo);
		data.put("fatherInfo", fatherInfo);
		data.put("matherInfo", matherInfo);

		return data;
	}

	// 학부모 정보 삭제 Ajax
	@Override
	public void deleteParentInfo(Map<String, Object> map) throws Exception {
		manager.deleteParentInfo(map);
	}

	// 학부모 정보 수정 Ajax
	@Override
	public void updateParentInfo(Map<String, Object> map) throws Exception {
		manager.updateParentInfo(map);
	}







}
