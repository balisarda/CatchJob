-- ���� �Խ���
CREATE TABLE board
(
    board_idx          INT               NOT NULL, 
    member_nickname    VARCHAR2(30)      NOT NULL, 
    board_title        VARCHAR2(50)      NOT NULL, 
    board_date         DATE              NOT NULL, 
    board_type         VARCHAR2(100)     NULL, 
    board_time         VARCHAR2(100)     NULL, 
    board_pay          VARCHAR2(50)      NULL, 
    board_addr         VARCHAR2(100)     NULL, 
    board_contents     VARCHAR2(2000)    NULL,
    board_hits 		   INT 		         NULL,
    CONSTRAINT BOARD_PK PRIMARY KEY (board_idx)
)

-- ��ȸ�� �÷� ����
ALTER TABLE board MODIFY(board_hits int default 0)
		
		
-- �������� �Խ���
CREATE TABLE table_noticeboard		
(
    notice_idx         INT               NOT NULL, 
    member_nickname    VARCHAR2(30)      NULL, 
    notice_title       VARCHAR2(50)      NULL, 
    notice_date        DATE              NULL, 
    notice_contents    VARCHAR2(2000)    NULL,
    notice_hits		   INT		   	     NULL,
    CONSTRAINT TABLE_NOTICEBOARD_PK PRIMARY KEY (notice_idx)
)

-- job ���̺� ��ȸ�� ���� �÷� �߰�
-- ���������̶� ���� �Ŀ� ������ ��. 
ALTER TABLE job MODIFY(job_hits int default 0)
		








