package com.mybms1.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mybms1.goods.vo.GoodsVO;
import com.mybms1.goods.vo.ImageFileVO;

@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl implements AdminGoodsDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GoodsVO> selectNewGoodsList() throws DataAccessException {
		return sqlSession.selectList("mapper.admin.goods.selectNewGoodsList");
	}

	@Override
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
		sqlSession.insert("mapper.admin.goods.insertNewGoods", newGoodsMap);
		return Integer.parseInt((String) newGoodsMap.get("goods_id"));
	}

	@Override
	public void insertGoodsImageFile(List<ImageFileVO> fileList) throws DataAccessException {
		for(int i = 0; i < fileList.size(); i++ ) {
			sqlSession.insert("mapper.admin.goods.insertGoodsImageFile", (ImageFileVO) fileList.get(i));
		}
	}

	@Override
	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException {
		return sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail", goods_id);
	}

	@Override
	public List<ImageFileVO> selectGoodsImageFileList(int goods_id) throws DataAccessException {
		return sqlSession.selectList("mapper.admin.goods.selectGoodsImageFileList", goods_id);
	}

	@Override
	public void updateGoodsInfo(Map<String, String> goodsMap) throws DataAccessException {
		sqlSession.update("mapper.admin.goods.updateGoodsInfo", goodsMap);
	}

	@Override
	public void updateGoodsImage(List<ImageFileVO> imageFileList) throws DataAccessException {
		for(int i = 0; i < imageFileList.size(); i++) {
			ImageFileVO imageFileVO = imageFileList.get(i);
			sqlSession.update("mapper.admin.goods.updateGoodsImage", imageFileVO);
		}
	}

	@Override
	public void deleteGoodsImage(int image_id) throws DataAccessException {
		sqlSession.delete("mapper.admin.goods.deleteGoodsImage" , image_id);		
	}
}
