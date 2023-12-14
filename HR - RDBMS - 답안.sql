
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

-- 1. 사원번호(eno)가 7788인 사원의 이름(ename)과 부서번호(dno)를 출력하세요.  컬럼명을 별칭(alias) 시켜서 출력 하세요.

select ename 사원이름, dno 부서번호
from employee
where eno = 7788;

-- 2. 1981년도 입사한 사원의 이름(ename)과 입사일(hiredate) 을 출력 하시오 ( like 연산자와 와일드 카드 사용: _ , %)

select ename 사원이름, hiredate 입사날짜
from employee
where hiredate like '81%';

-- 3. 담당 업무(job) 가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서
    -- 급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.

select ename 사원이름, job 직책, salary 월급
from employee
where (job = 'CLERK' or job = 'SALESMAN')and(salary != 1600 and salary != 950 and salary != 1300);

-- 4. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 소숫점은 잘라서 출력 하세요 . 
        -- (months_between , trunc 함수 사용)

select round(months_between (sysdate, to_date('2003/08/02', 'YYYY-MM-DD'))) 개월수 from dual;

-- 5. 부서별(dno) 월급의 평균이 2000 이상만 출력 하되 부서번호(dno)를  오름차순으로 출력하세요. 
        -- 평균의 소숫점은 2자리까지만 출력하되 반올림해서 출력 하세요.

select dno 부서번호, avg(salary) 평균월급
from 

-- 6. 급여가 평균 급여보다 많은 사원들의 사원번호(eno)와 이름(ename)을 표시하되 결과를 급여(salary) 에 대해 오름차순 정렬하시오.  
        -- subquery를 사용해서 출력 하세요.



-- 7. 직책(job) 이 'MANAGER' 인 사원이름(ename), 부서번호(dno), 부서명(dname), 부서위치(loc) 출력하되 
        -- 사원이름(ename) 내림차순 정렬하세요.

 select e.ename 사원이름, d.dno 부서번호, d.dname 부서명, d.loc 부서위치
 from EMPLOYEE e JOIN DEPARTMENT d
 on e.dno = d.dno
 where e.job = 'MANAGER'
 order by e.ename desc;

-- 8. 다음은 복잡한 쿼리를 view 를 생성해서 단순화하고 view를 실행하시오 . 
 -- 뷰(view) 명 :  v_join 

-- employee, department 테이블의 부서별로 최소 월급을 받는 
-- 사원이름(ename), 사원의 직책 (job), 부서명(dname), 부서위치 (loc) 를 출력되 
-- 최소월급이 900이상 만 출력하세요. 단, 부서번호 20번은 제외하고 출력하세요. 
--    힌트 :  JOIN, group by, where, having , subquery  구문을 활용 하세요
   
--   - 답안 :  view 생성 구문, view 실행 구문 을 넣으세요. 

create view v_join
as
select ename 사원이름, job 직책, dname 부서명, loc 부서위치
from employee e
     join department d
        on e.dno = d.dno
where salary in (
     select min(salary) from employee
    where dno <> 20
    group by dno
    having min(salary) > 900
);

-- view 실행
select *from v_join;


-- 9. 테이블 복사및 alter table 을 사용하여 복사한 원본 테이블과 같은 제약 조건을 추가 하시오 
        -- employee 테이블의 모든 컬럼과 값을 복사하여 EMP50 테이블을 생성하시오
        -- department 테이블의 모든 컬럼과 값을 복사하여 DEPT50 테이블을 생성하시오. 
        -- 원본 테이블에 부여된 제약조건을 복사된 테이블에도 부여 하시오 . 



-- 10.























