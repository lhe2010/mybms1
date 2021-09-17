package com.mybms1.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mybms1.member.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO login(Map<String, String> loginMap) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;

}
