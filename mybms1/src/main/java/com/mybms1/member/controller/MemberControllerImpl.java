package com.mybms1.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mybms1.member.service.MemberService;
import com.mybms1.member.vo.MemberVO;
import com.sun.istack.internal.logging.Logger;
import com.sun.net.httpserver.HttpHandler;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl implements MemberController {
	
	@Autowired
	private MemberVO memberVO = null;
	
	@Autowired
	private MemberService memberService;
	
//	Logger log = Logger.getLogger(this.getClass());
	
	@Override
	@RequestMapping(value = "/login.do", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		memberVO = memberService.login(loginMap);
		
		if(memberVO != null && memberVO.getMember_id() != null) { // 로그인성공
			System.out.println(memberVO.toString());
			HttpSession session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberVO);
			String action = (String)session.getAttribute("action");
			// action 이 orderEachGoods.do일 경우는 다음에 작성
			mv.setViewName("redirect:/main/main.do");
		} else { // 로그인 실패
			mv.addObject("message", "로그인에 실패하였습니다. ");
			mv.setViewName("/member/loginForm");
		}
		return mv;
	}

	@Override
	@RequestMapping(value="/loginForm.do", method = RequestMethod.GET)
	public ModelAndView loginForm() throws Exception {
		return new ModelAndView("/member/loginForm");
	}

	@Override
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		
		mv.setViewName("redirect:/main/main.do");
		return mv;
	}

	@Override
	@RequestMapping(value = "/addMember.do", method = RequestMethod.POST)
	public ResponseEntity<String> addMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (memberVO.getEmailsts_yn() == null)  memberVO.setEmailsts_yn("N");
		if (memberVO.getSmssts_yn() == null)    memberVO.setSmssts_yn("N");

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		
		String message = "";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=UTF-8");
		
		try {
			memberService.addMember(memberVO);
			message="<script>"+"alert('회원가입완료!');"
					+"location.href='"+request.getContextPath()+"/member/loginForm.do';</script>";
		} catch (Exception e) {
			message="<script>alert('회원가입실패!');"
					+"location.href='"+request.getContextPath()+"/member/memberForm.do';</script>";
			e.printStackTrace();
		}
		return new ResponseEntity<String>(message, responseHeaders, HttpStatus.OK);
	}

	@Override
	@RequestMapping(value = "/memberForm.do", method = RequestMethod.GET)
	public ModelAndView memberForm() throws Exception {
		return new ModelAndView("/member/memberForm");
	}

	@Override
	@RequestMapping(value = "/overlapped.do", method = RequestMethod.POST)
	public ResponseEntity<String> overlapped(String id) throws Exception {
		return new ResponseEntity<String>(memberService.overlapped(id), HttpStatus.OK);
	}

}
