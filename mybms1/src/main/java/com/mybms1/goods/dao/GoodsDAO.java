package com.mybms1.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mybms1.goods.vo.GoodsVO;
import com.mybms1.goods.vo.ImageFileVO;

public interface GoodsDAO {
	
	public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
}
