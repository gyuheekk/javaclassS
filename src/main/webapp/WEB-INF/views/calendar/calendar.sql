show tables;
 
CREATE TABLE calendar (
    idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,     -- 일정 고유번호
    title VARCHAR(255) NOT NULL,                                                                    -- 일정 내용
    startTime DATETIME NOT NULL,                                                                 -- 일정 시작 시간
    endTime DATETIME,                                                                                                   -- 일정 종료 시간
    allDay BOOLEAN NOT NULL DEFAULT FALSE                           -- 종일 일정 여부 (TRUE: 종일, FALSE: 시간 지정)
);
 
drop table calendar;
desc calendar
 
insert into calendar values(default, '일정시작', '2024-06-01', '2024-06-02', false);
 
select * from calendar;