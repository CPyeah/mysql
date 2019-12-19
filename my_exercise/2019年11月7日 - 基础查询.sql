#常用命令
show DATABASES
show TABLES
DESC employees
SELECT VERSION()

#查询
SELECT last_name from employees
SELECT * from employees
select 100
select 'cp'
select 100*3 AS sum
select '11'+3
select 'a' + 3
select last_name '姓', first_name '名' FROM employees
select VERSION()

select job_id from employees
select DISTINCT job_id from employees

select concat('a', '4', '#')

select last_name , job_id , salary as sal
from employees;
select * from employees;
select employee_id , last_name,
salary * 12 'ANNUAL SALARY'
from employees;
DESC departments
DESC employees
select DISTINCT job_id from employees
select CONCAT(employee_id,',',last_name, ',', first_name, ',', IFNULL(commission_pct,'null')) AS out_put FROM employees

#11、条件查询
SELECT * from employees where salary >= 20000
SELECT * from employees where salary >= 10000 and salary < 20000
select * from employees where salary < 10000
#12、模糊查询
select * from employees where first_name like 'A%'
select * from employees where first_name like '_A%'
select * from employees where last_name like '_\_%'
select * from employees where last_name like '_~_%' ESCAPE '~'#自定义转译符

#13、关键字： like， escape， between and， in， is null, is not null, <=>安全等于
select * from employees where salary BETWEEN 10000 and 20000
select * from employees where job_id in ('AD_vp', 'sa_rep')
select * from employees t where t.commission_pct is null
select * from employees t where t.commission_pct is NOT null
select * from employees t where t.commission_pct <=> null

#14、练习案例2
1. 查询工资大于 12000 的员工姓名和工资
select CONCAT(first_name,' ', last_name) as '姓名', salary '工资' from employees where salary > 12000
2. 查询员工号为 176 的员工的姓名和部门号和年薪
select CONCAT(first_name,' ', last_name) as '姓名', department_id '部门号', salary*12 AS '年薪' FROM employees where employee_id = 176 
3. 选择工资不在 5000 到 12000 的员工的姓名和工资
select CONCAT(first_name,' ', last_name) as '姓名', salary '工资' from employees where NOT salary BETWEEN 5000 and 12000
4. 选择在 20 或 50 号部门工作的员工姓名和部门号
select CONCAT(first_name,' ', last_name) as '姓名', department_id '部门号' from employees where department_id in (20, 50)
5. 选择公司中没有管理者的员工姓名及 job_id
select CONCAT(first_name,' ', last_name) as '姓名', job_id from employees where manager_id is null
6. 选择公司中有奖金的员工姓名，工资和奖金级别
select CONCAT(first_name,' ', last_name) as '姓名', salary '工资', commission_pct '奖金级别' from employees
7. 选择员工姓名的第三个字母是 a 的员工姓名
select CONCAT(first_name,' ', last_name) as '姓名' from employees where first_name like '__a%'
8. 选择姓名中有字母 a 和 e 的员工姓名
select CONCAT(first_name,' ', last_name) 姓名 from employees where first_name like '%e%a%' or first_name like '%e%a%'
9. 显示出表 employees 表中 first_name 以 'e'结尾的员工信息
select CONCAT(first_name,' ', last_name) 姓名 from employees where first_name like '%e'
10. 显示出表 employees 部门编号在 80-100 之间 的姓名、职位
select CONCAT(first_name,' ', last_name) 姓名, job_id 职位, department_id from employees where department_id BETWEEN 80 and 100
11. 显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、职位
select CONCAT(first_name,' ', last_name) 姓名, job_id 职位, manager_id from employees where manager_id in (100, 101, 110)

