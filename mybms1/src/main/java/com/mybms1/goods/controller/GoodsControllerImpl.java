package com.mybms1.goods.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mybms1.goods.service.GoodsService;

@Controller("goodsController")
@RequestMapping(value = "/goods")
public class GoodsControllerImpl implements GoodsController {

	@Autowired
	private GoodsService goodsService;
	
	@Override
	@RequestMapping(value = "/goodsDetail.do", method = RequestMethod.GET)
	public ModelAndView goodsDetail(String goods_id, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		Map<String, Object> goodsMap = goodsService.goodsDetail(goods_id);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/goods/goodsDetail");
		mv.addObject("goodsMap", goodsMap);
		
		// quickmenu 추가부분
		return mv;
	}
}
