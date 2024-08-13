package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.UserVO;

public interface DbtestDAO {

	public ArrayList<UserVO> getDbtestList();

	public ArrayList<UserVO> getDbtestSearch(@Param("mid") String mid);

	public int setDbtestDelete(@Param("idx") int idx);

	public int setDbtestInputOk(@Param("vo") UserVO vo);

	public int setDbtestUpdateOk(@Param("vo") UserVO vo);

	public UserVO getUserIdCheck(@Param("mid") String mid);

	public ArrayList<String> getMemberArrayList();

}
