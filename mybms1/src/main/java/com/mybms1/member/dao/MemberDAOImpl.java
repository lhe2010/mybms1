package com.mybms1.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mybms1.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberVO login(Map<String, String> loginMap) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.login", loginMap);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.selectOverlappedID",id);
	}

	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException {
		sqlSession.insert("mapper.member.insertNewMember", memberVO);
	}

}
