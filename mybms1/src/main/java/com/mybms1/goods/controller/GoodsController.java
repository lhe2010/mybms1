package com.mybms1.goods.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface GoodsController {
	
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id, HttpServletRequest request) throws Exception;

}
