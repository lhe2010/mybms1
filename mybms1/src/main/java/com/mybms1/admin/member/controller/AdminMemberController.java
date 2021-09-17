package com.mybms1.admin.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface AdminMemberController {
	public ModelAndView adminMemberMain(@RequestParam Map<String, String> dateMap, HttpServletRequest request) throws Exception;
	public ModelAndView memberDetail(@RequestParam("member_id") String member_id) throws Exception;
	public void modifyMemberInfo(@RequestParam("member_id") String member_id,
								 @RequestParam("mod_type") String mod_type,
								 @RequestParam("value") String value,
								 HttpServletResponse response) throws Exception;
//	public ModelAndView deleteMember(@RequestParam("del_yn") String del_yn, @RequestParam("member_id") String member_id) throws Exception;
	public ResponseEntity<String> deleteMember(@RequestParam("del_yn") String del_yn, @RequestParam("member_id") String member_id) throws Exception;
}
