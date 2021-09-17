package com.mybms1.admin.member.service;

import java.util.List;
import java.util.Map;

import com.mybms1.member.vo.MemberVO;

public interface AdminMemberService {

	public List<MemberVO> listMember(Map<String, Object> condMap) throws Exception;
	public MemberVO memberDetail(String member_id) throws Exception;
	public void modifyMemberInfo(Map<String,String> memberMap) throws Exception;
}
