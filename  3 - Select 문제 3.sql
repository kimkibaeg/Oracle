1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 

select ename as �̸�, substr(hiredate, 1,2) �Ի�⵵, substr(hiredate, 4,2) �Ի��Ѵ�
from employee;

2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.

select ename as �̸�, substr(hiredate, 4,2) "4�����Ի��ѻ��"
from employee
where substr(hiredate, 4,2) = '04';

3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 

select ename ����̸�
from employee
where MOD(MANAGER, 2) =1;


4. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.

select ename ����̸�
from employee
where MOD(salary,3) =0;

5. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 

-- select TO_CHAR (sysdate, 'YYYY-MM-DD MON DAY DY HH:MI:SS') from dual;
select to_char (hiredate, 'YY') �Ի翬��, to_char (hiredate, 'MON') �Ի��, to_char (hiredate, 'DY') �Ի����
from employee;

6. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
   ������ ������ ��ġ ��Ű�ÿ�.
   
select round(sysdate-to_date('2023/01/01', 'YYYY-MM-DD'))��ĥ������ from dual;
   
7. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 

select round(sysdate-to_date('2003/08/02', 'YYYY-MM-DD'))��ĥ������ from dual;

8. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.

select round(months_between(sysdate, to_date('2003/08/02', 'YYYY-MM-DD')))����������� from dual;

9. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�.

select nvl(manager, 0) �����ȣ
from employee;

10.   �����ȣ,
      [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", 
      �̸�, 
       [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"  
       
select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as ������ȣ ,  
    ename, rpad ( substr (ename, 1,1), 4,'*')
    from employee;
       
11.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-12*******
	dual ���̺� ���
    
select rpad (substr('123456-7894156',1,8),14,'*') �ֹι�ȣ, rpad(substr('010-1234-5678',1, 6),13,'*') ��ȭ��ȣ
from dual;
    
12 �ڽ��� ���Ͽ��� ������� ��� ��Ҵ��� ?  ���� ��Ҵ��� ���   <== months_between ( ���糯¥, ����)  : ������ 
        -- sysdate - ���� (date) 

-- select round(months_between (sysdate, to_date('2003/08/02', 'YYYY-MM-DD'))) ������, round(sysdate-to_date('2003/08/02', 'YYYY-MM-DD')) ��ĥ from dual;

select round(months_between(sysdate, to_date('2003/08/02', 'YYYY-MM-DD'))) ����ϱ�, round(sysdate-to_date('2003/08/02', 'YYYY-MM-DD')) ��ĥ from dual;
        
13.  employee ���̺��� 2050�� 12�� 24 �ϱ����� ��¥(�ϼ�)  �� ��� 

   