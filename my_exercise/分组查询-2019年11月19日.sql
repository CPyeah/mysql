#进阶5：分组查询

/*
语法：

select 查询列表
from 表
【where 筛选条件】
group by 分组的字段
【order by 排序的字段】;

特点：
1、和分组函数一同查询的字段必须是group by后出现的字段
2、筛选分为两类：分组前筛选和分组后筛选
		针对的表			位置		连接的关键字
分组前筛选	原始表				group by前	where
	
分组后筛选	group by后的结果集    		group by后	having

问题1：分组函数做筛选能不能放在where后面
答：不能

问题2：where——group by——having

一般来讲，能用分组前筛选的，尽量使用分组前筛选，提高效率

3、分组可以按单个字段也可以按多个字段
4、可以搭配着排序使用
*/

#引入：查询每个部门的员工个数
desc employees
SELECT department_id , COUNT(*) from employees where department_id = 90
SELECT department_id , COUNT(*) from employees GROUP BY department_id

#1.简单的分组
#案例1：查询每个工种的员工平均工资
select avg(salary), job_id from employees GROUP BY job_id
#案例2：查询每个位置的部门个数
select count(department_id), location_id from departments GROUP BY location_id

#2、可以实现分组前的筛选
select COUNT(DISTINCT job_id) from employees
SELECT COUNT(DISTINCT salary), COUNT(salary), job_id from employees GROUP BY job_id
#案例1：查询邮箱中包含a字符的 每个部门的最高工资
select MAX(salary), department_id from employees where email LIKE '%a%' GROUP BY department_id
#案例2：查询有奖金的每个领导手下员工的平均工资
select avg(salary), manager_id from employees GROUP BY manager_id
select avg(salary), manager_id from employees where commission_pct IS NOT NULL GROUP BY manager_id

#练习
select * from employees
#1.查询公司员工工资的最大值，最小值，平均值，总和
select MAX(salary) , MIN(salary), ROUND(AVG(salary),2), CEIL(SUM(salary)) from employees
#2.查询员工表中的最大入职时间和最小入职时间的相差天数 （DIFFRENCE）
SELECT MAX(hiredate), MIN(hiredate), (MAX(hiredate) - MIN(hiredate))/1000/3600/24 DIFFRENCE from employees
SELECT MAX(hiredate), MIN(hiredate), DATEDIFF(MAX(hiredate),MIN(hiredate)) DIFFRENCE from employees
#DATEDIFF 函数
select DATEDIFF(now(),'1992-12-15')
select DATEDIFF(NOW(),'1995-08-22')
SELECT DATEDIFF(now(),'1992-12-15') - DATEDIFF(NOW(),'1995-08-22')
#3.查询部门编号为90的员工个数
select COUNT(*) from employees where department_id = '90'



























