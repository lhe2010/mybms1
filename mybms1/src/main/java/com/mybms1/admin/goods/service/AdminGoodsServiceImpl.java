package com.mybms1.admin.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybms1.admin.goods.dao.AdminGoodsDAO;
import com.mybms1.goods.vo.GoodsVO;
import com.mybms1.goods.vo.ImageFileVO;

@Service("adminGoodsService")
public class AdminGoodsServiceImpl implements AdminGoodsService {

	@Autowired
	private AdminGoodsDAO adminGoodsDAO;

	@Override
	public List<GoodsVO> listNewGoods() throws Exception {
		return adminGoodsDAO.selectNewGoodsList();
	}

	@Override
	public int addNewGoods(Map<String, Object> newGoodsMap) throws Exception {
		int goods_id = adminGoodsDAO.insertNewGoods(newGoodsMap);
		
		ArrayList<ImageFileVO> imageFileList = (ArrayList) newGoodsMap.get("imageFileList");
		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoods_id(goods_id);
		}
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		
		return goods_id;
	}

	@Override
	public Map<String, Object> goodsDetail(int goods_id) throws Exception {
		Map<String, Object> goodsMap = new HashMap<String, Object>();
		goodsMap.put("goods", adminGoodsDAO.selectGoodsDetail(goods_id));
		goodsMap.put("imageFileList", adminGoodsDAO.selectGoodsImageFileList(goods_id));
		
		return goodsMap;
	}

	@Override
	public void modifyGoodsInfo(Map<String, String> goodsMap) throws Exception {
		adminGoodsDAO.updateGoodsInfo(goodsMap);
	}

	@Override
	public void addNewGoodsImage(List<ImageFileVO> imageFileList) throws Exception {
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
	}

	@Override
	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception {
		adminGoodsDAO.updateGoodsImage(imageFileList);
	}

	@Override
	public void removeGoodsImage(int image_id) throws Exception {
		adminGoodsDAO.deleteGoodsImage(image_id);		
	}
}
