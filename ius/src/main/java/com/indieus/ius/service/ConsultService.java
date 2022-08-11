package com.indieus.ius.service;

import java.util.Map;

public interface ConsultService {

	public Object getConsultByKinderNum(Map<String, Object> map) throws Exception;

	public Object selectConsultByDate(Map<String, Object> map) throws Exception;

	public Object selectParentNumName(Map<String, Object> map) throws Exception;

	public Object getConsultByConsultCode(Map<String, Object> map) throws Exception;

	public void registerConsult(Map<String, Object> map) throws Exception;

	public void updateConsult(Map<String, Object> map) throws Exception;

	public void deleteConsult(Map<String, Object> map) throws Exception;

}
