测 试 一
1. 下面的语句是否可以执行成功
select last_name , job_id , salary as sal
from employees;
2. 下面的语句是否可以执行成功
select * from employees;
3. 找出下面语句中的错误
select employee_id , last_name,
salary * 12 'ANNUAL SALARY'
from employees;
4. 显示表 departments 的结构，并查询其中的全部数据
DESC departments
select * from departments
5. 显示出表 employees 中的全部 job_id（不能重复）
SELECT distinct job_id from employees
6. 显示出表 employees 的全部列，各个列之间用逗号连接，列头显示成 OUT_PUT
desc employees
select * from employees
select concat(employee_id,',',first_name,',',last_name,','+email,',',phone_number,',',job_id
,',',salary,',',IFNULL(commission_pct,'null'),',',IFNULL(manager_id,'null'),',',department_id,',',hiredate) OUT_PUT 
FROM employees

测 试  二
1. 查询员工的姓名和部门号和年薪，按年薪降序 按姓名升序
desc employees
select CONCAT(first_name,'_',last_name) name , department_id, salary*12 as Annual_salary
from employees
order BY 
Annual_salary DESC, name ASC

2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序
SELECT CONCAT(first_name,'_',last_name) name, salary
FROM employees
WHERE salary not BETWEEN 8000 and 17000
ORDER BY salary DESC

3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT *, LENGTH(email) el from employees
where email LIKE '%e%'
ORDER BY el DESC, department_id ASC



#进阶4：常见函数
概念：类似于java的方法，将一组逻辑语句封装在方法体中，对外暴露方法名
好处：1、隐藏了实现细节  2、提高代码的重用性
调用：select 函数名(实参列表) 【from 表】;
特点：
	①叫什么（函数名）
	②干什么（函数功能）

分类：
	1、单行函数
	如 concat、length、ifnull等
	2、分组函数
	
	功能：做统计使用，又称为统计函数、聚合函数、组函数
	
常见函数：
	一、单行函数

	字符函数：
	length:获取字节个数(utf-8一个汉字代表3个字节,gbk为2个字节)
SELECT LENGTH('hello world') -- 11
select LENGTH('你好 世界') -- 13
	concat  拼接函数
SELECT CONCAT('a'	,'b','c') -- abc
select CONCAT('a',1.1) -- a1.1
SELECT CONCAT('a',NULL) -- NULL
	substr  字符串截断 从1开始数
SELECT SUBSTR('abcde',2) -- bcde
SELECT SUBSTR('abcde',2, 2) -- bc 从b开始, 往后截取两个
#案例：姓名中首字符大写，其他字符小写然后用_拼接，显示出来
DESC employees
SELECT CONCAT(UPPER(SUBSTR(first_name,1,1)), LOWER(SUBSTR(first_name,2)), '_', UPPER(SUBSTR(last_name,1,1)), LOWER(SUBSTR(last_name,2))) NAME
from employees
	instr  类型java中的indexOf  返回第一次出现的索引(从1开始), 没有返回0
SELECT INSTR('aabbxccdd','a') -- 1
SELECT INSTR('aabbxccdd','x') -- 5
SELECT INSTR('aabbxccdd','z') -- 0
SELECT INSTR('aabbxccdd','cd') -- 7
	trim	去除左右两边空格, 也可去除左右两边特定的值
SELECT TRIM('   aa   ')
SELECT TRIM('x' from 'xxxaaxxxx') -- aa
SELECT TRIM('ab' from 'abababahhhhhhhhababab') -- ahhhhhhhh
	upper  字符转大写
SELECT UPPER('afaSAFasdf') -- AFASAFASDF
	lower  字符转小写
SELECT LOWER('afaSAFasdf') -- afasafasdf
#示例：将姓变大写，名变小写，然后拼接
SELECT CONCAT(UPPER(last_name), '_', LOWER(first_name)) NAME from employees
	lpad 左填充至指定长度, 设定长度不足会截取
SELECT LPAD('cp2zj', 10, '*') -- *****cp2zj
SELECT LPAD('cp2zj', 2, '*') -- cp
	rpad 右填充至指定长度, 设定长度不足会截取
SELECT RPAD('cp2zj', 10, '*') -- cp2zj*****
SELECT RPAD('cp2zj', 2, '*') -- cp
	replace 替换(全部替换)
SELECT REPLACE('asdfcpscpcpcadfa', 'cp', 'zj') -- asdfzjszjzjcadfa
	
	数学函数：
	round  四舍五入 默认取整
SELECT ROUND(12.49) -- 12
SELECT ROUND(12.5) -- 13
SELECT ROUND(12.49, 1) -- 12.5
SELECT ROUND(12.495, 2) -- 12.5
	ceil(天花板) 向上取整
