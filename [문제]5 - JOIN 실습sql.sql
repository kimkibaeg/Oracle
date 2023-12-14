/*
    JOIN 실습
    member10 : 회원정보를 저장하는 테이블
    zipcode10 : 우편번호를 저장하는 테이블
    product10 : 제품 정보를 저장하는 테이블
    order10 : 주문 정보를 저장하는 테이블
*/

-- 테이블 삭제 : Foreign Key 가 참조하는 테이블은 삭제 되지 않는다. : cascade constraints
    -- 1. 참조하는 테이블을 먼저 삭제 후 삭제해야 한다.
    -- 2. 테이블 삭제시 cascade constraints 옵션을 사용해서 강제 삭제
    
-- Member10 테이블에서 참조되는 테이블이므로 삭제가 안된다.
drop table zipcode10;
-- Order10 테이블에서 참조 되기 때문에 삭제 할 수 없다.
drop table member10;

-- select * from user_constraints where table_name = 'MEMBER10';
drop table order10;
drop table product10;

-- 2. 테이블 삭제시 cascade constraints 옵션을 사용해서 강제 삭제
    -- zipcode10 테이블을 참조하는 테이블을 강제로 먼저 삭제 후 해당 테이블을 삭제함.
drop table zipcode10 cascade constraints;
drop table member10 cascade constraints;
drop table order10 cascade constraints;
drop table prodeuct10 cascade constraints;












create table zipcode10 (
    zipcode number(6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,
    si_do varchar2(200) not null,
    gu_gun varchar2(200) not null,
    bungi varchar2(200) not null
);

create table member10 (
    m_id number(4) not null constraint PK_MEMBER10_M_ID primary key,
    pass varchar2(200) not null,
    name varchar2(200) not null,
    email varchar2(200) not null,
    zipcode number(6) null,
    -- Foreign Key 제약 조건 추가함.
        constraint FK_MEMBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10(zipcode)
);

create table product10 (
    pro_id number(6) not null constraint PK_PRODUCT10_PRO_ID primary key,
    pro_name varchar2(200) not null,
    pro_price number(7,2) not null,
    pro_cnt number(4) default 0 not null
);

create table order10 (
    ord_id number(6) not null constraint PK_ORDER10_ORD_ID primary key,
    m_id number(4) not null,        -- FK : MEMBER10(m_id)
    pro_id number(6) not null,      -- FK : PRODUCT10 (pro_id)
        -- Foreign Key 2개
        constraint PK_ORDER10_M_ID foreign key (m_id) references member10(m_id),
        constraint PK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)
);

-- 각 테이블에 레코드 5개씩 넣습니다.

-- ANSI JOIN 문을 사용해서 주문정보 (Order10) 테이블을 기준으로
    -- 주문자명, 주문자메일주소, 주문자번지(시도), 주문제품명, 제품의 가격을 출력 합니다.
    -- order10, member10, zipcode10, product10
    
select*from zipcode10;
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (11111, '서울특별시', '강동구', '280번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (22222, '대구광역시', '북구', '28번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (33333, '대전광역시', '유성구', '2번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (44444, '부산광역시', '해운대구', '288번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (55555, '서울특별시', '강남구', '120번지');

-- Member10 테이블에는 ㅊ참조 되지 않지만 zipcode10 테이블에는 존재함 <== RIGHT OUTER JOIN
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (66666, '세종특별시', '세종구', '999번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (77777, '서울특별시', '송파구', '122번지');

commit;

select*from member10;
insert into member10 (m_id, pass, name, email, zipcode)
values (1234, 'asdf4567', '깅깅뱅', 'gigi@naver.com', 11111);
insert into member10 (m_id, pass, name, email, zipcode)
values (2345, 'zxcv1234', '키티키티', 'gogo@naver.com', 22222);
insert into member10 (m_id, pass, name, email, zipcode)
values (3456, 'qwer7890', '키티포리', 'lego@naver.com', 33333);
insert into member10 (m_id, pass, name, email, zipcode)
values (4567, 'poiu9876', '키티사랑', 'mugo@naver.com', 44444);
insert into member10 (m_id, pass, name, email, zipcode)
values (5678, 'lkjh6543', '키티내거', 'dogo@naver.com', 55555);
commit;

-- member10 테이블에는 존재하지만 주문정보에는 없는 회원
    -- insert into member10(m_id, pass, name, email, zipcode)
    

select*from product10;
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0001, 'LipBomb', 14000, 10);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0002, 'HandCream', 8000, 5);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0003, 'BodyWash', 6000, 3);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0004, 'Lotion', 16000, 7);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0005, 'Lighter', 500, 100);
commit;

