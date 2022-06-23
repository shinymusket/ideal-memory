CREATE TABLE course_tbl (
    id VARCHAR2(5) PRIMARY KEY,
    name VARCHAR2(40),
    credit NUMBER(6),
    lecturer NUMBER(6),
    week NUMBER(2),
    start_hour number(4),
    end_hour number(4)
);

INSERT INTO course_tbl VALUES ('10001', '프로그래밍', '2', '1', '1', '0900', '1100');
INSERT INTO course_tbl VALUES ('10002', '객체지향 프로그래밍', '2', '2', '2', '0900', '1200');
INSERT INTO course_tbl VALUES ('10003', '자료구조', '3', '4', '3', '0900', '1200');
INSERT INTO course_tbl VALUES ('10004', '알고리즘', '3', '4', '4', '0900', '1200');
INSERT INTO course_tbl VALUES ('20001', '시스템 프로그래밍', '2', '5', '1', '1300', '1600');
INSERT INTO course_tbl VALUES ('20002', '운영체제', '3', '5', '2', '1500', '1800');
INSERT INTO course_tbl VALUES ('20003', '오토마타와 컴파일러', '3', '5', '3', '1330', '1630');
INSERT INTO course_tbl VALUES ('30001', '소프트웨어 공학', '2', '3', '4', '1300', '1530');
INSERT INTO course_tbl VALUES ('30002', '시스템 분석 및 설계', '3', '3', '5', '0900', '1200');
INSERT INTO course_tbl VALUES ('40001', '데이터베이스', '3', '2', '5', '1300', '1600');

SELECT * FROM course_tbl;

COMMIT;

DROP TABLE lecturer_tbl;

CREATE TABLE lecturer_tbl (
    idx NUMBER(6) PRIMARY KEY,
    name VARCHAR2(10),
    major VARCHAR2(30),
    field VARCHAR2(30)
);

CREATE SEQUENCE lecturer_seq
NOCACHE;

DROP SEQUENCE lecturer_seq;

INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '김교수', '소프트웨어 공학', '알고리즘');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '이교수', '소프트웨어 공학', '인공지능');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '박교수', '소프트웨어 공학', '소프트웨어 공학');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '오교수', '소프트웨어 공학', '알고리즘');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '최교수', '응용컴퓨터 공학', '임베디드 시스템');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '강교수', '응용컴퓨터 공학', '멀티미디어');
INSERT INTO lecturer_tbl VALUES (LECTURER_SEQ.nextval, '황교수', '모바일 시스템 공학', '네트워크');

SELECT * FROM lecturer_tbl;