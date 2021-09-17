package com.mybms1.admin.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybms1.admin.member.dao.AdminMemberDAO;
import com.mybms1.member.vo.MemberVO;

@Service("adminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService {
	
	@Autowired
	private AdminMemberDAO adminMemberDAO;

	@Override
	public List<MemberVO> listMember(Map<String, Object> condMap) throws Exception {
		return adminMemberDAO.listMember(condMap);
	}

	@Override
	public MemberVO memberDetail(String member_id) throws Exception {
		return adminMemberDAO.memberDetail(member_id);
	}

	@Override
	public void modifyMemberInfo(Map<String, String> memberMap) throws Exception {
		adminMemberDAO.modifyMemberInfo(memberMap);
	}
}
