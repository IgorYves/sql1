--1
select * from emp where job = 'MANAGER' and (deptno=20 or deptno=30);

--2
select * from emp where job != 'MANAGER' and hiredate between '01/01/81' and '31/12/81';

--3
select ename from emp where ename like '%M%A%' or ename like '%A%M%';
select ename from emp where ename like '%M%' and ename like '%A%';


--4
select ename from emp where ename like '%A%A%';

--5
select * from emp where comm is not null;

--6
select ename, deptno, job, hiredate from emp order by deptno, job, hiredate;
select ename, deptno, job, hiredate from emp order by deptno asc, job asc, hiredate asc;

--7
select * from emp inner join dept on (emp.deptno = dept.deptno) where dept.loc = 'DALLAS';

--8
select emp1.ename, emp1.hiredate, emp2.ename, emp2.hiredate 
	from emp emp1 cross join emp emp2 
	where emp1.mgr = emp2.empno and emp1.hiredate < emp2.hiredate;
	
select emp1.ename, emp1.hiredate, emp2.ename, emp2.hiredate 
	from emp emp1 inner join emp emp2 on emp1.mgr = emp2.empno 
	where emp1.hiredate < emp2.hiredate;

--9
select ename, hiredate from emp where hiredate < (select hiredate from emp where ename = 'BLAKE');

--10
select ename, hiredate from emp 
	where hiredate = (select hiredate from emp where ename = 'FORD') and ename != 'FORD';

--11
select * from emp where hiredate < (select min(hiredate) from emp where deptno = 10);

--12
select emp1.ename from emp emp1 inner join emp emp2 on emp1.mgr = emp2.empno where emp1.sal > emp2.sal;

--13
select distinct job, count(empno) from emp group by job;

--14
select a.ename, a.sal, a.deptno from emp a 
	inner join (select max(sal) msal, deptno from emp group by deptno) b on (a.deptno = b.deptno and a.sal=b.msal);

--15
select job, avg(sal) from emp group by job having avg(sal)=(select min(avg(sal)) from emp group by job);

--16
update emp set sal = sal + (select sal*5/100 from emp where ename = 'KING') where job = 'MANAGER';
select ename, job, sal from emp;
rollback;

--17
insert into salgrade select deptno, min(sal), max(sal) from emp group by deptno;
select * from salgrade;
rollback;

--18
delete from emp emp1 
	where sal < (select avg(sal) from emp emp2 group by deptno having emp1.deptno = emp2.deptno);
select * from emp;
rollback;

