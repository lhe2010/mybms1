package com.mybms1.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybms1.goods.dao.GoodsDAO;
import com.mybms1.goods.vo.GoodsVO;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	private GoodsDAO goodsDAO;

	@Override
	public Map<String, List<GoodsVO>> listGoods() throws Exception {
		Map<String, List<GoodsVO>> goodsMap = new HashMap<String, List<GoodsVO>>();
		
		goodsMap.put("bestseller", goodsDAO.selectGoodsList("bestseller"));
		goodsMap.put("newbook", goodsDAO.selectGoodsList("newbook"));
		goodsMap.put("steadyseller", goodsDAO.selectGoodsList("steadyseller"));
		return goodsMap;
	}

	@Override
	public Map<String, Object> goodsDetail(String goods_id) throws Exception {
		Map<String, Object> goodsMap = new HashMap<String, Object>();
		goodsMap.put("goodsVO", goodsDAO.selectGoodsDetail(goods_id));
		goodsMap.put("imageList", goodsDAO.selectGoodsDetailImage(goods_id));
		return goodsMap;
	}
	
	
}
