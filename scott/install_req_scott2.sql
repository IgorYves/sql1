
--1
select e1.ename, e1.empno from emp e1 left join emp e2 on (e1.empno = e2.mgr) where e2.empno is null;

--2
select e1.empno, e1.ename, e1.job, e1.mgr, e1.hiredate, e1.sal, e1.comm, e1.deptno 
	from emp e1 inner join emp e2 on (e1.mgr= e2.empno) 
	where (select mgr from emp where ename = 'CLARK') = e1.mgr and e1.ename != 'CLARK';

--3
select e1.empno, e1.ename, e1.job, e1.mgr, e1.hiredate, e1.sal, e1.comm, e1.deptno 
	from emp e1 inner join emp e2 on (e1.mgr= e2.empno) 
	where (select mgr from emp where ename = 'TURNER') = e1.mgr 
	and (select job from emp where ename = 'TURNER') = e1.job 
	and e1.ename != 'TURNER';

--4
select e1.ename, e1.hiredate from emp e1 inner join emp e2 on (e1.mgr= e2.empno) 
	where e1.hiredate in 
		(select hiredate from emp e3 inner join dept on(e3.deptno=dept.deptno) where dept.dname='SALES') 
	and e1.deptno = (select deptno from dept where dname = 'RESEARCH');

--5
select ename, trunc(sal/1000)*1000 as "tranche de salaire" from emp order by sal;

--6
select decode(deptno, 10, '****', ename) as ename, job, sal, deptno from emp;

--7
select ename, job, lpad(' ', sal/100 + 1, '#') as histogramme from emp order by sal desc;

--8
select ename, trunc(to_date(hiredate), 'month') "debut du mois d'embauche" from emp;

--9


