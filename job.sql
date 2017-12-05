
CREATE TABLE job
(   no               INT            not null,
    member_nickname    VARCHAR2(20)    NOT NULL, 
    job_comment        CLOB            NULL, 
    job_pay            VARCHAR2(20)    NOT NULL, 
    latitude           BINARY_DOUBLE   NOT NULL, 
    longitude          BINARY_DOUBLE   NOT NULL, 
    road_address       VARCHAR2(80)    NOT NULL, 
    address            VARCHAR2(60)    NOT NULL, 
    detail_address     VARCHAR2(60)    NULL, 
    job_name           VARCHAR2(60)    NOT NULL, 
    member_phone      VARCHAR2(20)    NOT NULL, 
    job_num            INT             NOT NULL,  
    job_option         VARCHAR2(20)    NOT NULL, 
    job_date           VARCHAR2(60)    NOT NULL, 
    job_time_start     VARCHAR2(20)    NOT NULL, 
    job_time_end       VARCHAR2(20)    NOT NULL,
    board_date         DATE         not null,  
    CONSTRAINT JOB_PK PRIMARY KEY(no)
)

CREATE SEQUENCE job_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE applyInfo
(
   no    int     not null,
   member_nickname    varchar2(20)    not null,
   apply_contents  CLOB        null,
    apply_status  varchar2(20)   not null
)


select *from job

INSERT INTO job
    (no, 
    member_nickname, 
    job_comment, 
    job_pay, 
    latitude, 
    longitude, 
    road_address, 
    address, 
    detail_address, 
    job_name, 
    member_phone, 
    job_num, 
    job_option, 
    job_date, 
    job_time_start, 
    job_time_end, 
    board_date)
VALUES
    ((SELECT NVL(MAX(no), 0)+1 FROM job),
    'faith9181', 
    'job_comment 1', 
    'job_pay 1', 
    '1', 
    '1', 
    'road_address 1', 
    'address 1', 
    'detail_address 1', 
    '웹 개발', 
    'member_phone 1', 
    1, 
    'job_option 1', 
    'job_date 1', 
    'job_time_start 1', 
    'job_time_end 1', 
    sysdate)

select * from job


CREATE SEQUENCE job_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE job DROP COLUMN board_date			-- 컬럼 삭제
alter table job add(board_date VARCHAR2(80)) 		-- 컬럼 추가
ALTER TABLE job MODIFY(board_date VARCHAR2(80))	 -- 컬럼 수정
DELETE FROM table_job 
drop table job

DELETE FROM job
WHERE no =4


