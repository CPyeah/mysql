#进阶7：子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句，称为主查询或外查询
分类：
按子查询出现的位置：
	select后面：
		仅仅支持标量子查询
	from后面：
		支持表子查询
	where或having后面：★
		标量子查询（单行） √
		列子查询  （多行） √
		行子查询
	exists后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）
*/

#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）
3、行子查询（多列多行）
特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
> < >= <= = <>
列子查询，一般搭配着多行操作符使用
in、any/some、all
④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果
*/

#1.标量子查询★

#案例1：谁的工资比 Abel 高?
#①查询Abel的工资
SELECT salary from employees where last_name = 'Abel'
#②查询员工的信息，满足 salary>①结果
SELECT * from employees WHERE salary > (SELECT salary from employees where last_name = 'Abel')

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工 姓名，job_id 和工资
#①查询141号员工的job_id
SELECT job_id from employees WHERE employee_id = 141
#②查询143号员工的salary
SELECT salary from employees WHERE employee_id = 143
#③查询员工的姓名，job_id 和工资，要求job_id=①并且salary>②
SELECT last_name, job_id, salary FROM employees
WHERE job_id = (SELECT job_id from employees WHERE employee_id = 141)
AND salary > (SELECT salary from employees WHERE employee_id = 143)

#案例3：返回公司工资最少的员工的last_name,job_id和salary
#①查询公司的 最低工资
SELECT MIN(salary) FROM employees
#②查询last_name,job_id和salary，要求salary=①
SELECT last_name, job_id, salary FROM employees WHERE salary = (SELECT MIN(salary) FROM employees)

#案例4：查询最低工资大于 50号部门最低工资 的部门id和其最低工资
#①查询50号部门的最低工资
SELECT MIN(salary) FROM employees WHERE department_id = 50
#②查询每个部门的最低工资
SELECT department_id, MIN(salary) FROM employees GROUP BY department_id
#③ 在②基础上筛选，满足min(salary)>①
SELECT department_id, MIN(salary) m FROM employees GROUP BY department_id
HAVING m > (SELECT MIN(salary) FROM employees WHERE department_id = 50)

#非法使用标量子查询  (子查询结果必须一行一列)
SELECT department_id, MIN(salary) m FROM employees GROUP BY department_id
HAVING m > (SELECT MIN(salary) FROM employees WHERE department_id = 250)


#2.列子查询（多行子查询）★
in, not in, any, some, all

#案例1：返回location_id是1400或1700的部门中的所有员工姓名
#①查询location_id是1400或1700的部门编号
SELECT DISTINCT department_id from departments WHERE location_id in (1400, 1700)
#②查询员工姓名，要求部门号是①列表中的某一个
SELECT last_name from employees
WHERE department_id in (SELECT department_id from departments WHERE location_id in (1400, 1700))

#案例2：返回其它工种中比 job_id为‘IT_PROG’工种任一工资低的员工的员工号、姓名、job_id 以及salary
#①查询job_id为‘IT_PROG’部门任一工资
SELECT salary from employees where job_id = 'IT_PROG'
#②查询员工号、姓名、job_id 以及salary，salary<(①)的任意一个
SELECT employee_id, last_name, job_id, salary from employees where job_id != 'IT_PROG' and salary <
any(SELECT salary from employees where job_id = 'IT_PROG')
#或
#①找出最大工资
SELECT MAX(salary) from employees where job_id = 'IT_PROG'
#②找出小于①中最大工资的员工信息
SELECT employee_id, last_name, job_id, salary from employees where job_id != 'IT_PROG' and salary <
(SELECT MAX(salary) from employees where job_id = 'IT_PROG')

#案例3：返回其它部门中比job_id为‘IT_PROG’部门所有工资都低的员工   的员工号、姓名、job_id 以及salary
SELECT employee_id, last_name, job_id, salary from employees where job_id != 'IT_PROG' and salary <
ALL(SELECT salary from employees where job_id = 'IT_PROG')
#或
SELECT employee_id, last_name, job_id, salary from employees where job_id != 'IT_PROG' and salary <
(SELECT MIN(salary) from employees where job_id = 'IT_PROG')




#3、行子查询（结果集一行多列或多行多列）

#案例：查询员工编号最小并且工资最高的员工信息
#①查询最小的员工编号
SELECT MIN(employee_id) from employees
#②查询最高工资
SELECT MAX(salary) from employees
#③查询员工信息
SELECT * from employees WHERE
employee_id = (SELECT MIN(employee_id) from employees)
AND salary = (SELECT MAX(salary) from employees)

SELECT * from employees WHERE
(employee_id, salary) = (SELECT MIN(employee_id), MAX(salary) from employees)



#二、select后面
/*
仅仅支持标量子查询
*/
#案例1：查询每个部门的员工个数
SELECT department_id, COUNT(*) from employees GROUP BY department_id
SELECT d.*, (SELECT count(*) from employees e WHERE
 e.department_id = d.department_id) employee_count from departments d

#案例2：查询员工号=102的部门名
SELECT department_name FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id = 102
SELECT (SELECT department_name from departments d WHERE e.department_id = d.department_id)
from employees e where e.employee_id = 102


#三、from后面
/*
将子查询结果充当一张表，要求必须起别名
*/

#案例：查询每个部门的平均工资的工资等级
#①查询每个部门的平均工资
#②连接①的结果集和job_grades表，筛选条件平均工资 between lowest_sal and highest_sal


#四、exists后面（相关子查询）
/*
语法：
exists(完整的查询语句)
结果：
1或0
*/
SELECT EXISTS(SELECT employee_id FROM employees WHERE salary=300000);

#案例1：查询有员工的部门名
#in
#exists

#案例2：查询没有女朋友的男神信息
#in
#exists












