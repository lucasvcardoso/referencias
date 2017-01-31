DECLARE @String VARCHAR(12) = '@iAccountID='

SELECT TOP 10
		SPExecCommand,
		CHARINDEX(@String, SPExecCommand),
		REPLACE(SUBSTRING(SPExecCommand, CHARINDEX(@String, SPExecCommand) + 12, 3), ',', '')
  FROM
		dbo.GBL_ReportRequests_Log WITH(NOLOCK)
 WHERE
		SPExecCommand LIKE '%' + @String + '%'

	SET @String = '@AccountID='

SELECT TOP 10
		SPExecCommand,
		CHARINDEX(@String, SPExecCommand),
		REPLACE(SUBSTRING(SPExecCommand, CHARINDEX(@String, SPExecCommand) + 11, 3), ',', '')
  FROM
		dbo.GBL_ReportRequests_Log WITH(NOLOCK)
 WHERE
		SPExecCommand LIKE '%' + @String + '%'
