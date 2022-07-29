package com.indieus.ius.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.indieus.ius.vo.JobClassifiVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

public interface StaffService {

	public List<StaffVO> selectStaffList() throws Exception;

	public int selectStaffSeq() throws Exception;

	public List<JobClassifiVO> selectJobClassifi() throws Exception;

	public JobClassifiVO selectJobClassifiByNum(String staff_cls) throws Exception;

	public void getJobList(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public void insertJobList(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public JobClassifiVO getJobByStaffCls(String staff_cls) throws Exception;

	public void deleteJobByStaffCls(String staff_cls, HttpServletResponse response) throws Exception;

	public void updateJobList(JobClassifiVO jVo) throws Exception;

	public int idCheck(String staff_id) throws Exception;

	public int insertStaff(StaffVO sVo) throws Exception;

	public void sendMail(StaffVO sVo, StaffIdVO sIvo) throws Exception;

	public StaffIdVO createTempPwd(StaffVO sVo) throws Exception;

	public StaffVO selectStaffInfo(String staff_num) throws Exception;

	public int deleteStaff(String staff_num) throws Exception;

	public int updateStaff(StaffVO sVo) throws Exception;

}
