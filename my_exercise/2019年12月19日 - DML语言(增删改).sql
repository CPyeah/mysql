#DML语言
/*
数据操作语言：
插入：insert
修改：update
删除：delete

*/

#一、插入语句
#方式一：经典的插入
/*
语法：
insert into 表名(列名,...) values(值1,...);

*/
SELECT * FROM beauty;
#1.插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES ('张艺馨', '女', '1998-07-27', '18896544425', NULL, 0);

#2.不可以为null的列必须插入值。可以为null的列如何插入值？
#方式一：
INSERT INTO beauty(NAME,sex,borndate,phone)
VALUES ('张歆艺', '女', '1998-08-20', '18226633363');
#方式二：

#3.列的顺序是否可以调换(可以)
INSERT INTO beauty (sex, name, phone)
VALUES ('女', '张雨欣', '18272739382');

#4.列数和值的个数必须一致([Err] 1136 - Column count doesn''t match value count at row 1)
INSERT INTO beauty (sex, name, phone, boyfriend_id)
VALUES ('女', '张雨欣', '18272739382');

#5.可以省略列名，默认所有列，而且列的顺序和表中列的顺序一致
INSERT INTO beauty VALUES (NULL, '张馨予', '女', '1987-02-14', '19292933945', NULL, NULL);



#方式二：
/*

语法：
insert into 表名
set 列名=值,列名=值,...
*/

#两种方式大pk ★


#1、方式一支持插入多行,方式二不支持
#2、方式一支持子查询，方式二不支持









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


#1.修改单表的记录
#案例1：修改beauty表中姓唐的女神的电话为13899888899

#案例2：修改boys表中id好为2的名称为张飞，魅力值 10

#2.修改多表的记录

#案例 1：修改张无忌的女朋友的手机号为114

#案例2：修改没有男朋友的女神的男朋友编号都为2号

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

#方式一：delete
#1.单表的删除
#案例：删除手机号以9结尾的女神信息

#2.多表的删除

#案例：删除张无忌的女朋友的信息
#案例：删除黄晓明的信息以及他女朋友的信息

#方式二：truncate语句

#案例：将魅力值>100的男神信息删除

#delete pk truncate【面试题★】

/*

1.delete 可以加where 条件，truncate不能加

2.truncate删除，效率高一丢丢
3.假如要删除的表中有自增长列，
如果用delete删除后，再插入数据，自增长列的值从断点开始，
而truncate删除后，再插入数据，自增长列的值从1开始。
4.truncate删除没有返回值，delete删除有返回值

5.truncate删除不能回滚，delete删除可以回滚.

*/




