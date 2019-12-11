#二、外连接

 /*
 应用场景：用于查询一个表中有，另一个表没有的记录
 特点：
 1、外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表没有的记录
 2、左外连接，left join左边的是主表
    右外连接，right join右边的是主表
 3、左外和右外交换两个表的顺序，可以实现同样的效果
 4、全外连接=内连接的结果+表1中有但表2没有的+表2中有但表1没有的
 */
 #引入：查询男朋友 不在男神表的的女神名
SELECT * from beauty
SELECT * from boys
SELECT
	*
FROM
	beauty g
LEFT JOIN boys b ON g.boyfriend_id = b.id
WHERE
	b.id IS NOT NULL

SELECT
	b.*, GROUP_CONCAT(g.name)
FROM
	boys b
LEFT JOIN beauty g ON g.boyfriend_id = b.id
GROUP BY b.id

 #引入：查询男朋友 不在男神表的的女神名
SELECT * from beauty
SELECT * from boys
SELECT
	*
FROM
	beauty g
LEFT JOIN boys b ON g.boyfriend_id = b.id
WHERE
	b.id IS NOT NULL

SELECT
	b.*, GROUP_CONCAT(g.name)
FROM
	boys b
LEFT JOIN beauty g ON g.boyfriend_id = b.id
GROUP BY b.id

 #左外连接
 #案例1：查询哪个部门没有员工
 #左外
SELECT
	d.*, e.employee_id
FROM
	departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE
	e.employee_id IS NULL

 #右外
SELECT
	d.*, e.employee_id
FROM
	 employees e
RIGHT JOIN departments d ON d.department_id = e.department_id
WHERE
	e.employee_id IS NULL

 #全外(mysql不支持)
SELECT
	*
FROM
	beauty b
FULL JOIN boys bo ON b.boyfriend_id = bo.id

 #交叉连接(两表交集)
SELECT
	*
FROM
	beauty b
CROSS JOIN boys bo ON b.boyfriend_id = bo.id

 #sql92和 sql99pk
 /*
 功能：sql99支持的较多
 可读性：sql99实现连接条件和筛选条件的分离，可读性较高
 */