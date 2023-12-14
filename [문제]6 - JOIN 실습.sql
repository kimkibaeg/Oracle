
create table members20 (
     id varchar2(20) not null constraint PK_MEMBER20_id primary key,
     pwd varchar2(20),
     name varchar2(50),
     zipcode varchar2(7),
        constraint FK_MEMBERS20_ZIPCODE foreign key (zipcode) references tb_zipcode20 (zipcode),
     address varchar2(20),
     tel varchar2(13),
     indate date default sysdate
);

create table tb_zipcode20 (
    zipcode varchar2(7) not null constraint PK_Tb_ZIPCODE20_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

create table products20 (
    product_code varchar2(20) not null constraint PK_PRODUCTS20_product_code primary key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);

create table orders20 (
    o_seq number(10) not null constraint PK_ORDERS20_o_seq primary key,
    product_code varchar2(20),
        constraint FK_ORDERS20_PRODUCT_CODE foreign key (product_code) references products20 (product_code),
    id varchar2(16),
        constraint FK_ORDERS20_ID foreign key (ID) references members20 (id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);




select*from members20;
insert into members20 (id, pwd, name, zipcode, address, tel, indate)
values ('11111', '22222', '헬로키티', '33333', '서울', '1234-1678', '');
insert into members20 (id, pwd, name, zipcode, address, tel, indate)
values ('22222', '33333', '키티안녕', '44444', '홍천', '1235-2678', '');
insert into members20 (id, pwd, name, zipcode, address, tel, indate)
values ('33333', '44444', '키티헬로', '55555', '경주', '1236-3678', '');
insert into members20 (id, pwd, name, zipcode, address, tel, indate)
values ('44444', '55555', '핑크키티', '11111', '대구', '1237-4678', '');
insert into members20 (id, pwd, name, zipcode, address, tel, indate)
values ('55555', '66666', '공주키티', '22222', '부산', '1238-5678', '');

drop table orders20;
drop table members20;
drop table tb_zipcode20;
drop table 


select*from tb_zipcode20;
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('11111', '서울시', '강동구', '상일동', '280번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('22222', '서울시', '송파구', '문정동', '28번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('33333', '서울시', '강남구', '자곡동', '288번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('44444', '서울시', '서초구', '방배동', '82번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('55555', '서울시', '광진구', '구의동', '88번지');
commit;

select*from products20;
insert into products20 (product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('0001', 'HandCream', 'A', '14000', '18000', 'B', 'C', 'S', 'L', '200', 'N', '23/12/12');
insert into products20 (product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('0002', 'Shampoo', 'B', '3000', '12000', 'C', 'D', 'I', 'M', '200', 'N', '23/12/12');
insert into products20 (product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('0003', 'BodyWash', 'C', '14000', '22000', 'D', 'E', 'J', 'N', '200', 'N', '23/12/12');
insert into products20 (product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('0004', 'Lighter', 'D', '50', '500', 'E', 'C', 'F', 'K', '200', 'N', '23/12/12');
insert into products20 (product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('0005', 'Cigarette', 'E', '2000', '4500', 'F', 'G', 'L', 'Q', '200', 'N', '23/12/12');


select*from orders20;
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (0001, '0002', '11111', 'S', '100', 'Y', '23/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (0002, '0003', '22222', 'S', '120', 'Y', '23/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (0003, '0004', '33333', 'S', '130', 'Y', '23/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (0004, '0005', '44444', 'S', '140', 'Y', '23/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (0005, '0001', '55555', 'S', '150', 'Y', '23/12/12');
commit;

-- 4개 테이블 조인 : members20, tb_zipcode20, products20, orders20

select*
from members20 m
    JOIN tb_zipcode20 z
        ON m.zipcode = z.zipcode
    JOIN orders20 o
        ON m.id = o.id
    JOIN products20 p
        ON o.product_code = p.product_code

        
































