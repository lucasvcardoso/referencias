--Option 1
SELECT DISTINCT so.name
FROM syscomments sc
INNER JOIN sysobjects so on sc.id=so.id
WHERE sc.text LIKE '%object_name%'

--Option 2
SELECT TOP 1 *
FROM sys.objects
WHERE type = 'P' 
and name like '%object_name%' 
