package com.mybms1.admin.goods.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mybms1.admin.goods.service.AdminGoodsService;
import com.mybms1.common.base.BaseController;
import com.mybms1.goods.vo.ImageFileVO;
import com.mybms1.member.vo.MemberVO;
import com.sun.net.httpserver.HttpHandler;

@Controller("adminGoodsController")
@RequestMapping(value="/admin/goods")
public class AdminGoodsControllerImpl extends BaseController implements AdminGoodsController{

	@Autowired
	private AdminGoodsService adminGoodsService;

	@Override
	@RequestMapping(value = "/adminGoodsMain.do")
	public ModelAndView adminGoodsMain(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/goods/adminGoodsMain");
		
		HttpSession session = request.getSession();
		session.setAttribute("side_menu", "admin_mode");
		
		mv.addObject("newGoodsList", adminGoodsService.listNewGoods());
		return mv;
	}
	
	@RequestMapping(value="/addNewGoodsForm.do")
	public ModelAndView addNewGoodsForm(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/goods/addNewGoodsForm");
		
		HttpSession session = request.getSession();
		session.setAttribute("side_menu", "admin_mode"); 
		
		return mv;
	}

	@Override
	@RequestMapping(value = "/addNewGoods.do", method = RequestMethod.POST)
	public ResponseEntity<String> addNewGoods(MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response) throws Exception {
		
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String imageFileName = "";

		// parameter 값 Map에 put
		Map<String, Object> newGoodsMap = new HashMap<String, Object>();
		Enumeration<?> enu = multipartRequest.getParameterNames();	// Returns the names of all the parameters as an Enumeration of Strings.
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
//			System.out.println("name = " + name + ", value = " + value);
			newGoodsMap.put(name, value);
		}
		
		// reg_id 있을경우 설정
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		String reg_id = "";
		if(memberVO != null)	reg_id = memberVO.getMember_id();
		
		// imageFile reg_id세팅 후 map에 추가
		List<ImageFileVO> imageFileList = upload(multipartRequest);
		if(imageFileList != null && imageFileList.size() != 0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList);
		}
		
		String message = "";
		ResponseEntity<String> resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int goods_id = adminGoodsService.addNewGoods(newGoodsMap);
			// 실제 파일 처리
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+seperatorPath+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			message= "<script>";
			message += " alert('성공적으로 등록되었습니다.');";
			message +=" location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
			message +=("</script>");
		} catch (Exception e) {
			if (imageFileList!=null && imageFileList.size() != 0) {
				for (ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH + seperatorPath + "temp" + seperatorPath + imageFileName);
					srcFile.delete();
				}
			}
			
			message= "<script>";
			message += " alert('등록에 실패하였습니다.');";
			message +=" location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity = new ResponseEntity<String>(message, responseHeaders,HttpStatus.OK);
		return resEntity;
	}
	
	@RequestMapping(value = "/modifyGoodsForm.do")
	public ModelAndView modifyGoodsForm(@RequestParam("goods_id") int goods_id,
			HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
//		HttpSession session = request.getSession();
//		session.setAttribute("side_menu", "admin_mode");
		
		mv.setViewName("/admin/goods/modifyGoodsForm");
		mv.addObject("goodsMap", adminGoodsService.goodsDetail(goods_id));
		
		return mv;
	}

	@Override
	@RequestMapping(value = "/modifyGoodsInfo.do", method = RequestMethod.POST)
	public ResponseEntity<String> modifyGoodsInfo(@RequestParam("goods_id") String goods_id, 
												  @RequestParam("attribute") String attribute, 
												  @RequestParam("value") String value) throws Exception {
		Map<String, String> goodsMap = new HashMap<String, String>();
		goodsMap.put("goods_id", goods_id);
		goodsMap.put(attribute, value);
		adminGoodsService.modifyGoodsInfo(goodsMap);
		
		return new ResponseEntity<String>("mod_success", new HttpHeaders(), HttpStatus.OK);
	}

	@Override
	@RequestMapping(value = "/addNewGoodsImage.do", method = RequestMethod.POST)
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName = null;
		
		Map<String, Object> goodsMap = new HashMap<>();
		Enumeration<?> enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			goodsMap.put(name, value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = "";
		if(memberVO != null) 
			reg_id = memberVO.getMember_id();
		
		List<ImageFileVO> imageFileList = null;
		int goods_id = 0;
		try {
			imageFileList = upload(multipartRequest);
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					System.out.println("add에서 goods_id값: "+ goods_id);
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setReg_id(reg_id);
				} // fileName과 fileType은 upload()에서 이미 세팅됨.
				
				adminGoodsService.addNewGoodsImage(imageFileList);
				// 실제 파일 지정된 곳에 저장.
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+seperatorPath+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
		} catch (Exception e) {
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
	}

	@Override
	@RequestMapping(value = "/modifyGoodsImageInfo.do", method = RequestMethod.POST)
	public void modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName = null;
		
		Map<String, Object> goodsMap = new HashMap<>();
		Enumeration<?> enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			goodsMap.put(name, value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = "";
		if(memberVO != null) 
			reg_id = memberVO.getMember_id();
		
		List<ImageFileVO> imageFileList = null;
		int goods_id = 0;
		int image_id = 0;
		try {
			imageFileList = upload(multipartRequest);
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					image_id = Integer.parseInt((String)goodsMap.get("image_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setImage_id(image_id);
					imageFileVO.setReg_id(reg_id);
				} // fileName과 fileType은 upload()에서 이미 세팅됨.
				
				adminGoodsService.modifyGoodsImage(imageFileList);
				// 실제 파일 지정된 곳에 저장.
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+seperatorPath+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
		} catch (Exception e) {
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
	}
	@Override
	@ResponseBody
	@RequestMapping(value = "/removeGoodsImage.do", method = RequestMethod.POST)
	public ResponseEntity<String>  removeGoodsImage(@RequestParam("goods_id") int goods_id ,
								  @RequestParam("image_id") int image_id ,
								  @RequestParam("imageFileName") String imageFileName)  throws Exception {
		adminGoodsService.removeGoodsImage(image_id); // DB데이터는 image_id로 관리, 실제파일은 나머지 인수로!
		try {
			File srcFile = new File(CURR_IMAGE_REPO_PATH+seperatorPath+goods_id+seperatorPath+imageFileName);
			srcFile.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
