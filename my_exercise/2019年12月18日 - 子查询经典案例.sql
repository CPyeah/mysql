# 1. 查询工资最低的员工信息: last_name, salary
SELECT MIN(salary) from employees
SELECT last_name, salary from employees
WHERE salary = (SELECT MIN(salary) from employees)

# 2. 查询平均工资最低的部门信息
SELECT AVG(salary), department_id FROM employees GROUP BY department_id

SELECT MIN(t.avg_sal) min_sal
FROM (SELECT AVG(salary) avg_sal, department_id FROM employees GROUP BY department_id) t

SELECT department_id FROM employees GROUP BY department_id
HAVING  AVG(salary) = (SELECT MIN(t.avg_sal) min_sal
FROM (SELECT AVG(salary) avg_sal, department_id FROM employees GROUP BY department_id) t)

SELECT * from departments WHERE department_id in
(SELECT department_id FROM employees GROUP BY department_id
HAVING  AVG(salary) = (SELECT MIN(t.avg_sal) min_sal
FROM (SELECT AVG(salary) avg_sal, department_id FROM employees GROUP BY department_id) t) )

SELECT d.*
FROM departments d
WHERE d.`department_id`=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary)=(
		SELECT MIN(ag)
		FROM (
			SELECT AVG(salary) ag,department_id
			FROM employees
			GROUP BY department_id
		) ag_dep

	)
);

SELECT *
FROM departments
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);

# 3. 查询平均工资最低的部门信息和该部门的平均工资
SELECT
	d.*, (SELECT AVG(e.salary) FROM employees e WHERE e.department_id = d.department_id) avg_salary
FROM
	departments d
WHERE
	department_id = (
		SELECT
			department_id
		FROM
			employees
		GROUP BY
			department_id
		HAVING
			AVG(salary) = (
				SELECT
					MIN(t.avg_sal) min_sal
				FROM
					(
						SELECT
							AVG(salary) avg_sal,
							department_id
						FROM
							employees
						GROUP BY
							department_id
					) t
			)
	)

# 4. 查询平均工资最高的 job 信息
SELECT job_id, AVG(salary) s from employees GROUP BY job_id ORDER BY s DESC LIMIT 1

SELECT * from jobs j JOIN (SELECT job_id, AVG(salary) s from employees GROUP BY job_id ORDER BY s DESC LIMIT 1) t
ON j.job_id = t.job_id

# 5. 查询平均工资高于公司平均工资的部门有哪些?
SELECT department_id, AVG(salary) da FROM employees GROUP BY department_id

SELECT AVG(salary) ca FROM employees

SELECT department_id, AVG(salary) da FROM employees GROUP BY department_id
HAVING da > (SELECT AVG(salary) ca FROM employees)

SELECT * FROM departments d RIGHT JOIN
(SELECT department_id, AVG(salary) da FROM employees GROUP BY department_id
HAVING da > (SELECT AVG(salary) ca FROM employees) ) t
ON d.department_id = t.department_id

# 6. 查询出公司中所有 manager 的详细信息.
SELECT DISTINCT manager_id from employees

SELECT * from employees WHERE employee_id in (SELECT DISTINCT manager_id from employees)

# 7. 各个部门中 最高工资中最低的那个部门的 最低工资是多少
SELECT department_id FROM employees GROUP BY department_id ORDER BY MAX(salary) LIMIT 1

SELECT MIN(salary), department_id FROM employees WHERE department_id =
(SELECT department_id FROM employees GROUP BY department_id ORDER BY MAX(salary) LIMIT 1)



# 8. 查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1

SELECT DISTINCT manager_id FROM  employees WHERE department_id =
(SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1)

SELECT last_name, department_id, email, salary FROM employees WHERE employee_id in
(SELECT DISTINCT manager_id FROM  employees WHERE department_id =
(SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1))





