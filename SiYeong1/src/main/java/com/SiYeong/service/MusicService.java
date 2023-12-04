package com.SiYeong.service;

import java.util.List;

import com.SiYeong.model.Criteria;
import com.SiYeong.model.MusicVO;

public interface MusicService {

	
    /* 음악 등록 */
    public void musicEnroll(MusicVO music) throws Exception;
    
    /* 음악 목록 */
    public List<MusicVO> musicGetList(Criteria cri) throws Exception;
    
    /* 음악 총 수 */
    public int musicGetTotal(Criteria cri) throws Exception;
    
    /* 음악 상세 페이지 */
	public MusicVO musicGetDetail(int musicId) throws Exception;
	
	/* 음악 정보 수정 */
	public int musicModify(MusicVO music) throws Exception;
	
	/* 음악 정보 삭제 */
	public int musicDelete(int musicId) throws Exception;
}
