
create table DEPARTMENT (
    DNO number(2) constraint PK_DEPT_DNO primary key,
    DNAME varchar2(14),
    LOC varchar2(13)
);

create table EMPLOYEE(
    ENO number(4) constraint PK_EMPLOYEE_ENO primary key,
    ENAME varchar2(10),
    JOB varchar2(9),
    MANAGER number(4),
    HIREDATE date,
    SALARY number(7,2),
    COMMISSION number(7,2),
    DNO number(2),
        constraint FK_EMPLOYEE_DNO foreign key (DNO) references DEPARTMENT (DNO)
);

select*from department;

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');


select* from employee;

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

-- 1. �����ȣ(eno)�� 7788�� ����� �̸�(ename)�� �μ���ȣ(dno)�� ����ϼ���.  �÷����� ��Ī(alias) ���Ѽ� ��� �ϼ���.

select ename ����̸�, dno �μ���ȣ
from employee
where eno = 7788;

-- 2. 1981�⵵ �Ի��� ����� �̸�(ename)�� �Ի���(hiredate) �� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ���: _ , %)

select ename ����̸�, hiredate �Ի糯¥
from employee
where hiredate like '81%';

-- 3. ��� ����(job) �� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭
    -- �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�.

select ename ����̸�, job ��å, salary ����
from employee
where (job = 'CLERK' or job = 'SALESMAN')and(salary != 1600 and salary != 950 and salary != 1300);

-- 4. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. �Ҽ����� �߶� ��� �ϼ��� . 
        -- (months_between , trunc �Լ� ���)

select round(months_between (sysdate, to_date('2003/08/02', 'YYYY-MM-DD'))) ������ from dual;

-- 5. �μ���(dno) ������ ����� 2000 �̻� ��� �ϵ� �μ���ȣ(dno)��  ������������ ����ϼ���. 
        -- ����� �Ҽ����� 2�ڸ������� ����ϵ� �ݿø��ؼ� ��� �ϼ���.

select dno �μ���ȣ, avg(salary) ��տ���
from 

-- 6. �޿��� ��� �޿����� ���� ������� �����ȣ(eno)�� �̸�(ename)�� ǥ���ϵ� ����� �޿�(salary) �� ���� �������� �����Ͻÿ�.  
        -- subquery�� ����ؼ� ��� �ϼ���.



-- 7. ��å(job) �� 'MANAGER' �� ����̸�(ename), �μ���ȣ(dno), �μ���(dname), �μ���ġ(loc) ����ϵ� 
        -- ����̸�(ename) �������� �����ϼ���.

 select e.ename ����̸�, d.dno �μ���ȣ, d.dname �μ���, d.loc �μ���ġ
 from EMPLOYEE e JOIN DEPARTMENT d
 on e.dno = d.dno
 where e.job = 'MANAGER'
 order by e.ename desc;

-- 8. ������ ������ ������ view �� �����ؼ� �ܼ�ȭ�ϰ� view�� �����Ͻÿ� . 
 -- ��(view) �� :  v_join 

-- employee, department ���̺��� �μ����� �ּ� ������ �޴� 
-- ����̸�(ename), ����� ��å (job), �μ���(dname), �μ���ġ (loc) �� ��µ� 
-- �ּҿ����� 900�̻� �� ����ϼ���. ��, �μ���ȣ 20���� �����ϰ� ����ϼ���. 
--    ��Ʈ :  JOIN, group by, where, having , subquery  ������ Ȱ�� �ϼ���
   
--   - ��� :  view ���� ����, view ���� ���� �� ��������. 

create view v_join
as
select ename ����̸�, job ��å, dname �μ���, loc �μ���ġ
from employee e
     join department d
        on e.dno = d.dno
where salary in (
     select min(salary) from employee
    where dno <> 20
    group by dno
    having min(salary) > 900
);

-- view ����
select *from v_join;


-- 9. ���̺� ����� alter table �� ����Ͽ� ������ ���� ���̺�� ���� ���� ������ �߰� �Ͻÿ� 
        -- employee ���̺��� ��� �÷��� ���� �����Ͽ� EMP50 ���̺��� �����Ͻÿ�
        -- department ���̺��� ��� �÷��� ���� �����Ͽ� DEPT50 ���̺��� �����Ͻÿ�. 
        -- ���� ���̺� �ο��� ���������� ����� ���̺��� �ο� �Ͻÿ� . 



-- 10.























