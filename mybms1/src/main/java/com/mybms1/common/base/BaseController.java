package com.mybms1.common.base;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mybms1.goods.vo.ImageFileVO;

public class BaseController {
	
//	protected static String CURR_IMAGE_REPO_PATH = "C:\\file_repo";	// window용. 개발용.
//	protected String seperatorPath = "\\";
	
//	private static String CURR_IMAGE_REPO_PATH = "/var/lib/tomcat8/file_repo";	// Linux용. 배포용.

	protected static String CURR_IMAGE_REPO_PATH = "/Users/hayley/file_repo";	// Mac용. 개발용.
	protected String seperatorPath = "/";
	
	protected List<ImageFileVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<ImageFileVO> fileList = new ArrayList<ImageFileVO>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			// fileType과 fileName 세팅후 list객체에 추가
			ImageFileVO imageFileVO = new ImageFileVO();
			String fileName = fileNames.next();
			imageFileVO.setFileType(fileName); // main_image or detail_image
			
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			imageFileVO.setFileName(originalFileName);
			fileList.add(imageFileVO);
			
			// 디렉토리
			File file = new File(CURR_IMAGE_REPO_PATH + seperatorPath + fileName);
			if (mFile.getSize() != 0) {	// File Null Check
				if(!file.exists()) {
					if(file.getParentFile().mkdirs())
						file.createNewFile();
				}
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH+seperatorPath+"temp"+seperatorPath+originalFileName));
			}
		}
		return fileList;
	}
	
}
