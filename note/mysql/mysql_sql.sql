mysql数据类型
（1字节8位）
数据类型        字节       范围（有符号）               范围（无符号）          用途 
TINYINT        1字节        (-128,127)                     (0,255)            小整数值 
SMALLINT       2字节    	(-32 768,32 767)               (0,65 535)         大整数值 
MEDIUMINT      3字节    	(-8 388 608,8 388 607)         (0,16 777 215)     大整数值 
INT			   4字节   		(-2 147 483 648,2 147 483 647) (0,4 294 967 295)  大整数值 
BIGINT         8字节   		(-9 233 372 036 854 775 808,9 223 372 036 854 775 807) (0,18 446 744 073 709 551 615) 极大整数值 

FLOAT          4字节   		(-3.402 823 466 E+38,1.175 494 351 E-38),0,(1.175 494 351 E-38,3.402 823 466 351 E+38) 0,(1.175 494 351 E-38,3.402 823 466 E+38) 单精度浮点数值 
DOUBLE         8字节 		(1.797 693 134 862 315 7 E+308,2.225 073 858 507 201 4 E-308),0,(2.225 073 858 507 201 4 E-308,1.797 693 134 862 315 7 E+308) 0,(2.225 073 858 507 201 4 E-308,1.797 693 134 862 315 7 E+308) 双精度浮点数值

CHAR[(M)]         255字符          		定长字符串 
VARCHAR(M)        65535字节          	变长字符串 
TINYBLOB          255字节        		二进制字符串 
TINYTEXT     	  255字节        		文本字符串 
BLOB[(M)]         65535字节      		二进制字符串
TEXT[(M)]         65535字节      		长文字符串 
MEDIUMBLOB   	  16 777 215字节 		二进制字符串
MEDIUMTEXT   	  16 777 215字节 		文本字符串
LOGNGBLOB    	  4 294 967 295字节 	二进制字符串
LONGTEXT     	  4 294 967 295字节 	文本字符串

VARBINARY(M) 	  65535字节				变长二进制字符串
BINARY(M)    	  255字节				定长二进制字符串

DATE       4  1000-01-01/9999-12-31 					YYYY-MM-DD     日期值 
TIME       3  '-838:59:59'/'838:59:59'  				HH:MM:SS    时间值或持续时间 
YEAR       1  1901/2155                 				YYYY         年份值 
DATETIME   8  1000-01-01 00:00:00/9999-12-31 23:59:59 	YYYY-MM-DD HH:MM:SS 混合日期和时间值 
TIMESTAMP  4  1970-01-01 00:00:00/2037 年某时 			YYYYMMDD HHMMSS 混合日期和时间值,时间戳


BIT[(M)]   M=(1,64)     
插入格式 

	b'101' 

查看格式 
	hex(column_name)   转成十六进制

ENUM('value1','value2',...)     A string object that can have only one value
SET('value1','value2',...)      A string object that can have zero or more values

--一行记录所有字符相加不大于65536,最大可存varchar(65532)

select * from mysql.proc        ---查看存储过程的信息
DROP PROCEDURE procedure_name   ---删除存储过程

---存储过程
---delimiter  设置结束符号

DELIMITER //  
CREATE PROCEDURE demo_in_parameter(IN p_in int)  
BEGIN   
SELECT p_in;   
SET p_in=2;   
SELECT p_in;   
END;   
//  
DELIMITER ;

DELIMITER //   
CREATE PROCEDURE proc1(OUT s int)  
BEGIN 
SELECT COUNT(*) INTO s FROM wdg_test;  
END 
//  
DELIMITER ;    


DELIMITER //   
CREATE PROCEDURE demo_inout_parameter(INOUT p_inout int)   
BEGIN 
SELECT p_inout;  
SET p_inout=2;  
SELECT p_inout;   
END;  
//   
DELIMITER ; 
 
执行存储过程
---执行结果:
SET @p_inout=1;  
CALL demo_inout_parameter(@p_inout) 


DELIMITER //  
CREATE PROCEDURE proc3()  
begin 
declare x1 varchar(5) default 'outer';     ----声明变量
begin 
declare x1 varchar(5) default 'inner';  
select x1;  
end;  
select x1;  
end;  
//  
DELIMITER ;

create procedure my_insert(in bg int,in en int)
begin
declare i int;
set i=1;
lp1: loop
insert into test.demo values(i);
set i=i+1;
if i>x then
leave lp1;
end if;
end loop;
end;
DELIMITER ;

DELIMITER // 
create procedure my_insert(in begin_num int,in end_num int)
begin
declare i int;
set i=begin_num;
while i<end_num
do
insert into test.demo values(i);
set i=i+1;
end while;
end;
DELIMITER ;

DELIMITER //
create procedure input_t(in table_n varchar(20))
begin
select table_n;
end;


执行计划
explain select * from test1 where id=1


prepare prod from "insert into example values(?,?)";	---创建预定义语句,可以使用 create table、delete、insert、replace、select、set、update、show
set @a='xxx'
set @b='yyy'
execute prod using @a,@b;								---使用预定义
deallocate prepare prod;								---释放预定义语句

					    
SET @c1 = "XYZ";
set @c2 ="abc";
SET @strsql = concat("select ",@c1," from t where column2=",@c2);           --实现拼接sql，之后再执行
PREPARE stmt FROM @strsql;
EXECUTE stmt;					    
					    
					    				    
create function func_name(arg1 int,arg2 varchar(10)...)
returns varchar(10)
begin
...
end

调用
select func_name(...) from ...




