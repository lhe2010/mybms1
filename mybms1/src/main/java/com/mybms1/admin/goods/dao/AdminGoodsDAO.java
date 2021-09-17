package com.mybms1.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mybms1.goods.vo.GoodsVO;
import com.mybms1.goods.vo.ImageFileVO;


public interface AdminGoodsDAO {
	public List<GoodsVO>selectNewGoodsList() throws DataAccessException;

	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	public void insertGoodsImageFile(List<ImageFileVO> fileList)  throws DataAccessException;

	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsImageFileList(int goods_id) throws DataAccessException;
	
	public void updateGoodsInfo(Map<String,String> goodsMap) throws DataAccessException;
	public void updateGoodsImage(List<ImageFileVO> imageFileList) throws DataAccessException;

	public void deleteGoodsImage(int image_id) throws DataAccessException;
}