SELECT CEIL(11.1) -- 12
	floor(地板)
SELECT FLOOR(11.7) -- 11
	truncate 截断
SELECT TRUNCATE(12.666, 0) -- 12
SELECT TRUNCATE(12.666, -1) -- 10
SELECT TRUNCATE(12.666, 2) -- 12.66
	mod 取余 余数的正负值和被除数相同   mod(a,b) ：  a-a/b*b   mod(-10,-3):-10- (-10)/(-3)*（-3）=-1
SELECT MOD(13, 3) -- 1
SELECT MOD(13, -3) -- 1
SELECT MOD(-13, 3) -- -1
SELECT MOD(-13, -3) -- -1
  rand 取随机数(0~1之间)
SELECT RAND();
	
	日期函数：
	now
select now() now
	curdate
select CURDATE() -- 当前日期
	curtime
select CURTIME() -- 当前时间
	year
SELECT YEAR('2018-08-08')
SELECT YEAR(now())
	month
	monthname
SELECT MONTHNAME(now())
	day
	hour
	minute
	second
%Y：代表4位的年份 
%y：代表2为的年份

%m：代表月, 格式为(01……12) 
%c：代表月, 格式为(1……12)

%d：代表月份中的天数,格式为(00……31) 
%e：代表月份中的天数, 格式为(0……31)

%H：代表小时,格式为(00……23) 
%k：代表 小时,格式为(0……23) 
%h： 代表小时,格式为(01……12) 
%I： 代表小时,格式为(01……12) 
%l ：代表小时,格式为(1……12)

%i： 代表分钟, 格式为(00……59) 【只有这一个代表分钟，大写的I 不代表分钟代表小时】

%r：代表 时间,格式为12 小时(hh:mm:ss [AP]M) 
%T：代表 时间,格式为24 小时(hh:mm:ss)

%S：代表 秒,格式为(00……59) 
%s：代表 秒,格式为(00……59)
	str_to_date
select STR_TO_DATE('2018-08-08', '%Y-%m-%d')
select STR_TO_DATE('19-7-8','%y-%c-%e')
	date_format
SELECT DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s')
SELECT DATE_FORMAT(now(),'%Y-%m-%d %T')
select DATEDIFF(NOW(),'1992-12-15')

	其他函数：
	version
SELECT VERSION()
	database
SELECT DATABASE()
	user
SELECT USER()

	控制函数
select * from employees
	if
SELECT IF(1+1>2, '这是真的', '不可能')
SELECT IF(ISNULL(commission_pct), '没有奖金,呵呵', '有奖金,嘿嘿') from employees
	case (CASE WHEN THEN ELSE END)
/*案例：查询员工的工资，要求
部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=50，显示的工资为1.3倍
其他部门，显示的工资为原工资*/
select CONCAT(first_name,'_',last_name) name, salary, department_id, 
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END new_salary
from employees
/*#案例：查询员工的工资的情况
如果工资>20000,显示A级别
如果工资>15000,显示B级别
如果工资>10000，显示C级别
否则，显示D级别*/
SELECT CONCAT(first_name,'_',last_name) name, salary, 
(CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D' 
END) salary_level
FROM employees



测 试
1. 显示系统时间(注：日期+时间)
SELECT NOW()
2. 查询员工号，姓名，工资，以及工资提高百分之 20%后的结果（new salary）
DESC employees
select employee_id, CONCAT(first_name,'_',last_name) name, salary, salary*1.2 'new salary' from employees
3. 将员工的姓名按首字母排序，并写出姓名的长度（length）
select CONCAT(first_name,'_',last_name) name, LENGTH(CONCAT(first_name,'_',last_name)) from employees ORDER BY name 
4. 做一个查询，产生下面的结果
<last_name> earns <salary> monthly but wants <salary*3>
Dream Salary
King earns 24000 monthly but wants 72000
SELECT CONCAT(last_name,' earns ', salary, ' monthly but wants ', salary*3) 'Dream Salary' from employees
5. 使用 case-when，按照下面的条件：
job grade
AD_PRES A
ST_MAN B
IT_PROG C
SA_REP D
ST_CLERK E
产生下面的结果
Last_name Job_id Grade
king AD_PRES A
select * from employees

select last_name, job_id, 
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_REP' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
ELSE 'O' END 'job grade'
from employees

select last_name, job_id, 
CASE
WHEN job_id='AD_PRES' THEN 'A'
WHEN job_id='ST_MAN' THEN 'B'
WHEN job_id='IT_PROG' THEN 'C'
WHEN job_id='SA_REP' THEN 'D'
WHEN job_id='ST_CLERK' THEN 'E'
ELSE 'O' END 'job grade'
from employees





