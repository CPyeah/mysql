#一、查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有，用null填充
SELECT
	*
FROM
	boys bo
RIGHT JOIN beauty b ON bo.id = b.boyfriend_id
WHERE
	b.id > 3

#二、查询哪个城市没有部门
select * from departments
select * from locations
SELECT
	l.city
FROM
	locations l
LEFT JOIN departments d ON l.location_id = d.location_id
WHERE
	department_id IS NULL

#三、查询部门名为SAL或IT的员工信息
SELECT
	e.*, d.department_name
FROM
	employees e
JOIN departments d ON e.department_id = d.department_id
WHERE
	d.department_name = 'sal'
OR d.department_name = 'it'
