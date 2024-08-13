package com.spring.javaclassS.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.CalendarDAO;
import com.spring.javaclassS.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	CalendarDAO calendarDAO;

	@Override
	public ArrayList<CalendarVO> calendarListAll() {
		return calendarDAO.calendarListAll();
	}

	@Override
	public int calendarDeleteTrue(String title, String formattedStartTime) {
		return calendarDAO.calendarDeleteTrue(title, formattedStartTime);
	}

	@Override
	public int calendarDelete(String title, String formattedStartTime, String formattedEndTime, Boolean allDay) {
		return calendarDAO.calendarDelete(title, formattedStartTime, formattedEndTime, allDay);
	}

	@Override
	public int calendarInput(CalendarVO vo) {
		return calendarDAO.calendarInput(vo);
	}

	@Override
	public int calendarUpdate(CalendarVO vo) {
		return calendarDAO.calendarUpdate(vo);
	}
	

	
	
}
