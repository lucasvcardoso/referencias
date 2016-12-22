SELECT ReportID_PK, ReportName, LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) AS SName
FROM
(
SELECT ReportID_PK, ReportName, CAST('<XMLRoot><RowData>' + REPLACE(SPName,',','</RowData><RowData>') + '</RowData></XMLRoot>' AS XML) AS x
FROM   RP_ReportList WHERE ReportID_PK in (192,196)
)t
CROSS APPLY x.nodes('/XMLRoot/RowData')m(n)
