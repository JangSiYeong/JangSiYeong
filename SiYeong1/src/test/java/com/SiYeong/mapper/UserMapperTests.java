package com.SiYeong.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.SiYeong.model.Criteria;
import com.SiYeong.model.MusicVO;
import com.SiYeong.model.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserMapperTests {
	 
    @Autowired
    private MusicMapper mapper;
    
    /* 작가 정보 수정 */
	@Test
	public void authorModifyTest() {
		
		MusicVO author = new MusicVO();
				
		author.setMusicId(1);
		System.out.println("수정 전...................." + mapper.musicGetDetail(author.getMusicId()));
		
		author.setMusicTitle("수정");
		author.setNationId("01");
		author.setMusicLyrics("소개 수정 하였습니다.");
		
		mapper.musicModify(author);
		System.out.println("수정 후...................." + mapper.musicGetDetail(author.getMusicId()));
		
	}
    
}