#二、sql99语法

/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】

分类：
内连接（★）：inner
外连接
	左外(★):left 【outer】
	右外(★)：right 【outer】
	全外：full【outer】
交叉连接：cross
*/

#一）内连接
/*
语法：

select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件;

分类：
等值
非等值
自连接

特点：
①添加排序、分组、筛选
②inner可以省略
③ 筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
④inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集
*/

select * from employees
select * from departments
select * from jobs
select * from locations
#1、等值连接
#案例1.查询员工名、部门名(与92语法等值连接效果一致)
SELECT
	last_name,
	department_name
FROM
	employees e
INNER JOIN departments d ON e.department_id = d.department_id

#案例2.查询名字中包含e的员工名和工种名（添加筛选）
SELECT
	last_name,
	job_title
FROM
	employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE
	last_name LIKE '%e%'

#案例3. 查询部门个数>3的城市名和部门个数，（添加分组+筛选）
#①查询每个城市的部门个数
SELECT
	city,
	COUNT(*)
FROM
	departments d
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY
	city
#②在①结果上筛选满足条件的
SELECT
	city,
	COUNT(*)
FROM
	departments d
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY
	city
HAVING COUNT(*) > 3

#案例4.查询哪个部门的员工个数>3的部门名和员工个数，并按个数降序（添加排序）
#①查询每个部门的员工个数
#② 在①结果上筛选员工个数>3的记录，并排序
SELECT
	department_name,
	COUNT(*) count
FROM
	departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY
	department_name
HAVING
	count > 3
ORDER BY
	count DESC

#案例5.查询员工名、部门名、工种名，并按部门名降序（添加三表连接）
SELECT
	last_name,
	department_name,
	job_title
FROM
	employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY
	department_name DESC

SELECT
	last_name,
	department_name,
	job_title
FROM
	departments d
INNER JOIN employees e ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY
	department_name DESC

2019年12月11日
#二）非等值连接
#查询员工的工资级别
SELECT
	salary,
	grade_level
FROM
	employees e
INNER JOIN job_grades jd ON e.salary BETWEEN jd.lowest_sal
AND jd.highest_sal
#查询工资级别的个数>20的个数，并且按工资级别降序
SELECT
	grade_level,
	COUNT(*) count
FROM
	employees e
INNER JOIN job_grades jd ON e.salary BETWEEN jd.lowest_sal
AND jd.highest_sal GROUP BY grade_level HAVING count > 20 ORDER BY grade_level DESC


#三）自连接
select * from employees
#查询员工的名字、上级的名字
SELECT
	e.last_name,
	m.last_name
FROM
	employees e
INNER JOIN employees m ON e.manager_id = m.employee_id
#查询姓名中包含字符k的员工的名字、上级的名字
SELECT
	e.last_name,
	m.last_name
FROM
	employees e
INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE e.last_name LIKE '%k%'










