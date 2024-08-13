package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.CalendarVO;

public interface CalendarService {

	public ArrayList<CalendarVO> calendarListAll();

	public int calendarDeleteTrue(String title, String formattedStartTime);

	public int calendarDelete(String title, String formattedStartTime, String formattedEndTime, Boolean allDay);

	public int calendarInput(CalendarVO vo);

	public int calendarUpdate(CalendarVO vo);


}
