/*
    SQL : ��� ���� ����, select, create, alter, drop, insert, update, delete, grant, revoke, rollbac, commit
        - ����ȭ �� ���� ���
        
    SQL ����
        - DQL (Data Query Language) : ���, �˻�
        - DDL (Data Definition Language) : ��Ű�� (Ʋ, ����), ��ü (���̺� ��, �Լ�, ������, Ʈ����, �������ν���, �ε���) ����, ����, ����
                create (����), alter (����), drop (����)
        - DML (Data Manupulation Language) : ���̺��� ���ڵ�(��)�� �����ϴ� ���
                insert (�Է�), update (����), delete (����)
                -- Ʈ������� �߻�(RAM), commit : RAM�� ����� ������ DataBase ������ �����ϵ��� ��... rollback : ������� �ǵ���.
                -- Ʈ������� insert, update, delete ���۵Ǹ� �ڵ����� Ʈ������� ����
                -- Ʈ������� ���� : rollback : �޸𸮿� ����� ������ �ٽ� ���� ���·� �ǵ���, commit : DB�� ���������� ������.
                -- Ʈ������� ���� ���� ������ LOCK �ɷ��� Ʈ����� Ʈ����� ����ɶ� ���� LOCK �ɷ� �ִ�.
                -- ����Ŭ : DML ���� �����ϸ� �ڵ����� Ʈ������� ���۵�.   ���� (rollback, commit)  <== ���
                -- MySQL, MSSQL : DML ���� �����ϸ� �ڵ����� Ʈ������� ���۵�. commit �ڵ����� ó����
                -- ��������� Ʈ������� ���� �� �� �ְ�, ��������� ���� �� �ִ�.
        - DCL (Data Control Language) : ����(Account), ���� ��ü (Resource) �� ������ �ο���. grant(�ο�), revoke(����)
        - TCL (Transaction Control Language) : Ʈ������� �����ϴ� ���.   <== DML ������ ����
            commit (DB�� ������ ����), rollback (������� �ǵ���), savepoint (Ʈ����� ������ �ӽ� ���� ���� ����)
            begin tansaction : ��������� Ʈ����� ����
*/

/*
    Ʈ����� : �۾� (��) �� ó���ϴ� �ּ� ���� : ALL or NOTHING : �Ǹ� ���� �ǰ� �ϰų� �ȵǸ� ���� �ȵǰ� ��.
        - Ʈ������� 4���� Ư¡
            -���ڼ� (Atomicity) : ���� ó���ϴ� �ּ� ����
            - �ϰ��� (Consistency) : Ʈ����ǿ��� ó���� ����� �ϰ����� ������. ALL or NOTHING
            - ������ (lsolation) : �ϳ��� Ʈ������� �ٸ� Ʈ����ǰ� �ݸ��Ǿ� �ִ�..LOCK.
            - ���Ӽ� (Durability) : commit, DB�� ���������� �����
*/

-- ���̺� ����

create table account10
as
select eno as no, ename as name, salary as account
from employee;

-- ������ ���� ���̺� : no : ���¹�ȣ, name ��������, account : �� (�Աݾ�), ��
select *from account10;

-- SMITH���� MILLER���� 10���� �Ա� : 2���� update ������ �ϳ��� transaction ���� ó�� : ALL or NOTHING
    -- SMITH Account - 10��   :   update account10 set account = account -10 where no=7369
    -- MILLER Account + 10��  :   update account10 set account = account +10 where no=7934
    
begin transaction       -- ��������� Ʈ������� ����

update account10 
set account = account -10 
where no = 7369;

update account10 
set account = account +10 
where no = 7934;

select*from account10;

-- Ʈ����� ����
rollback;
commit;

desc account10;

/*
    DML : insert(���� �Է�), update(����), delete(����)
        <== Ʈ����� �ڵ� ����, 
        <== Ʈ����� ���� (rollback, commit)�� ��� (����Ŭ)
*/

-- ���̺� ����
create table dept03
as 
select * from department ;

select *from dept03
-- dept03 : Primary Key ���� ���� �߰�
alter table dept03
add constraint PK_DEPT03_DNO primary key (dno);

-- INSERT : ���� ����, �� �÷��� �ڷ��� : number, ����, ��¥, �÷��� ����� ���� ������ Ȯ��
desc dept03;
select*from user_constraints where table_name in ('DEPT03');

-- insert into ���̺�� (�÷���, �÷���, �÷���) values (��, ��, ��) ;

