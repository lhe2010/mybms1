package com.mybms1.member.service;

import java.util.Map;

import com.mybms1.member.vo.MemberVO;

public interface MemberService {
	
	public MemberVO login(Map<String, String> loginMap) throws Exception;
	public String overlapped(String id) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;

}
