declare @temp as table (ct int, id int, date_time datetime)

insert into @temp
select count(date_time) ct, id, date_time
from logins 
inner join users 
	on logins.User_id = users.id 
group by users.id, logins.date_time

select 
distinct convert(varchar,datepart(dd,  logins.date_time)) 
+ '/' +convert(varchar,datepart(mm,  logins.date_time)) 
+ '/' +convert(varchar,datepart(yyyy,logins.date_time)) as data
, users.name 
, case
	when t.ct is null
		then 0
	else t.ct
 end counting
from logins
cross join Users
left join @temp t 
		on users.id = t.id 
		and logins.date_time = t.date_time

Esta é a query para produzir este relatório:
data              name             counting
----------------- ---------------- -----------
2/2/2018          Danielle         1
2/2/2018          Hanna            0
2/2/2018          Lucas            2
2/2/2018          Thomas           0
3/2/2018          Danielle         3
3/2/2018          Hanna            1
3/2/2018          Lucas            1
3/2/2018          Thomas           0
4/2/2018          Danielle         0
4/2/2018          Hanna            0
4/2/2018          Lucas            0
4/2/2018          Thomas           1

A partir destes dados:

--Logins
User_id     date_time
----------- -----------------------
1           2018-02-02 00:00:00.000
1           2018-02-03 00:00:00.000
2           2018-02-02 00:00:00.000
3           2018-02-04 00:00:00.000
1           2018-02-02 00:00:00.000
2           2018-02-03 00:00:00.000
2           2018-02-03 00:00:00.000
2           2018-02-03 00:00:00.000
4           2018-02-03 00:00:00.000


--Users
Id          Name
----------- --------------------------------------------------
1           Lucas
2           Danielle
3           Thomas
4           Hanna


