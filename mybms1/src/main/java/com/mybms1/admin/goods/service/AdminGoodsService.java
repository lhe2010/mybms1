package com.mybms1.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.mybms1.goods.vo.GoodsVO;
import com.mybms1.goods.vo.ImageFileVO;


public interface AdminGoodsService {
	public List<GoodsVO> listNewGoods() throws Exception;
	
	public int addNewGoods(Map<String,Object> newGoodsMap) throws Exception;

	public Map<String, Object> goodsDetail(int goods_id) throws Exception;
	
	public void modifyGoodsInfo(Map<String,String> goodsMap) throws Exception;
	public void addNewGoodsImage(List<ImageFileVO> imageFileList) throws Exception;
	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception;

	public void removeGoodsImage(int image_id) throws Exception;
}