-- 주문정보에는 없는 제품(주문되지 않는 제품),    <== RIGHT OUTER JOIN
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0006, 'Cigarrete', 4500, 50);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0007, 'Ciga', 50000, 1);



select*from order10;
insert into order10 (ord_id, m_id, pro_id)
values (111111, 0000, 9999);
insert into order10 (ord_id, m_id, pro_id)
values (222222, 1111, 8888);
insert into order10 (ord_id, m_id, pro_id)
values (333333, 2222, 7777);
insert into order10 (ord_id, m_id, pro_id)
values (444444, 3333, 6666);
insert into order10 (ord_id, m_id, pro_id)
values (555555, 4444, 0000);

select name 주문자명, email 주문자메일주소, si_do 주문자번지, pro_name 주문제품명, pro_price 제품의가격
from order10 o JOIN member10 m
on o.m_id = m.m_id
JOIN product10 p
on o.pro_id = p.pro_id
JOIN zipcode10 z
on m.zipcode = z.zipcode;


-- 모델링 되지 않는 주문 테이블    <== order11
create table order11 (
    o_id number (6) not null primary key,
    
    m_name varchar2(200) not null,          -- 주문자 이름
    m_phone varchar2(200) not null,         -- 주문자 핸드폰 번호
    m_add varchar2(200) not null,           -- 주문자의 배송 주소
    m_email varchar2(200) not null,         -- 주문자의 메일 주소
    
    p_id number(6)_ not null,               -- 제품 번호
    p_name varchar2(200) not null,          -- 제품 이름
    p_price number(7,2) not null,           -- 제품 가격
    p_cnt number(6) null                    -- 제품 수량
    )
    
    insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
    values (10, '헬로키티', '1234-5678', '서울', 'HelloKitty@naver.com', 0001, 'LipBomb', 14000, 10) ;
    
    insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
    values (20, '키티헬로', '1235-5679', '대구', 'KittyHello@naver.com', 0002, 'HandCream', 8000, 5) ;
    commit;
    
    select * from order11;
    
-- JOIN : ANSI JOIN
    -- INNER JOIN : on 절에 공통의 값만 출력한다.
    -- LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용 출력
    -- RIGHT OUTER JOIN : 오른쪽의 모든 내용 출력
    
-- member10 (다), zipcode(1) 테이블 :
select *
from member10 m
    JOIN zipcode10 z
    ON m.zipcode = z.zipcode ;

-- member10 에는 on 절에 매칭 되지 않더라도 오른쪽 테이블의 모든 값을 출력 : RIGHT OUTER JOIN

select *
from member10 m
    RIGHT OUTER JOIN zipcode10
        on m.zipcode = z.zipcode ;
        
-- 주문 테이블 (order10), 주문자 정보 (member10) <== on m_id

select *from order10;

select*
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id;
        
-- 주문 정보에 없는 사용자 출력 (주문하지 않는 사용자) : RIGHT OUTER JOIN
select*
from order10 o
    RIGHT OUTER JOIN member10 m
        ON o.m_id = m.m_id;
        
        
select*
from member10 m
    LEFT OUTER JOIN order10 o
        ON m.m_id = o.m_id;
        

-- 3개 테이블 조인 : Order10, member10, zipcode10

select *
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode;
        
        
-- 4개 테이블 조인 : order10, member10, zipcode10, product10

select*
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode
    JOIN product10 p
        ON o.pro_id = p.pro_id;
        
        
-- 주문하지 않는 사용자 정보도 출력, 판매되지 않는 제품도 OUTER JOIN을 사용해서 출력
select*
from order10 o
    RIGHT OUTER JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode
    RIGHT OUTER JOIN product10 p
        ON o.pro_id = p.pro_id;













