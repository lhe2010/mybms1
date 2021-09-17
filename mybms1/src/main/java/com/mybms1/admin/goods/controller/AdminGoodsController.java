package com.mybms1.admin.goods.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface AdminGoodsController {
	public ModelAndView adminGoodsMain(HttpServletRequest request)  throws Exception;

	public ResponseEntity<String> addNewGoods(MultipartHttpServletRequest multipartRequest , HttpServletResponse response)  throws Exception;

	public ResponseEntity<String> modifyGoodsInfo(@RequestParam ("goods_id") String goods_id,
												  @RequestParam ("mod_type") String mod_type,
												  @RequestParam ("value") String value) throws Exception;
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest , HttpServletResponse response)  throws Exception;
	public void modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest , HttpServletResponse response)  throws Exception;

	public ResponseEntity<String> removeGoodsImage(@RequestParam("goods_id") int goods_id ,
								  @RequestParam("image_id") int image_id ,
								  @RequestParam("imageFileName") String imageFileName)  throws Exception;
}
