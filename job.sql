
CREATE TABLE job
(   
	no               INT               not null,
    member_nickname    VARCHAR2(20)    NOT NULL, 
    job_comment        CLOB            NULL, 
    job_pay            VARCHAR2(20)    NOT NULL, 
    latitude           BINARY_DOUBLE   NOT NULL, 
    longitude          BINARY_DOUBLE   NOT NULL,
    road_address       VARCHAR2(80)    NOT NULL, 
    address            VARCHAR2(60)    NOT NULL, 
    detail_address     VARCHAR2(60)    NULL, 
    job_name           VARCHAR2(60)    NOT NULL, 
    member_phone       VARCHAR2(20)    NOT NULL, 
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
     no    int     not  null,
   member_nickname    varchar2(20)    not null,
   apply_contents  CLOB        null,
    apply_status  varchar2(20)   not null
)



