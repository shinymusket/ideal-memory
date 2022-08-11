package com.indieus.ius.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.ReceiptServiceImpl;

@Controller
@RequestMapping("/receipt")
public class ReceiptController {

	@Autowired
	private ReceiptServiceImpl service;


	// 수납 관리 리스트로 이동
	@RequestMapping(value = "/receipt_list", method = RequestMethod.GET)
	public String list() throws Exception {
		return "receipt/receiptList";
	}

	// 원생별 수납 관리 내역 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_receipt_by_kinder_num", method = RequestMethod.POST)
	public Object getReceiptByKinderNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getReceiptByKinderNum(map);
	}

	// 원생 수납 관리 내역 날짜별 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "/select_receipt", method = RequestMethod.POST)
	public Object selectReceipt(@RequestParam Map<String, Object> map) throws Exception {
		return service.selectReceipt(map);
	}

	// 수납 내역 등록 Ajax
	@ResponseBody
	@RequestMapping(value = "/register_receipt", method = RequestMethod.POST)
	public void registerReceipt(@RequestParam Map<String, Object> map) throws Exception {
		service.registerReceipt(map);
	}

	// 수정 혹은 삭제를 위해 데이터값 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_receipt_by_receipt_code", method = RequestMethod.POST)
	public Object getReceiptByReceiptCode(@RequestParam Map<String, Object> map) throws Exception {
		return service.getReceiptByReceiptCode(map);
	}


	// 수납 내역 수정 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_receipt", method = RequestMethod.POST)
	public void updateReceipt(@RequestParam Map<String, Object> map) throws Exception {
		service.updateReceipt(map);
	}

	// 수납 내역 삭제 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_receipt", method = RequestMethod.POST)
	public void deleteReceipt(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteReceipt(map);
	}

}