insert into dept03 (dno, dname, loc)
values (50, 'HR', 'SEOUL');

rollback;
commit;

select *from dept03;

-- insert �� �÷��̸��� ��� ���� �ʴ� ��� ��� �÷��� ���� �־����.
insert into dept03
values (60, '�λ��', '�λ�');

commit;

-- �÷� ���� �� ���� ��� �÷��� ���� ������ �°� �Է�
insert into dept03
values (70, '�λ��');

-- �÷��� ����� �� ������ �ٲ� �� �ְ�, Ư�� �÷��� ���� ���� �ʾƵ� ��.
insert into dept03 (dname, dno)
values ('������', 80);

commit;

-- UPDATE �� : �Էµ� ���� ������ ���, �ݵ�� where ������ ���. where ���ǿ� ���Ǵ� �÷��� Primary Key �÷��̿��� ��.
/*
    update ���̺��
    set �÷��� = �ٲܰ�, �÷��� = �ٲܰ�
    where ����
*/

update dept03
set loc ='�뱸' 
where dno = 80;

rollback;
commit;

select *from dept03;

-- ����
update dept03
set dname = '������', loc = '����'
where dno = 40;

--
insert into dept03
values (90, '������', '�뱸');

insert into dept03
values (91, '������', '����');

-- update ���� �ݵ�� where ����, ������ ó���ϴ� �÷��� Primary Key, Unique Ű �÷��� ����
update dept03
set dname = '�μ��'
where loc = '����';       -- �ߺ��� ��

-- update �� primary key �÷��� �������� ó���ؼ� ���ϴ� ���� ����
update dept03
set dname = '�μ��'
where dno in (91, 80);


-- Delete : ���ڵ带 ���� �� ��, where <����>, <���� : �ߺ����� �ʴ� �÷�>
/*
    delete ���̺��
    where ����
*/

select*from dept03;

-- delete ������ ������ ������� �ʴ� ��� ��� ���ڵ尡 ������
delete dept03

rollback;
commit;

-- delete, where ���� ���.     <== 
delete dept03
where dno = 91;

-- ��� ���ڵ带 ���� :
    -- delete                   : ���ڵ� �ϳ� �ϳ��� ������. �ð��� �����ɸ�, <<�ο췹�� ����>>
    -- truncat table ���̺��    : �Ѳ����� ��ä�� ��� ���ڵ带 ����. <<���� ����>>
    
    -- drop table ���̺��       : ���̺� ��ü�� ����
    
select* from dept03;

rollback;
commit;

-- ��� ���ڵ� ���� : ���� ����
delete dept03;

-- ��� ���ڵ� ���� : ���� ����    <== DDL ���̱� ������ Rollback�� �ȵ�. ���� �� �ٷ� Ŀ�Ե�.
                -- ������ ó����.
                
truncate table dept03;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
create table emp04
as
select *from employee;

select*from emp04;

/*
    ������ ���� �߰� : insert
    ������ ���� ���� : update
    ������ ���� ���� : delete
    
    rollback;
    commit;
*/

/*
    DDL : create (����), alter (����), drop (����)   <== ���̺�, ��, �Լ�, ������, Ʈ����, �������ν���, ��Ű���� ����, ����, ����
    
    �ڷ��� : �����͸� �����ϴ� Ÿ��
       - ���� : number (���� �ڸ���) : ����
               number (7,2)  : �Ҽ�, ��ü 7�ڸ�, �Ҽ��� ���� 2�ڸ� ����
        - ���� : char (n) : ���� 1�� (1byte), �ѱ� 1�� (3byte)
                    - ������ ������. �ϵ� ���� ���� �߻��� �� �ִ�.
                    - �ֹι�ȣ(13), �ڸ����� ������ ���� ����
                varchar2 (n) : ���� 1�� (1byte), �ѱ� 1�� (3byte)
                    - ������������ �����, ������ char ���� ���� �� �ִ�. �ϵ���� ���� ��Ű�� �ʴ´�.
                    - �ڸ����� �� �� ���� ���ڿ� �� ����.
                ncahr(n)        : nchar(10) : �ѱ� 10��
                nvarchar2(n)    : nchar(10) : �ѱ� 10��
        - ��¥ : date : BC 4712�� 1�� 1�� ~~~ 9999�� 12�� 31�� ���� ����,  ��, ��, ��, ��, ��, �� ������ ���� ����
                timestamp : insert (���� ������ �ý����� �ð�) : ��, ��, ��, ��, ��, �� �и������� ���� ����
        - LOB ������ Ÿ�� : �뷮�� ���� ����, ���̳ʸ� ����
            CLOB : ���ڸ� �뷮���� ���� �� �ִ�.        <== �� ����
            BLOB : MP3, jpeg, hwp ���� ������ ����
            BFILE : ��뷮 ���� ����
*/

