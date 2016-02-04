
CREATE PROC [dbo].[usprefActivityTypeSelect]

AS

SELECT	pkrefActivityType, fkNCPApplication, Description, Data1ColumnName, Data2ColumnName, Data3ColumnName, Data4ColumnName, Data5ColumnName, Data6ColumnName, Data7ColumnName, Data8ColumnName, Data9ColumnName, Data10ColumnName, DecimalData1ColumnName, DecimalData2ColumnName, DecimalData3ColumnName, DecimalData4ColumnName, DecimalData5ColumnName, DecimalData6ColumnName, DecimalData7ColumnName, DecimalData8ColumnName, DecimalData9ColumnName, DecimalData10ColumnName, BitData1ColumnName, BitData2ColumnName, BitData3ColumnName, BitData4ColumnName, BitData5ColumnName, DateData1ColumnName, DateData2ColumnName, DateData3ColumnName, DateData4ColumnName, DateData5ColumnName
FROM	dbo.refActivityType
	

