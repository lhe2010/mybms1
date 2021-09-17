package com.mybms1.goods.service;

import java.util.List;
import java.util.Map;

import com.mybms1.goods.vo.GoodsVO;

public interface GoodsService {
	public Map<String, List<GoodsVO>> listGoods() throws Exception;
	public Map<String, Object> goodsDetail(String goods_id) throws Exception;

}