-- 
drop table test10;
create table test10 (
    id number(4) not null primary key,  -- �ߺ��� ���� �� ����. ���� 4��
    n1 char(10),               -- ���� 10��, �ѱ� 3��
    n2 nchar(10),              -- ���� 10��, �ѱ� 10��
    n3 varchar2(10),           -- ���� 10��, �ѱ� 3��
    n4 nvarchar2(10)           -- ���� 10��, �ѱ� 10��
);

select*from test10;
commit;

insert into test10 (id, n1, n2, n3, n4)
values (1111, 'abcdefghij', '�����ٶ󸶹ٻ������', 'abcdefghij', '�����ٶ󸶹ٻ������');

insert into test10 (id, n1)
values (1112, '������');

/*
     ���� ���� : ���̺��� �÷��� ���� Ű , �������� ���Ἲ (���Ծ��µ�����, ���ϴ� ���� ) 
        Primary Key :  
            - ���̺��� �÷��� 1���� ���� �� �ִ�.  
            - �ΰ� �÷��� ��� PK�� ���� �� �ִ�. 
            - ���̺��� �����Ҷ� �ݵ�� PK �� �����ؾ� �Ѵ�.  - Update, Delete �������� PK �÷��� where �������� �����. 
            - Ư�� �÷��� �ߺ� �� ���� ���� ���ϵ��� ��. 
            - �ݵ�� not null �÷��̾����.  null�� ���� �� ����. 
            - index �� �ڵ����� ���� �ȴ�. �÷��� �˻��� ������ ��. 
            - JOIN �� ON ���� ���� ����ϴ� Ű �÷�. 
        Unique Key : 
            - �÷��� �ߺ��� ���� ���� ���ϵ��� ��. 
            - null�� ���� �� �ִ�. �� 1���� ���� �� �ִ�.  not null, null 
            - �ϳ��� ���̺� ������ Unique Key �� ���� �� �ִ�. 
            - index �� �ڵ����� ������.  JOIN �� ON�� ���� 
        Foreign Key : 
            - �ٸ� ���̺�(�θ� ���̺�) �� Ư�� �÷��� ���� �ؼ� ���� �ֵ��� ��. 
            - Foreign Key �� �����ϴ� �÷��� �θ����̺��� Primary Key , Unique Key �� ������. 
        NOT NULL 
            - �÷��� NULL�� ���� �� ������ �ϴ� ���� ���� 
        CHECK 
            - �÷��� ������ �־ ���� ���ϴ� ���� ���� �� �ֵ��� ��. 
            -  �� �÷���  1 ~ 12 ���� ���� �� �ֵ��� 
        default  : ���� ������ �ƴ����� ���� ����ó�� ���� 
            -  �÷��� ���� ���� ������ default �� ������ ���� ��ϵ�. 
        ���� ������ ����ϴ� ������ ���� : user_constraints
            select *from user_constraints where table_name in ('���̺��');
*/

-- ���� ���� �̸��� ���� �ʰ� ���̺� ���� �� ��� : Oracle���� ���� �����̸��� �����ϰ� �����Ѵ�.
-- insert �� ������ �߻��� ��� �������� �̸����� ������ �÷��� ã�� �����.
create table member1 (
    id varchar2(50) not null primary key,       -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
    pass varchar2(50) not null,
    addr varchar2(100) null,
    jumin char(13) null,        -- �ڸ����� ������ �÷�
    phone varchar2(50),
    age number(3),          -- ���� 3�ڸ�
    weight number(5,2)      -- �Ǽ� ��ü 5�ڸ�, �Ҽ������� 2�ڸ�
);

desc member1 ;
insert into member1 (id, pass, addr, jumin, phone, age, weight)
values ('KITTY', '1234', '����', '123456-789101', '010-1111-1111', 19, 40.00);
commit;

select*from member1;

select*from user_constraints where table_name in ('MEMBER1');

