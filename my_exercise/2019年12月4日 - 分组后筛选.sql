#2019年12月4日

#3、分组后筛选
#案例：查询哪个部门的员工个数>5
#①查询每个部门的员工个数
SELECT COUNT(*) 员工个数, department_id from employees GROUP BY department_id
#② 筛选刚才①结果
SELECT COUNT(*) 员工个数, department_id from employees GROUP BY department_id HAVING 员工个数 >5
SELECT COUNT(*) 员工个数, department_id from employees GROUP BY department_id HAVING COUNT(*) >5
#案例2：每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT * from employees
1.
	SELECT MAX(salary), job_id FROM employees where commission_pct is not NULL GROUP BY job_id
2.
	SELECT MAX(salary), job_id FROM employees where commission_pct is not NULL GROUP BY job_id HAVING MAX(salary) > 12000
#案例3：领导编号>102的每个领导手下的最低工资大于5000的领导编号和最低工资
1. 领导编号>102的每个领导手下的最低工资和领导编号
	SELECT MIN(salary), manager_id from employees where manager_id > 102 GROUP BY manager_id
2.
	SELECT MIN(salary), manager_id from employees where manager_id > 102 GROUP BY manager_id HAVING MIN(salary) > 5000


总结:
如果筛选条件在原表中能找到, 那么就通过where分组前筛选
如果筛选条件分组后才能看出, 那么就通过having分组后筛选
分组函数(max,min,count...)做条件, 肯定是放在having后面

#按表达式, 函数分组
1.按员工姓名长度分组, 长度>5的个数
SELECT count(*), LENGTH(last_name) len FROM employees GROUP BY len
SELECT count(*), LENGTH(last_name) len FROM employees GROUP BY len HAVING count(*) > 5

#按做个字段分组
1.每个部门,每个工种的平均工资, job_id, department_id相同的作为一组
SELECT AVG(salary), job_id, department_id from employees GROUP BY job_id, department_id

#4.添加排序
SELECT
	AVG(salary) avg,
	job_id,
	department_id
FROM
	employees
WHERE
	department_id IS NOT NULL
GROUP BY
	job_id,
	department_id
HAVING
	avg > 10000
ORDER BY
	avg DESC
#案例：每个工种有奖金的员工的最高工资>6000的工种编号和最高工资,按最高工资升序
SELECT job_id, MAX(salary) from employees GROUP BY job_id HAVING MAX(salary) > 6000 ORDER BY MAX(salary)
#案例：查询每个工种每个部门的最低工资,并按最低工资降序
SELECT job_id, department_id, MIN(salary) m from employees GROUP BY job_id, department_id ORDER BY m DESC


练习:
select * from employees
#1.查询各job_id的员工工资的最大值，最小值，平均值，总和，并按job_id升序
SELECT MAX(salary), MIN(salary), avg(salary), SUM(salary), job_id from employees GROUP BY job_id ORDER BY job_id

#2.查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT MAX(salary),MIN(salary), MAX(salary)-MIN(salary) DIFFERENCE from employees

#3.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT MIN(salary), manager_id from employees where manager_id IS NOT NULL GROUP BY manager_id HAVING MIN(salary)>=6000

#4.查询所有部门的编号，员工数量和工资平均值,并按平均工资降序
SELECT department_id, count(*), avg(salary) from employees GROUP BY department_id order BY AVG(salary) DESC

#5.选择具有各个job_id的员工人数
SELECT job_id, COUNT(*) from employees GROUP BY job_id