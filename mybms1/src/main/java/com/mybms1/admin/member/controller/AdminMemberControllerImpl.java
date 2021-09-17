package com.mybms1.admin.member.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mybms1.admin.member.service.AdminMemberService;
import com.mybms1.common.base.BaseController;

@Controller("adminMemberController")
@RequestMapping(value = "/admin/member")
public class AdminMemberControllerImpl extends BaseController implements AdminMemberController {

	@Autowired
	private AdminMemberService adminMemberService;
	
	@Override
	@RequestMapping(value = "/adminMemberMain.do")
	public ModelAndView adminMemberMain(Map<String, String> dateMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/member/adminMemberMain");
		
		HttpSession session = request.getSession();
		session.setAttribute("side_menu", "admin_mode");
		
		// 회원 조회/검색/페이징 부분 추후에.
		HashMap<String, Object> condMap = new HashMap<String, Object>();
		mv.addObject("member_list", adminMemberService.listMember(condMap));
		
		return mv;
	}

	@Override
	@RequestMapping(value = "/memberDetail.do", method = RequestMethod.GET)
	public ModelAndView memberDetail(@RequestParam("member_id") String member_id) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/member/memberDetail");
		mv.addObject("member_info", adminMemberService.memberDetail(member_id));
		return mv;
	}

	@Override
	@RequestMapping(value = "/modifyMemberInfo.do")
	public void modifyMemberInfo(@RequestParam("member_id") String member_id,
								 @RequestParam("mod_type") String mod_type,
								 @RequestParam("value") String value, HttpServletResponse response) throws Exception {
		HashMap<String, String> memberMap = new HashMap<String, String>();
		String val[] = null;
		PrintWriter pw = response.getWriter();
		
		System.out.println("mod_type= "+mod_type+","+"value="+value);
		
		if(mod_type.equals("member_pw")) {
			memberMap.put("member_pw", value);
		} else if(mod_type.equals("member_name")) {
			memberMap.put("member_name", value);
		} else if(mod_type.equals("member_gender")) {
			memberMap.put("member_gender", value);
		} else if(mod_type.equals("member_birth")) {
			val = value.split(",");
			memberMap.put("member_birth_y", val[0]);
			memberMap.put("member_birth_m", val[1]);
			memberMap.put("member_birth_d", val[2]);
			memberMap.put("member_birth_gn", val[3]);
			System.out.println("=");
		} else if(mod_type.equals("tel")) {
			val = value.split(",");
			memberMap.put("tel1", val[0]);
			memberMap.put("tel2", val[1]);
			memberMap.put("tel3", val[2]);
		} else if(mod_type.equals("hp")) {
			val = value.split(",");
			memberMap.put("hp1", val[0]);
			memberMap.put("hp2", val[1]);
			memberMap.put("hp3", val[2]);
			memberMap.put("smssts_yn", val[3]);
		} else if(mod_type.equals("email")) {
			val = value.split(",");
			memberMap.put("email1", val[0]);
			memberMap.put("email2", val[1]);
			memberMap.put("emailsts_yn", val[2]);
		} else if(mod_type.equals("address")) {
			val = value.split(",");
			memberMap.put("zipcode", val[0]);
			memberMap.put("roadAddress", val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("namufiAddress", val[3]);
		} 
		
		memberMap.put("member_id", member_id);
		adminMemberService.modifyMemberInfo(memberMap);
		pw.print("mod_success");
		pw.close();
	}

//	@Override
//	@RequestMapping(value = "/deleteMember.do", method = RequestMethod.POST)
//	public ModelAndView deleteMember(@RequestParam("del_yn") String del_yn, @RequestParam("member_id") String member_id) throws Exception {
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("redirect:/admin/member/adminMemberMain.do");
//		System.out.println("del_yn="+del_yn+", member_id="+member_id);
//		
//		HashMap<String, String> memberMap = new HashMap<String, String>();
//		memberMap.put("del_yn", del_yn);
//		memberMap.put("member_id", member_id);
//		
//		adminMemberService.modifyMemberInfo(memberMap);
//		return mv;
//	}
	
	@Override
	@RequestMapping(value = "/deleteMember.do", method = RequestMethod.POST)
	public ResponseEntity<String> deleteMember(@RequestParam("del_yn") String del_yn, @RequestParam("member_id") String member_id) throws Exception {
		System.out.println("del_yn="+del_yn+", member_id="+member_id);
		
		HashMap<String, String> memberMap = new HashMap<String, String>();
		memberMap.put("del_yn", del_yn);
		memberMap.put("member_id", member_id);
		
		adminMemberService.modifyMemberInfo(memberMap);
		return new ResponseEntity<String>("mod_success", HttpStatus.OK);
	}

}
