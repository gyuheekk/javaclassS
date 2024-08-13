package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.CalendarVO;

public interface CalendarDAO {

	public ArrayList<CalendarVO> calendarListAll();

	public int calendarDeleteTrue(@Param("title") String title, @Param("formattedStartTime") String formattedStartTime);

	public int calendarDelete(@Param("title") String title, @Param("formattedStartTime") String formattedStartTime, @Param("formattedEndTime") String formattedEndTime, @Param("allDay") Boolean allDay);

	public int calendarInput(@Param("vo") CalendarVO vo);

	public int calendarUpdate(@Param("vo") CalendarVO vo);

	
}
