#二、修改语句

/*

1.修改单表的记录★

语法：
update 表名
set 列=新值,列=新值,...
where 筛选条件;

2.修改多表的记录【补充】

语法：
sql92语法：
update 表1 别名,表2 别名
set 列=值,...
where 连接条件
and 筛选条件;

sql99语法：
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值,...
where 筛选条件;
*/
SELECT * FROM beauty
SELECT * FROM boys

#1.修改单表的记录
#案例1：修改beauty表中姓唐的女神的电话为13899888899
UPDATE beauty SET phone = '13899888889' WHERE `name` LIKE '苍%'
#案例2：修改boys表中id好为2的名称为张飞，魅力值 10
UPDATE boys SET boyName = '张飞', userCP = 10 WHERE id = 2

#2.修改多表的记录
#案例 1：修改张无忌的女朋友的手机号为114
UPDATE beauty SET phone = '114' WHERE boyfriend_id = (SELECT id FROM boys WHERE boyName = '张无忌')
UPDATE beauty JOIN boys ON beauty.boyfriend_id = boys.id SET phone = '115', userCp = 101 WHERE boys.boyName = '张无忌'

#案例2：修改没有男朋友的女神的男朋友编号都为2号
UPDATE beauty SET boyfriend_id = 2
WHERE boyfriend_id IS NULL OR boyfriend_id NOT in (SELECT id FROM boys)
UPDATE beauty SET boyfriend_id = NULL WHERE boyfriend_id = 2
UPDATE beauty LEFT JOIN boys ON beauty.boyfriend_id = boys.id
SET boyfriend_id = 2 WHERE boyfriend_id IS NULL






























