package com.mybms1.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mybms1.member.vo.MemberVO;

public interface MemberController {
	public ModelAndView login(@RequestParam Map<String, String> loginMap,HttpServletRequest request) throws Exception;
	public ModelAndView loginForm() throws Exception;
	public ModelAndView logout(HttpServletRequest request) throws Exception;

	public ModelAndView memberForm() throws Exception;
	public ResponseEntity<String> addMember(@ModelAttribute("member") MemberVO member,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity<String> overlapped(@RequestParam("id") String id) throws Exception;


}
