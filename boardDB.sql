SELECT board_idx,
member_nickname, board_addr, board_type, board_time
FROM board
ORDER BY board_idx DESC

SELECT no, member_nickname, board_date, job_name 
FROM job ORDER BY no DESC

SELECT * FROM board

SELECT * FROM (
SELECT board.*, member.member_name, member.member_age,
member.member_gender, member.member_phone
FROM board, member
WHERE board.member_nickname = member.member_nickname)
where board_idx=#{board_idx}
		

-- 회원정보와 게시판 등록 정보를 같이 가져옴
SELECT * FROM (
SELECT board.*, 
member.member_name, member.member_age, member.member_gender, member.member_phone
FROM board, member
WHERE board.member_nickname = member.member_nickname)
where board_idx=24


ALTER TABLE board DROP COLUMN member_phone		-- 컬럼 삭제

alter table board add(board_title VARCHAR2(50)); 	-- 컬럼 추가

ALTER TABLE board MODIFY(member_nickname VARCHAR2(30)); 	-- 컬럼 수정

DELETE FROM board
where board_idx=

SELECT * FROM board
-- 알바하고자 등록 하는 게시판
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
    CONSTRAINT BOARD_PK PRIMARY KEY (board_idx)
)

INSERT INTO board
		(board_idx,
		member_nickname,
		board_title,
		board_date,
		board_type,
		board_time,
		board_pay,
		board_addr,
		board_contents)
		VALUES
		((SELECT NVL(MAX(board_idx), 0)+1 FROM board), 
		#{member_nickname},
		#{board_title},
		sysdate,
		#{board_type, jdbcType=VARCHAR}, 		
		#{board_time, jdbcType=VARCHAR},
		#{board_pay},
		#{board_addr},
		#{board_contents})
		

UPDATE board
SET
    board_idx = ,
    member_nickname = 'faith9181',
    board_title = 'board_title 1',
    board_date = sysdate, 
    board_type = 'board_type 1', 
    board_time = 'board_time 1', 
    board_pay = 'board_pay 1', 
    board_addr = 'board_addr 1', 
    board_contents = 'board_contents 1'
WHERE board_idx = 
		
		
-- 공지사항 게시판
CREATE TABLE table_noticeboard		
(
    notice_idx         INT               NOT NULL, 
    member_nickname    VARCHAR2(30)      NULL, 
    notice_title       VARCHAR2(50)      NULL, 
    notice_date        DATE              NULL, 
    notice_contents    VARCHAR2(2000)    NULL, 
    CONSTRAINT TABLE_NOTICEBOARD_PK PRIMARY KEY (notice_idx)
)

INSERT INTO table_noticeboard
	(notice_idx,
	member_nickname,
	notice_title,
	notice_date,
	notice_contents)
VALUES
	((SELECT NVL(MAX(notice_idx), 0)+1 FROM table_noticeboard),
	#{member_nickname},
	#{notice_title},
	sysdate,
	#{notice_contents})

UPDATE table_noticeboard
SET
    notice_idx = 1,
    member_nickname = 'member_nickname 1', 
    notice_title = 'notice_title 1', 
    notice_date = sysdate, 
    notice_contents = 'notice_contents 1'
WHERE notice_idx = 1;

SELECT * FROM table_noticeboard 

SELECT notice_idx, member_nickname, notice_title, notice_date, notice_contents
FROM table_noticeboard
ORDER BY notice_idx DESC;
	

SELECT * FROM 
(SELECT * FROM table_noticeboard ORDER BY notice_idx DESC) 
WHERE rownum<=3




-- 일등록 정보 게시판 가져오기
SELECT no, job_date,  member_nickname, board_date, job_pay
FROM job
ORDER BY no DESC;



SELECT *
		FROM(
			SELECT LEVEL, board_idx, member_nickname, LPAD(' ', 4*(LEVEL-1))||board_type as board_type, board_time,
			board_date, readNo, pno, depth, ROWNUM AS RNUM
			FROM(
				SELECT b.board_idx, member_nickname, board_type, board_time, to_char(board_date,'yyyy/mm/dd hh24:mi:ss')
				board_date, h.readNo, nvl(rpl.pno, 0) as pno, nvl(rpl.depth, 0) as
				depth
				FROM board b
				LEFT JOIN Hits h
				ON b.no = h.no
				LEFT JOIN reply rpl
				ON b.no = rpl.no
			)
		<where>
			<choose>
				<when test='searchOpt eq "id"'>
				id like '%'||searchWord||'%'
				</when>
				<when test='searchOpt eq "title"'>
				title like '%'||searchWord||'%'
				</when>
				<when test='searchOpt eq "all"'>
				title like '%'||searchWord||'%' 
				OR id like '%'||searchWord||'%'
				</when>
			</choose>
		</where>START WITH pno=0
		CONNECT BY PRIOR no=pno
		ORDER SIBLINGS BY no desc
		
		)
WHERE RNUM <![CDATA[ > ]]> #{start} 
AND RNUM <![CDATA[ <= ]]> #{end}

