package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class CalendarVO {
	 private int idx;
   private String title;
   private String startTime;
   private String endTime;
   private boolean allDay;
}
