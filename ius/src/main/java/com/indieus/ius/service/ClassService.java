package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.StaffVO;

public interface ClassService {

	public Object getClassList() throws Exception;

	public Object getClassByClassNum(Map<String, Object> map) throws Exception;

	public int selectClassLastNumber() throws Exception;

	public List<StaffVO> selectClassHomeTeacher() throws Exception;

	public int updateClass(ClassVO cVo) throws Exception;

	public Object getHomeTeacherList() throws Exception;

	public void updateClassInfo(Map<String, Object> map) throws Exception;

	public void deleteClassInfo(Map<String, Object> map) throws Exception;
}

