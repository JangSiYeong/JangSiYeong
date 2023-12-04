package com.SiYeong.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.awt.Graphics2D;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.SiYeong.model.Criteria;
import com.SiYeong.model.ImageVO;
import com.SiYeong.model.MusicVO;
import com.SiYeong.model.PageDTO;
import com.SiYeong.service.MusicService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	
	@Autowired
	private MusicService musicService;
	
	/* 관리자 메인 페이지 이동 */
    @RequestMapping(value="main", method = RequestMethod.GET)
    public void adminMainGET() throws Exception{
        
        logger.info("관리자 페이지 이동");
        
    }
    
    /* 음악 관리 페이지 접속 */
    @RequestMapping(value = "musicManage", method = RequestMethod.GET)
    public void musicManageGET(Criteria cri, Model model) throws Exception{
    	
    	logger.info("음악 관리 페이지 접속.........." + cri);
        
        /* 작가 목록 출력 데이터 */
        List list = musicService.musicGetList(cri);
        
        if(!list.isEmpty()) {
			model.addAttribute("list",list);	// 음악 존재 경우
		} else {
			model.addAttribute("listCheck", "empty");	// 음악 존재하지 않을 경우
		}
        
        /* 페이지 이동 인터페이스 데이터 */
        int total = musicService.musicGetTotal(cri);
        
        PageDTO pageMaker = new PageDTO(cri, total);
        
        model.addAttribute("pageMaker", pageMaker);
        
    }
    
    /* 음악 등록 페이지 접속 */
    @RequestMapping(value = "musicEnroll", method = RequestMethod.GET)
    public void musicEnrollGET() throws Exception{
        logger.info("음악 등록 페이지 접속");
    }
    
    /* 음악 등록 */
    @RequestMapping(value="musicEnroll.do", method = RequestMethod.POST)
    public String musicEnrollPOST(MusicVO music, RedirectAttributes rttr) throws Exception{
 
        logger.info("musicEnroll :" +  music);
        
        musicService.musicEnroll(music);      // 음악 등록 쿼리 수행
        
        rttr.addFlashAttribute("enroll_result", music.getMusicTitle());
        
        return "redirect:/admin/musicManage";
        
    }
    
    /* 음악 상세 페이지 */
	@GetMapping({"/musicDetail", "/musicModify"})
	public void musicGetInfoGET(int musicId, Criteria cri, Model model) throws Exception {
		
		logger.info("musicDetail......." + musicId);
		
		/* 음악 관리 페이지 정보 */
		model.addAttribute("cri", cri);
		
		/* 선택 음악 정보 */
		model.addAttribute("musicInfo", musicService.musicGetDetail(musicId));
		
	}
	
	/* 음악 정보 수정 */
	@PostMapping("/musicModify")
	public String musicModifyPOST(MusicVO music, RedirectAttributes rttr) throws Exception{
		
		logger.info("musicModifyPOST......." + music);
		
		int result = musicService.musicModify(music);
		
		rttr.addFlashAttribute("modify_result", result);
		
		return "redirect:/admin/musicManage";
		
	}
	
	/* 음악 정보 삭제 */
	@PostMapping("/musicDelete")
	public String musicDeletePOST(int musicId, RedirectAttributes rttr) throws Exception {
		
		logger.info("musicDeletePOST..........");
		
		int result = musicService.musicDelete(musicId);
		
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/admin/musicManage";
		
	}
	
	/* 첨부 파일 업로드 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<ImageVO>> uploadAjaxActionPOST(MultipartFile uploadFile) throws Exception {
		
		logger.info("uploadAjaxActionPOST..........");
		
		/* 이미지 파일 체크 */
		
		File checkfile = new File(uploadFile.getOriginalFilename());
		String type = null;
			
		try {
			type = Files.probeContentType(checkfile.toPath());
			logger.info("MIME TYPE : " + type);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(!type.startsWith("image")) {
			
			List<ImageVO> list = null;
			return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			
		}
			
		
		String uploadFolder = "C:\\upload";
		
		/* 날짜 폴더 경로 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		/* 이미저 정보 담는 객체 */
		List<ImageVO> list = new ArrayList<>();
		ImageVO vo = new ImageVO();
		
		/* 파일 이름 */
		String uploadFileName = uploadFile.getOriginalFilename();		
		
		/* uuid 적용 파일 이름 */
		String uuid = UUID.randomUUID().toString();
		
		vo.setFileName(uploadFileName);
		vo.setUploadPath(datePath);
		vo.setUuid(uuid);
		
		uploadFileName = uuid + "_" + uploadFileName;
			
		/* 파일 위치, 파일 이름을 합친 File 객체 */
		File saveFile = new File(uploadPath, uploadFileName);
			
		/* 파일 저장 */
		try {
			uploadFile.transferTo(saveFile);
			
			/* 썸네일 생성 */
			File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
			
			BufferedImage m_image = ImageIO.read(saveFile);

				//비율 
				double ratio = 3;
				//넓이 높이
				int width = (int) (m_image.getWidth() / ratio);
				int height = (int) (m_image.getHeight() / ratio);					
			
			
			Thumbnails.of(saveFile)
	        .size(width, height)
	        .toFile(thumbnailFile);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		list.add(vo);
		
		logger.info("vo : " + vo);
		ResponseEntity<List<ImageVO>> result = new ResponseEntity<List<ImageVO>>(list, HttpStatus.OK);
		
		return result;
		
		
		
		
	}
}
