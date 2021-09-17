package com.mybms1.admin.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mybms1.member.vo.MemberVO;

@Repository("adminMemberDAO")
public class AdminMemberDAOImpl implements AdminMemberDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberVO> listMember(Map<String, Object> condMap) throws DataAccessException {
		return sqlSession.selectList("mapper.admin.member.listMember");
	}

	@Override
	public MemberVO memberDetail(String member_id) throws DataAccessException {
		return sqlSession.selectOne("mapper.admin.member.memberDetail", member_id);
	}

	@Override
	public void modifyMemberInfo(Map<String, String> memberMap) throws DataAccessException {
		sqlSession.update("mapper.admin.member.modifyMemberInfo", memberMap);
	}
}
