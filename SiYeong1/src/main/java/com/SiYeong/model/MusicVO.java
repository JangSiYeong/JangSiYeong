package com.SiYeong.model;

public class MusicVO {

	/* 음악 아이디 */
	private int musicId;

	/* 음악 제목 */
	private String musicTitle;

	/* 음악 가수 */
	private String musicSinger;

	/* 음악 가사 */
	private String musicLyrics;

	/* 음악 국가 */
	private String nationId;

	public int getMusicId() {
		return musicId;
	}

	public void setMusicId(int musicId) {
		this.musicId = musicId;
	}

	public String getMusicTitle() {
		return musicTitle;
	}

	public void setMusicTitle(String musicTitle) {
		this.musicTitle = musicTitle;
	}

	public String getMusicSinger() {
		return musicSinger;
	}

	public void setMusicSinger(String musicSinger) {
		this.musicSinger = musicSinger;
	}

	public String getMusicLyrics() {
		return musicLyrics;
	}

	public void setMusicLyrics(String musicLyrics) {
		this.musicLyrics = musicLyrics;
	}

	public String getNationId() {
		return nationId;
	}

	public void setNationId(String nationId) {
		this.nationId = nationId;
		/*
		 * if(nationId.equals("01")) { this.nationId = "국내"; } else { this.nationId =
		 * "국외"; }
		 */
	}

	@Override
	public String toString() {
		return "MusicVO [musicId=" + musicId + ", musicTitle=" + musicTitle + ", musicSinger=" + musicSinger
				+ ", musicLyrics=" + musicLyrics + ", nationId=" + nationId + "]";
	}

	
	
}
