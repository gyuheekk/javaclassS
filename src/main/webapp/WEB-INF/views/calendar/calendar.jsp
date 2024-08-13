<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">  
  <title>.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <!-- fullcalendar CDN -->
	<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
	<!-- fullcalendar 언어 CDN -->
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  <script>
    'use strict';
 
        /* full calender */
     
    (function(){
       $(function(){
         // calendar element 취득
         var calendarEl = $('#calendar')[0];
         // full-calendar 생성하기
         var calendar = new FullCalendar.Calendar(calendarEl, {
           height: '700px', // calendar 높이 설정
           expandRows: true, // 화면에 맞게 높이 재설정
           slotMinTime: '05:00', // Day 캘린더에서 시작 시간
           slotMaxTime: '24:00', // Day 캘린더에서 종료 시간
           // 해더에 표시할 툴바
           headerToolbar: {
             left: 'prev,next today',
             center: 'title',
             right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
           },
           initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
            // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
           navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
           editable: true, // 수정 가능?
           selectable: true, // 달력 일자 드래그 설정가능
           nowIndicator: true, // 현재 시간 마크
           dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
           locale: 'ko', // 한국어 설정
           eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트  
               console.log(obj);
           },
           eventChange: function(info) { // 이벤트가 수정되면 발생하는 이벤트
                   var idx = info.event.extendedProps.idx; 
                       var title = info.event.title;
                  var start = info.event.start;
                  var end = info.event.end;
                  var allDay = info.event.allDay;
                  // 서버로 수정된 일정 정보를 전송
                  $.ajax({
                      type: "POST",
                      url: "${ctp}/calendar/calendarUpdate", // 서버 측 스크립트의 URL
                      data: {
                              idx : idx,
                              title: title,
                          start: start,
                          end: end,
                          allDay: allDay
                      },
                      success: function(res) {
                          if (res != "0") {
                              alert("일정이 수정되었습니다.");
                              location.reload();
                          } else {
                              alert("일정 수정 실패");
                          }
                      },
                      error: function() {
                          alert("연결오류~");
                      }
                  });
             console.log("수정");
           },
           eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
             console.log(obj);
           },
           select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
        	   var title = prompt('[안내] 태그 제한으로 등록되지 않습니다. 일정을 입력하세요:');
             //var title = [안내]태그제한으로등록되지않습니다('일정을 입력하세요:');
             if (title) {
               calendar.addEvent({
                 title: title,
                 start: arg.start,
                 end: arg.end,
                 allDay: arg.allDay
               });
               
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarInput", // 서버 측 스크립트의 URL
                   data: {
                           title: title,
                           start: arg.start.toISOString(),  
                       end: arg.end.toISOString(),      
                       allDay: arg.allDay
                       
                   },
                   success: function(res) {
                       if (res != "0" ){
                           alert("일정이 저장되었습니다");
                           location.reload();
                      } else  {
                          alert("일정 저장 실패");
                      }
                   },
                   error: function() {
                       alert("연결오류~");
                   }
               });
             }
             calendar.unselect();
           },
           // 이벤트 
           events: function(fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: "${ctp}/calendar/calendarListAll",
                    type: "POST",
                    dataType: "json",
                    success: function(data) {
                        data.forEach(function(vo) {
                            calendar.addEvent({
                                idx: vo.idx, // 이벤트의 고유 ID
                                title: vo.title,
                                start: vo.startTime,
                                end: vo.endTime,
                                allDay: vo.allDay
                            });
                        });
                        successCallback([]);
                    },
                    error: function() {
                        failureCallback("연결 오류~");
                    }
                });
            },
           eventClick: function(info) {
        	   if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
               info.event.remove(); // 이벤트 삭제
               
            // 이벤트 속성 값 가져오기
               var title = info.event.title;
               // 한국 표준시(KST)로 변환
               var options = { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
               var start = new Date(info.event.start).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '');
               var end = info.event.end ? new Date(info.event.end).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '') : null;
               var allDay = info.event.allDay;
               
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarDelete", // 서버 측 스크립트의 URL
                   data: {
                           title: title,
                       start: start,
                       end: end,
                       allDay: allDay
                   },
                   success: function(res) {
                       if (res != "0" ){
                           alert("일정이 삭제되었습니다.");
                             location.reload();
                      } else  {
                          alert("일정 삭제 실패");
                      }
                   },
                   error: function() {
                       alert("연결오류~");
                   }
               });
               
             }
           }
         });
         // 캘린더 랜더링
         calendar.render();
        
       });
     })();    
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<div id='calendar-container'>
    <div id='calendar'>
  </div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>