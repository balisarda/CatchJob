CREATE TABLE member
(
    member_idx         INT              NOT NULL, 
    member_name        VARCHAR2(20)     NULL, 
    member_nickname    VARCHAR2(20)     NULL,
    member_pw         VARCHAR2(128)    NULL,
    member_age         VARCHAR2(8)       NULL, 
    member_gender      VARCHAR2(1)      NULL, 
    member_email       VARCHAR2(40)     NULL, 
    member_phone       VARCHAR2(20)     NULL, 
    CONSTRAINT MEMBER_PK PRIMARY KEY (member_idx)
)

select * from MEMBER
delete from MEMBER
where member_idx=3
drop table member


