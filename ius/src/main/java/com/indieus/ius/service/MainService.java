package com.indieus.ius.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.indieus.ius.vo.AuthorityVO;
import com.indieus.ius.vo.StaffVO;

public interface MainService {

	public Object getEmailExistCheck(Map<String, Object> map) throws Exception;

	public Object searchPasswordByEmail(Map<String, Object> map) throws Exception;

	public AuthorityVO selectAuthByCode(String auth_code) throws Exception;

	public Object getAuthInfoByCode(Map<String, Object> map) throws Exception;

	public int myStaffInfoUpdate(StaffVO sVo, MultipartFile staff_picFile) throws Exception;

	public Object checkOriginPassword(Map<String, Object> map) throws Exception;

	public int updatePassword(Map<String, Object> map) throws Exception;

	public Object getInfo(Map<String, Object> map) throws Exception;
}
