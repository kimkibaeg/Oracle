/*
    JOIN �ǽ�
    member10 : ȸ�������� �����ϴ� ���̺�
    zipcode10 : �����ȣ�� �����ϴ� ���̺�
    product10 : ��ǰ ������ �����ϴ� ���̺�
    order10 : �ֹ� ������ �����ϴ� ���̺�
*/

-- ���̺� ���� : Foreign Key �� �����ϴ� ���̺��� ���� ���� �ʴ´�. : cascade constraints
    -- 1. �����ϴ� ���̺��� ���� ���� �� �����ؾ� �Ѵ�.
    -- 2. ���̺� ������ cascade constraints �ɼ��� ����ؼ� ���� ����
    
-- Member10 ���̺��� �����Ǵ� ���̺��̹Ƿ� ������ �ȵȴ�.
drop table zipcode10;
-- Order10 ���̺��� ���� �Ǳ� ������ ���� �� �� ����.
drop table member10;

-- select * from user_constraints where table_name = 'MEMBER10';
drop table order10;
drop table product10;

-- 2. ���̺� ������ cascade constraints �ɼ��� ����ؼ� ���� ����
    -- zipcode10 ���̺��� �����ϴ� ���̺��� ������ ���� ���� �� �ش� ���̺��� ������.
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
    -- Foreign Key ���� ���� �߰���.
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
        -- Foreign Key 2��
        constraint PK_ORDER10_M_ID foreign key (m_id) references member10(m_id),
        constraint PK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)
);

-- �� ���̺� ���ڵ� 5���� �ֽ��ϴ�.

-- ANSI JOIN ���� ����ؼ� �ֹ����� (Order10) ���̺��� ��������
    -- �ֹ��ڸ�, �ֹ��ڸ����ּ�, �ֹ��ڹ���(�õ�), �ֹ���ǰ��, ��ǰ�� ������ ��� �մϴ�.
    -- order10, member10, zipcode10, product10
    
select*from zipcode10;
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (11111, '����Ư����', '������', '280����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (22222, '�뱸������', '�ϱ�', '28����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (33333, '����������', '������', '2����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (44444, '�λ걤����', '�ؿ�뱸', '288����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (55555, '����Ư����', '������', '120����');

-- Member10 ���̺��� ������ ���� ������ zipcode10 ���̺��� ������ <== RIGHT OUTER JOIN
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (66666, '����Ư����', '������', '999����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (77777, '����Ư����', '���ı�', '122����');

commit;

select*from member10;
insert into member10 (m_id, pass, name, email, zipcode)
values (1234, 'asdf4567', '����', 'gigi@naver.com', 11111);
insert into member10 (m_id, pass, name, email, zipcode)
values (2345, 'zxcv1234', 'ŰƼŰƼ', 'gogo@naver.com', 22222);
insert into member10 (m_id, pass, name, email, zipcode)
values (3456, 'qwer7890', 'ŰƼ����', 'lego@naver.com', 33333);
insert into member10 (m_id, pass, name, email, zipcode)
values (4567, 'poiu9876', 'ŰƼ���', 'mugo@naver.com', 44444);
insert into member10 (m_id, pass, name, email, zipcode)
values (5678, 'lkjh6543', 'ŰƼ����', 'dogo@naver.com', 55555);
commit;

-- member10 ���̺��� ���������� �ֹ��������� ���� ȸ��
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

-- �ֹ��������� ���� ��ǰ(�ֹ����� �ʴ� ��ǰ),    <== RIGHT OUTER JOIN
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

select name �ֹ��ڸ�, email �ֹ��ڸ����ּ�, si_do �ֹ��ڹ���, pro_name �ֹ���ǰ��, pro_price ��ǰ�ǰ���
from order10 o JOIN member10 m
on o.m_id = m.m_id
JOIN product10 p
on o.pro_id = p.pro_id
JOIN zipcode10 z
on m.zipcode = z.zipcode;


-- �𵨸� ���� �ʴ� �ֹ� ���̺�    <== order11
create table order11 (
    o_id number (6) not null primary key,
    
    m_name varchar2(200) not null,          -- �ֹ��� �̸�
    m_phone varchar2(200) not null,         -- �ֹ��� �ڵ��� ��ȣ
    m_add varchar2(200) not null,           -- �ֹ����� ��� �ּ�
    m_email varchar2(200) not null,         -- �ֹ����� ���� �ּ�
    
    p_id number(6)_ not null,               -- ��ǰ ��ȣ
    p_name varchar2(200) not null,          -- ��ǰ �̸�
    p_price number(7,2) not null,           -- ��ǰ ����
    p_cnt number(6) null                    -- ��ǰ ����
    )
    
    insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
    values (10, '���ŰƼ', '1234-5678', '����', 'HelloKitty@naver.com', 0001, 'LipBomb', 14000, 10) ;
    
    insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
    values (20, 'ŰƼ���', '1235-5679', '�뱸', 'KittyHello@naver.com', 0002, 'HandCream', 8000, 5) ;
    commit;
    
    select * from order11;
    
-- JOIN : ANSI JOIN
    -- INNER JOIN : on ���� ������ ���� ����Ѵ�.
    -- LEFT OUTER JOIN : ���� ���̺��� ��� ���� ���
    -- RIGHT OUTER JOIN : �������� ��� ���� ���
    
-- member10 (��), zipcode(1) ���̺� :
select *
from member10 m
    JOIN zipcode10 z
    ON m.zipcode = z.zipcode ;

-- member10 ���� on ���� ��Ī ���� �ʴ��� ������ ���̺��� ��� ���� ��� : RIGHT OUTER JOIN

select *
from member10 m
    RIGHT OUTER JOIN zipcode10
        on m.zipcode = z.zipcode ;
        
-- �ֹ� ���̺� (order10), �ֹ��� ���� (member10) <== on m_id

select *from order10;

select*
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id;
        
-- �ֹ� ������ ���� ����� ��� (�ֹ����� �ʴ� �����) : RIGHT OUTER JOIN
select*
from order10 o
    RIGHT OUTER JOIN member10 m
        ON o.m_id = m.m_id;
        
        
select*
from member10 m
    LEFT OUTER JOIN order10 o
        ON m.m_id = o.m_id;
        

-- 3�� ���̺� ���� : Order10, member10, zipcode10

select *
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode;
        
        
-- 4�� ���̺� ���� : order10, member10, zipcode10, product10

select*
from order10 o
    JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode
    JOIN product10 p
        ON o.pro_id = p.pro_id;
        
        
-- �ֹ����� �ʴ� ����� ������ ���, �Ǹŵ��� �ʴ� ��ǰ�� OUTER JOIN�� ����ؼ� ���
select*
from order10 o
    RIGHT OUTER JOIN member10 m
        ON o.m_id = m.m_id
    JOIN zipcode10 z
        ON m.zipcode = z.zipcode
    RIGHT OUTER JOIN product10 p
        ON o.pro_id = p.pro_id;













