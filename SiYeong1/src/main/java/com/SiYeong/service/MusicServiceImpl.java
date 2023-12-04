package com.SiYeong.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SiYeong.mapper.MusicMapper;
import com.SiYeong.model.Criteria;
import com.SiYeong.model.MusicVO;


@Service
public class MusicServiceImpl implements MusicService{
	
	private static final Logger log = LoggerFactory.getLogger(MusicServiceImpl.class);
	
	@Autowired
    MusicMapper musicMapper;
	
	/* 음악 등록*/
	@Override
	public void musicEnroll(MusicVO music) throws Exception {
	        
	     musicMapper.musicEnroll(music);
	        
	}
	/* 음악 목록*/
	@Override
	public List<MusicVO> musicGetList(Criteria cri) throws Exception {
	        
	     return musicMapper.musicGetList(cri);
	        
	}
	
	/* 음악 목록*/
	@Override
	public int musicGetTotal(Criteria cri) throws Exception {
	     log.info("(service)musicGetTotal() ....." + cri);   
	     return musicMapper.musicGetTotal(cri);
	        
	}
	
	/* 음악 상세 페이지 */
	@Override
	public MusicVO musicGetDetail(int musicId) throws Exception {
		log.info("musicGetDetail........" + musicId);
		return musicMapper.musicGetDetail(musicId);
	}
	
	/* 음악 정보 수정 */
	@Override
	public int musicModify(MusicVO music) throws Exception {
		log.info("(service) musicModify........." + music);
		return musicMapper.musicModify(music);
	}
	
	/* 음악 정보 삭제 */
	@Override
	public int musicDelete(int musicId) throws Exception {
		log.info("(service) musicDelete........." + musicId);
		return musicMapper.musicDelete(musicId);
	}
}