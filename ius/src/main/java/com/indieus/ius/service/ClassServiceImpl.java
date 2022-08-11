package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.ClassDAO;
import com.indieus.ius.db.StaffDAO;
import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.StaffVO;

public class ClassServiceImpl implements ClassService {

	@Inject
	private ClassDAO manager;

	@Inject
	private StaffDAO staffManager;


	// 전체 학급 리스트 가져오기 Ajax
	@Override
	public Object getClassList() throws Exception {
		List<ClassVO> classList = manager.selectAllClassList();
		Map<String, Object> data = new HashMap();
		data.put("classList", classList);
		return data;
	}

	// 학급 정보 가져오기 Ajax
	@Override
	public Object getClassByClassNum(Map<String, Object> map) throws Exception {
		String class_number = (String) map.get("class_number");
		ClassVO classInfo = manager.selectClassByClassNum(class_number);
		List<KinderVO> classKinderList = manager.selectClassKinderByClassNum(class_number);

		Map<String, Object> data = new HashMap();
		data.put("classInfo", classInfo);
		data.put("classKinderList", classKinderList);
		return data;
	}

	// 학급 등록을 위한 마지막 학급 번호 가져오기
	@Override
	public int selectClassLastNumber() throws Exception {
		return manager.selectClassLastNumber();
	}

	// 학급 등록을 위한 담당 교사 리스트 가져오기
	@Override
	public List<StaffVO> selectClassHomeTeacher() throws Exception {
		return manager.selectClassHomeTeacher();
	}

	// 학급 등록
	@Override
	public int updateClass(ClassVO cVo) throws Exception {
		return manager.updateClass(cVo);
	}

	// 학급 정보 수정을 위한 담임교사 명단 가져오기 Ajax
	@Override
	public Object getHomeTeacherList() throws Exception {
		List<StaffVO> homeTeacherList = selectClassHomeTeacher();
		Map<String, Object> data = new HashMap();
		data.put("homeTeacherList", homeTeacherList);
		return data;
	}

	// 학급 정보 수정 Ajax
	@Override
	public void updateClassInfo(Map<String, Object> map) throws Exception {
		String old_staff_num = (String) map.get("old_staff_num");
		String new_staff_num = (String) map.get("new_staff_num");
		String class_number = (String) map.get("class_number");

		manager.updateClassInfo(map);
		manager.deleteNullClassByStaffNum(new_staff_num);

		int check = manager.selectClassCntByStaffNum(old_staff_num);

		if (check == 0) { // 기본 데이터가 하나도 없다면 형식상 데이터 추가
			staffManager.insertStaffClassInfo(old_staff_num);
		}

		// 학생 담당교사 데이터 수정
		// 학생 명단
		List<KinderVO> classKinder = manager.selectClassKinderByClassNum(class_number);
		if(classKinder.size() != 0) {
			for (KinderVO element : classKinder) {
				element.setStaff_num(new_staff_num);
				manager.updateHomeTeacherForKinder(element);
			}
		}



	}

	// 학급 정보 삭제 Ajax (삭제시 학급 번호(시퀀스X)와 학급 이름만 삭제)
	@Override
	public void deleteClassInfo(Map<String, Object> map) throws Exception {
		manager.deleteClassInfo(map);

	}

}