-- ���̺� ���� �� ���� ���� �̸� �ο�
create table member2 (
    id varchar2(50) not null constraint PK_MEMBER2_ID primary key,       -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
    pass varchar2(50) constraint NN_MEMBER2_PASS not null,
    addr varchar2(100) null,
    jumin char(13) null,        -- �ڸ����� ������ �÷�
    phone varchar2(50),
    age number(3),          -- ���� 3�ڸ�
    weight number(5,2)      -- �Ǽ� ��ü 5�ڸ�, �Ҽ������� 2�ڸ�
);

select * from user_constraints where table_name in ('MEMBER2');

insert into member1 (id, pass, addr, jumin, phone, age, weight)
values ('KITTYY', '1234', '����', '123456-789101', '010-1111-1111', 19, 40.00);
commit;

/*
    UNIQUE : �ߺ��� ���� ���� �� ����. null�� ���� �� �ִ�. ���̺� ������ ���� �� �ִ�.
*/

create table member3 (
    id varchar2(50) not null constraint PK_MEMBER3_ID primary key,       -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
    pass varchar2(50) constraint NN_MEMBER3_PASS not null,
    addr varchar2(100) null,
    jumin char(13) null constraint U_MEMBER3_JUMIN unique,         -- �ߺ��Ǹ� �ȵ�
    phone varchar2(50) not null constraint U_MEMBER3_PHONE unique, -- �ߺ��Ǹ� �ȵ�
    age number(3),          -- ���� 3�ڸ�
    weight number(5,2)      -- �Ǽ� ��ü 5�ڸ�, �Ҽ������� 2�ڸ�
);

insert into member3 (id, pass, addr, jumin, phone, age, weight)
values ('abc', '1234', '����', '123456-789102', '010-1111-1112', 30, 77.77);
commit;

-- CHECK ���� ���� : �÷��� ���ǿ� �´� ���� ���� �� �ֵ��� ��.
drop table member4;

create table member4 (
    id varchar2(50) not null constraint PK_MEMBER4_ID primary key,       -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
    pass varchar2(50) constraint NN_MEMBER4_PASS not null,
    addr varchar2(100) null constraint CK_MEMBER4_ADDR check (addr in ('����', '�λ�', '�뱸')),
    jumin char(13) null constraint U_MEMBER4_JUMIN unique,         -- �ߺ��Ǹ� �ȵ�
    phone varchar2(50) not null constraint U_MEMBER4_PHONE unique, -- �ߺ��Ǹ� �ȵ�
    age number(3) constraint CK_MEMBER4_AGE check (age > 0 and age < 200),
    gender char(1) constraint CK_MEMBER4_GENDER check (gender in('w', 'm')),
    weight number(5,2)      -- �Ǽ� ��ü 5�ڸ�, �Ҽ������� 2�ڸ�
);

insert into member4 (id, pass, addr, jumin, phone, age, gender, weight)
values ('abc', '1234', '����', '123456-789102', '010-1111-1112', 100, 'm', 77.77);
commit;

-- default : ���������� �ƴϴ�. ���� ���� �̸��� �ο� �� �� ����.
    -- ���� ���� �� ���� ���� ���� ���� ���� �� default �� ������ ���� ����.

create table member5 (
    id varchar2(50) not null constraint PK_MEMBER5_ID primary key,       -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
    pass varchar2(50) constraint NN_MEMBER5_PASS not null,
    addr varchar2(100) null constraint CK_MEMBER5_ADDR check (addr in ('����', '�λ�', '�뱸')),
    jumin char(13) null constraint U_MEMBER5_JUMIN unique,         -- �ߺ��Ǹ� �ȵ�
    phone varchar2(50) not null constraint U_MEMBER5_PHONE unique, -- �ߺ��Ǹ� �ȵ�
    age number(3) constraint CK_MEMBER5_AGE check (age > 0 and age < 200),
    gender char(1) constraint CK_MEMBER5_GENDER check (gender in('w', 'm')),
    weight number(5,2),      -- �Ǽ� ��ü 5�ڸ�, �Ҽ������� 2�ڸ�
    hiredate date default sysdate,
    addr2 char(10) default '����',
    age2 number default 0
);

select*from member5;

insert into member5 (id, pass, addr, jumin, phone, age, gender, weight)
values ('abc', '1234', '�뱸', '123456-789102', '010-1111-1112', 100, 'm', 77.77);

insert into member5 (id, pass, addr, jumin, phone, age, gender, weight, hiredate, addr2, age2)
values ('abcd', '1234', '����', '123456-789103', '010-1111-1113', 100, 'm', 77.77, '22/11/11', '����', 30);

commit;











