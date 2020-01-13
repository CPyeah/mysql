#存储过程和函数
/*
存储过程和函数：类似于java中的方法
好处：
1、提高代码的重用性
2、简化操作
*/
#存储过程
/*
含义：一组预先编译好的SQL语句的集合，理解成批处理语句
1、提高代码的重用性
2、简化操作
3、减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率
*/

#一、创建语法

CREATE PROCEDURE 存储过程名(参数列表)
BEGIN

	存储过程体（一组合法的SQL语句）
END

#注意：
/*
1、参数列表包含三部分
参数模式  参数名  参数类型
举例：
in stuname varchar(20)

参数模式：
in：该参数可以作为输入，也就是该参数需要调用方传入值
out：该参数可以作为输出，也就是该参数可以作为返回值
inout：该参数既可以作为输入又可以作为输出，也就是该参数既需要传入值，又可以返回值

2、如果存储过程体仅仅只有一句话，begin end可以省略
存储过程体中的每条sql语句的结尾要求必须加分号。
存储过程的结尾可以使用 delimiter 重新设置
语法：
delimiter 结束标记
案例：
delimiter $
*/


#二、调用语法

CALL 存储过程名(实参列表);

#--------------------------------案例演示-----------------------------------
#1.空参列表
#案例：插入到admin表中五条记录

SELECT * FROM admin;

delimiter $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username,`password`)
	VALUES('john1','0000'),('lily','0000'),('rose','0000'),('jack','0000'),('tom','0000');
END $
DELIMITER ;


#调用
CALL myp1();

#2.创建带in模式参数的存储过程

#案例1：创建存储过程实现 根据女神名，查询对应的男神信息
delimiter $
CREATE PROCEDURE myp2(IN beautyName VARCHAR(20))
BEGIN
	SELECT bo.*
	FROM boys bo
	RIGHT JOIN beauty b ON bo.id = b.boyfriend_id
	WHERE b.name=beautyName;
END $
DELIMITER ;

#调用
CALL myp2('柳岩');

#案例2 ：创建存储过程实现，用户是否登录成功
delimiter $
CREATE PROCEDURE myp4(IN username VARCHAR(20),IN PASSWORD VARCHAR(20))
BEGIN
	DECLARE result INT DEFAULT 0;#声明并初始化

	SELECT COUNT(*) INTO result#赋值
	FROM admin
	WHERE admin.username = username
	AND admin.password = PASSWORD;

	SELECT IF(result>0,'成功','失败');#使用
END $
DELIMITER ;

#调用
CALL myp3('张飞','8888');


#3.创建out 模式参数的存储过程
#案例1：根据输入的女神名，返回对应的男神名
delimiter $
CREATE PROCEDURE myp6(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20))
BEGIN
	SELECT bo.boyname INTO boyname
	FROM boys bo
	RIGHT JOIN
	beauty b ON b.boyfriend_id = bo.id
	WHERE b.name=beautyName ;

END $
DELIMITER ;
CALL myp6('小昭', @name);
SELECT @name;

#案例2：根据输入的女神名，返回对应的男神名和魅力值
delimiter $
CREATE PROCEDURE myp7(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20),OUT usercp INT)
BEGIN
	SELECT boys.boyname ,boys.usercp INTO boyname,usercp
	FROM boys
	RIGHT JOIN
	beauty b ON b.boyfriend_id = boys.id
	WHERE b.name=beautyName ;

END $
DELIMITER ;

#调用
CALL myp7('小昭',@name,@cp);
SELECT @name,@cp;



#4.创建带inout模式参数的存储过程
#案例1：传入a和b两个值，最终a和b都翻倍并返回
delimiter $
CREATE PROCEDURE myp8(INOUT a INT ,INOUT b INT)
BEGIN
	SET a=a*2;
	SET b=b*2;
END $
delimiter ;

#调用
SET @m=10;
SET @n=20;
CALL myp8(@m,@n);
SELECT @m,@n;


#三、删除存储过程
#语法：drop procedure 存储过程名
DROP PROCEDURE p1;
DROP PROCEDURE p2,p3;#×

#四、查看存储过程的信息
DESC myp2;×
SHOW CREATE PROCEDURE  myp2;




案例:
#一、创建存储过程实现传入用户名和密码，插入到admin表中
delimiter $
CREATE PROCEDURE login(IN username VARCHAR(20), IN password VARCHAR(20))
BEGIN
INSERT INTO admin VALUES (null, username, password);
END $
delimiter ;
CALL login('tom', '8888');
SELECT * FROM admin;

#二、创建存储过程实现传入女神编号，返回女神名称和女神电话
delimiter $
CREATE PROCEDURE get_girl(in girl_no INT, out girl_name VARCHAR(20), out phone VARCHAR(20))
BEGIN
	SELECT t.name, t.phone INTO girl_name, phone FROM beauty t WHERE t.id = girl_no;
END $
delimiter ;
CALL get_girl(5, @name, @phone);
SELECT @name, @phone;


#三、创建存储存储过程或函数实现传入两个女神生日，返回大小
delimiter $
CREATE PROCEDURE differ_date(in id1 INT, in id2 INT, OUT result VARCHAR(10))
BEGIN
	DECLARE b1 datetime;#声明并初始化
	declare b2 datetime;
	SELECT borndate INTO b1 FROM beauty WHERE id = id1;
	SELECT borndate INTO b2 FROM beauty WHERE id = id2;
	SELECT DATEDIFF(b1,b2) INTO result;

END $
delimiter ;
CALL differ_date(1, 5, @r);
SELECT @r;


#四、创建存储过程或函数实现传入一个日期，格式化成xx年xx月xx日并返回
delimiter $
CREATE PROCEDURE date_formater(in date datetime, OUT str_date VARCHAR(16))
BEGIN
	SELECT DATE_FORMAT(date,'%y年%m月%d日') INTO str_date;
END $
delimiter ;
CALL date_formater(NOW(), @str_date);
SELECT @str_date;


#五、创建存储过程或函数实现传入女神名称，返回：女神 and 男神  格式的字符串
如 传入 ：小昭
返回： 小昭 AND 张无忌
delimiter $
CREATE PROCEDURE cp(in girl_name VARCHAR(20), OUT cp_name VARCHAR(20))
BEGIN
	SELECT CONCAT(t.name,' AND ', b.boyName) INTO cp_name FROM beauty t JOIN boys b ON t.boyfriend_id = b.id
	WHERE t.name = girl_name;
END $
delimiter ;
CALL cp('小昭', @cp_name);
SELECT @cp_name;


#六、创建存储过程或函数，根据传入的条目数和起始索引，查询beauty表的记录
delimiter $
CREATE PROCEDURE select_beauty(IN startIndex INT,IN size INT)
BEGIN
	SELECT * FROM beauty LIMIT startIndex,size;
END $
delimiter ;
CALL select_beauty(3,5);










