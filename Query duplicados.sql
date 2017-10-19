--Pra selecionar os duplicados
SELECT MIN(id), Nome FROM Clientes
GROUP BY Nome
HAVING COUNT(Nome) > 1

--Pra pegar os IDs dos duplicados
SELECT c.ID, c.Nome, c.Email FROM Clientes c
INNER JOIN (
              SELECT x.Nome, x.Email FROM Clientes x 
              GROUP BY x.Nome, x.Email 
              HAVING COUNT(Nome) > 1
            ) dt 
	ON c.Nome = dt.Nome AND c.Email = dt.Email
