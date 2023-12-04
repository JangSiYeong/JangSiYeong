package com.SiYeong.mapper;

import java.util.List;

import com.SiYeong.model.Criteria;
import com.SiYeong.model.MusicVO;

public interface MusicMapper {
	
	/* 음악 등록 */
    public void musicEnroll(MusicVO music);
    
    /* 음악 목록 */
    public List<MusicVO> musicGetList(Criteria cri);

    /* 음악 총 수 */
    public int musicGetTotal(Criteria cri);
    
    /* 음악 상세 */
	public MusicVO musicGetDetail(int musicId);
	
	/* 음악 정보 수정 */
	public int musicModify(MusicVO music);
	
	/* 음악 정보 삭제 */
	public int musicDelete(int musicId);
}
