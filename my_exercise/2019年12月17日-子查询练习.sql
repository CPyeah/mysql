#1.	查询和Zlotkey相同部门的员工姓名和工资
#①查询Zlotkey的部门
SELECT department_id from employees WHERE last_name = 'Zlotkey'
#②查询部门号=①的姓名和工资
SELECT last_name, salary from employees where
department_id = (SELECT department_id from employees WHERE last_name = 'Zlotkey')

#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
#①查询平均工资
SELECT AVG(salary) from employees
#②查询工资>①的员工号，姓名和工资。
SELECT employee_id, last_name, salary from employees
WHERE salary > (SELECT AVG(salary) from employees)

#3.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资
#①查询各部门的平均工资
SELECT department_id, AVG(salary) from employees GROUP BY department_id
#②连接①结果集和employees表，进行筛选
SELECT employee_id, last_name, salary, t.a from employees e
INNER JOIN (SELECT department_id, AVG(salary) a from employees GROUP BY department_id) t
ON e.department_id = t.department_id WHERE e.salary > t.a

#4.	查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
#①查询姓名中包含字母u的员工的部门
SELECT DISTINCT department_id from employees where last_name LIKE '%u%'
#②查询部门号=①中的任意一个的员工号和姓名
SELECT employee_id, last_name from employees
where department_id in (SELECT DISTINCT department_id from employees where last_name LIKE '%u%')

#5. 查询在部门的location_id为1700的部门工作的员工的员工号
#①查询location_id为1700的部门
SELECT department_id from departments where location_id = '1700'
#②查询部门号=①中的任意一个的员工号
SELECT * from employees e WHERE department_id in
(SELECT department_id from departments where location_id = '1700')

#6.查询管理者是King的员工姓名和工资
#①查询姓名为king的员工编号
SELECT employee_id from employees WHERE last_name = 'K_ing'
#②查询哪个员工的manager_id = ①
SELECT last_name, salary, manager_id FROM employees WHERE manager_id
in (SELECT employee_id from employees WHERE last_name = 'K_ing')

#7.查询工资最高的员工的姓名，要求first_name和last_name显示为一列，列名为 姓.名
#①查询最高工资
SELECT MAX(salary) from employees
#②查询工资=①的姓.名
SELECT CONCAT(first_name, ' ', last_name) name FROM employees
WHERE salary = (SELECT MAX(salary) from employees )



