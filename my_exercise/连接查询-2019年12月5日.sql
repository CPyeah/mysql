/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询

笛卡尔乘积现象：表1 有m行，表2有n行，结果=m*n行

发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：

	按年代分类：
	sql92标准:仅仅支持内连接
	sql99标准【推荐】：支持内连接+外连接（左外和右外）+交叉连接

	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接

		交叉连接
*/
##连接查询
SELECT * FROM beauty;

SELECT * FROM boys

笛卡尔乘积现象：表1 有m行，表2有n行，结果=m*n行
发生原因：没有有效的连接条件
如何避免：添加有效的连接条件
SELECT NAME,boyName FROM boys,beauty #48行

SELECT NAME,boyName FROM boys,beauty
WHERE beauty.boyfriend_id= boys.id;

##连接分类
按年代分类：
	sql92标准:仅仅支持内连接
	sql99标准【推荐】：支持内连接+外连接（左外和右外）+交叉连接

	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接

		交叉连接

#一、sql92标准
#1、等值连接
/*
① 多表等值连接的结果为多表的交集部分
②n表连接，至少需要n-1个连接条件
③ 多表的顺序没有要求
④一般需要为表起别名
⑤可以搭配前面介绍的所有子句使用，比如排序、分组、筛选
*/

#案例1：查询女神名和对应的男神名
SELECT NAME,boyName FROM boys,beauty
WHERE beauty.boyfriend_id= boys.id;

#案例2：查询员工名和对应的部门名
select * from employees
select * from departments
select last_name, department_name from employees, departments
WHERE employees.department_id = departments.department_id

#2、为表起别名(提交语句简洁度, 排除歧义字段)
#查询员工名、工种号、工种名
select * from jobs
SELECT last_name, jobs.job_id, job_title from employees, jobs
where employees.job_id = jobs.job_id

SELECT last_name, e.job_id, job_title from employees e, jobs j
where e.job_id = j.job_id
# (错误)起了别名后, 查询字段不能使用原来的表名限定
SELECT last_name, e.job_id, job_title from employees e, jobs j
where employees.job_id = j.job_id

#3、两个表的顺序是否可以调换
#查询员工名、工种号、工种名
SELECT last_name, e.job_id, job_title from  jobs j, employees e
where e.job_id = j.job_id

#4、可以加筛选

#案例1：查询有奖金的员工名、部门名
select * FROM employees
select * from departments
SELECT last_name, d.department_name, commission_pct from employees e, departments d
where e.department_id = d.department_id AND e.commission_pct is not NULL

#案例2：查询城市名中第二个字符为o的部门名和城市名
select * from locations
select city, department_name from locations l , departments d
where l.location_id = d.location_id
AND city like '_o%'

#5、可以加分组

#案例1：查询每个城市的部门个数
select count(*), city from locations l, departments d
where l.location_id = d.location_id
GROUP BY city

#案例2：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
select department_name, d.manager_id, MIN(salary)
from departments d, employees e
where d.department_id = e.department_id
AND e.commission_pct is not NULL
GROUP BY e.department_id

#6、可以加排序

#案例：查询每个工种的工种名和员工的个数，并且按员工个数降序

#7、可以实现三表连接？

#案例：查询员工名、部门名和所在的城市

#2、非等值连接

#案例1：查询员工的工资和工资级别

#3、自连接

#案例：查询 员工名和上级的名称
