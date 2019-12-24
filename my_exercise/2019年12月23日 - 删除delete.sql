#三、删除语句
/*
方式一：delete
语法：
1、单表的删除【★】
delete from 表名 where 筛选条件
2、多表的删除【补充】
sql92语法：
delete 表1的别名,表2的别名
from 表1 别名,表2 别名
where 连接条件
and 筛选条件;

sql99语法：
delete 表1的别名,表2的别名
from 表1 别名
inner|left|right join 表2 别名 on 连接条件
where 筛选条件;

方式二：truncate
语法：truncate table 表名;
*/

SELECT * from beauty
SELECT * FROM boys
#方式一：delete
#1.单表的删除
#案例：删除手机号以9结尾的女神信息
DELETE FROM beauty WHERE phone LIKE '%9'

#2.多表的删除
#案例：删除张无忌的女朋友的信息
DELETE beauty FROM beauty JOIN boys ON beauty.boyfriend_id = boys.id
WHERE boys.boyName = '张无忌'

#案例：删除黄晓明的信息以及他女朋友的信息
DELETE beauty, boys FROM beauty JOIN boys ON beauty.boyfriend_id = boys.id
WHERE boys.boyName = '黄晓明'

#方式二：truncate语句
#案例：将魅力值>100的男神信息删除
truncate TABLE boys

/*
1.delete 可以加where 条件，truncate不能加
2.truncate删除，效率高一丢丢
3.假如要删除的表中有自增长列，
如果用delete删除后，再插入数据，自增长列的值从断点开始，
而truncate删除后，再插入数据，自增长列的值从1开始。
4.truncate删除没有返回值，delete删除有返回值
5.truncate删除不能回滚，delete删除可以回滚.
*/

SELECT * FROM boys;

DELETE FROM boys;
TRUNCATE TABLE boys;
INSERT INTO boys (boyname,usercp)
VALUES('张飞',100),('刘备',100),('关云长',100);





