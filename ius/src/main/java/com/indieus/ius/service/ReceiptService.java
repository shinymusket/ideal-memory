package com.indieus.ius.service;

import java.util.Map;

public interface ReceiptService {

	public Object getReceiptByKinderNum(Map<String, Object> map) throws Exception;

	public Object selectReceipt(Map<String, Object> map) throws Exception;

	public void registerReceipt(Map<String, Object> map) throws Exception;

	public Object getReceiptByReceiptCode(Map<String, Object> map) throws Exception;

	public void updateReceipt(Map<String, Object> map) throws Exception;

	public void deleteReceipt(Map<String, Object> map) throws Exception;
}