INSERT INTO table_name(column_1,column_2) VALUES(v1,v2);
INSERT INTO table_name(column_1,column_2) VALUES(v01,v02),(v11,v12);    ----only for mysql

---mysql特有
---与insert类似
---根据主键或者唯一索引判断。不存在,则插入；存在,则更新。
replace into table(id, update_time) values(1, now());   


选择表的特定几行
--MySQL
select * from table_name limit 2,5;  --从第3行开始选5行
select * from table_name limit 3;    --选择前3行


约束
ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE (column1,column2);
撤销约束
ALTER TABLE table_name DROP CONSTRAINT constraint_name;


更改表的字段
ALTER TABLE table_name MODIFY column_name data_type;



UDF (use defined function)
mysql.func

create function func_name return string "mysql_function.so";		---由创建的动态连接库添加mysql的function

####动态连接库创建
####mysql.h在$mysql_home/include/mysql下
####test_add.cpp

#include <mysql.h>
extern "C" long long testadd(UDF_INIT *initid,UDF_ARGS *args,char *is_null,char *error)
{
	int a=*((long long*)args->args[0]);
	int b=*((long long*)args->args[1]);
	return a+b;
}
extern "C" my_bool testadd_init(UDF_INIT *initid,UDF_ARGS *args,char *message)
{
	return 0;
}

###需要预先安装libmysqlclient-dev
##编译
g++ -shared -fPIC -l /usr/include/mysql -o test_add.so test_add.cpp   	###动态连接库的位置要确定
cp test_add.so /usr/lib/mysql/plugin   									####在mysql中使用【SHOW VARIABLES LIKE 'plugin_dir'; 】查看要复制到的位置

nm test_add.so		##可查看动态连接库中的函数

mysql中使用
create function testadd returns integer soname "test_add.so";
select testadd(1,2);


github.com/mysqludf


event
--用于定期执行sql语句
create event event_name ...




----空间占用查询
----所有数据的大小：
select concat(round(sum(data_length/1024/1024),2),'MB') as data from information_schema.tables;
----指定数据库的大小：
select concat(round(sum(data_length/1024/1024),2),'MB') as data from information_schema.tables where table_schema='schema_name';
----指定数据库各表的大小：
select TABLE_SCHEMA,TABLE_NAME,concat(round(sum(data_length/1024/1024/1024),2),'G') as data from information_schema.tables where TABLE_SCHEMA='schema_name' group by TABLE_NAME;



注释(comment)
查看

create table table_name(
name varchar comment '名字',
pid int comment '编号'
)


修改
alter table `table_name` modify column `name` varchar(20) comment `you comment`;




delimiter //
create trigger db_info_to_stats
BEFORE delete on db_info
for each row
begin
delete from stats where ip=old.master_private_ip;
end;
//


drop trigger db_info_update_stats;
delimiter //
create trigger db_info_update_stats
after update on db_info
for each row
begin
declare private_ip varchar(40);
declare my_cursor cursor for select manage_private_ip from cloud_info where cloud_id=new.cloud_id;
open my_cursor;
fetch my_cursor into private_ip;
close my_cursor;

replace into stats(
db_type
,project
,channel
,manage_host
,ip
,port
,max_connections
,comment)   
values(
new.db_type           
,new.project           
,new.sub_project       
,private_ip 
,new.master_private_ip 
,new.master_port                
,new.max_connections    
,new.hardware_info   
);
end;
//
delimiter ;


drop trigger db_info_insert_stats;
delimiter //
create trigger db_info_insert_stats
after insert on db_info
for each row
begin
declare private_ip varchar(40);
declare my_cursor cursor for select manage_private_ip from cloud_info where cloud_id=new.cloud_id;
open my_cursor;
fetch my_cursor into private_ip;
close my_cursor;

replace into stats(
db_type
,project
,channel
,manage_host
,ip
,port
,max_connections
,comment)   
values(
new.db_type           
,new.project           
,new.sub_project       
,private_ip 
,new.master_private_ip 
,new.master_port                
,new.max_connections    
,new.hardware_info   
);
end;
//
delimiter ;



自增虚拟列
select (@i:=@i+1) as v_id,tb_name.* from tb_name,(select @i:=0) vt

set global event_scheduler=on; 

CREATE EVENT myevent
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
UPDATE mytable SET mycol = mycol + 1;


CREATE FUNCTION f1(s CHAR(20))
RETURNS CHAR(50) DETERMINISTIC
RETURN CONCAT('Hello, ',s,'!');






#####################spider engin#############################################
create server backend1 
foreign data wrapper mysql 
options 
( host '192.168.4.165',port 3306,user 'root',password '',database 'test');

create server backend2 
foreign data wrapper mysql 
options 
( host '192.168.4.165',port 5634,user 'root',password '',database 'test');


CREATE TABLE `a` (
  `a` int(11) NOT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`a`)
)engine=spider comment='srv "backend1",wrapper "mysql",table "a"';



CREATE TABLE `a2` (
  `a` int(11) NOT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`a`)
)engine=spider comment='srv "backend2",wrapper "mysql",table "a"';

CREATE TABLE `aaa` (
  `a` int(11) NOT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`a`)
)engine=spider comment='wrapper "mysql",table "a"'
partition by list (mod(a,2))
(partition p0 values in (0) comment='srv "backend1"',
partition p1 values in (1) comment='srv "backend2"'
);




delimiter //
create procedure random_insert_max()
begin
declare i int;
set i=0;
while i<8000000 do
insert into index_test1(a,b,c,d,e) values(round(rand()*10000),round(rand()*10000),round(rand()*1000),round(rand()*10000),round(rand()*10000));
set i=i+1;
end while;
end

//
delimiter ;


