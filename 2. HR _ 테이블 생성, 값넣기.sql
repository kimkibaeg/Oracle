
/*
    CRUD : Create, Read, Update, Delete
           (����)  (�˻�) (����)   (����)
*/

    I
-- ������ ���̺� ����
Create Table member (
    idx number not null ,
    name varchar2(50) not null,
    id varchar2(50) not null,
    pw varchar2(50) not null,
    addr varchar2(50) null
    );
-- �˻� : select
select * from member ;

-- �Է� : Table�� ���� ����.
insert into member ( idx, name, id, pw, addr )
values (1, 'ȫ�浿', 'kkb', '1234', '����') ;
commit;     -- DB�� ������ �����ض�.

insert into member (idx, name, id, pw, addr)
values (2, '��浿', 'kkb1', '1234', '�λ�') ;
commit;
