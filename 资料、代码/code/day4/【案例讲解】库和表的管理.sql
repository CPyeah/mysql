#1.	创建表dept1
NAME	NULL?	TYPE
id		INT(7)
NAME		VARCHAR(25)

DROP TABLE IF EXISTS dept1;
CREATE TABLE dept1 (
	id INT(8),
	name VARCHAR(25)
);
DESC dept1;

#2.	将表departments中的数据插入新表dept2中
SELECT department_id, department_name FROM departments
CREATE TABLE dept2 SELECT department_id, department_name FROM departments
SELECT * from dept2;

#3.	创建表emp5
NAME	NULL?	TYPE
id		INT(7)
First_name	VARCHAR (25)
Last_name	VARCHAR(25)
Dept_id		INT(7)

CREATE TABLE IF NOT EXISTS emp5 (
	id		INT(7),
	First_name	VARCHAR (25),
	Last_name	VARCHAR(25),
	Dept_id		INT(7)
);
DESC emp5;

#4.	将列Last_name的长度增加到50
ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);
DESC emp5;

#5.	根据表employees创建employees2
CREATE TABLE employees2 LIKE employees;
DESC employees2;

#6.	删除表emp5
DROP TABLE IF EXISTS emp5;
SHOW tables;

#7.	将表employees2重命名为emp5
ALTER TABLE employees2 RENAME TO emp5;
DESC emp5;

#8.在表emp5中添加新列test_column，并检查所作的操作
ALTER TABLE emp5 ADD COLUMN test_column VARCHAR(25);
DESC emp5;

#9.直接删除表emp5中的列 test_column
ALTER TABLE emp5 DROP COLUMN test_column;



