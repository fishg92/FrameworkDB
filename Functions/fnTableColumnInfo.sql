CREATE       FUNCTION [dbo].[fnTableColumnInfo](@sTableName varchar(128))
RETURNS @return table
	(
		sColumnName sysname
		,nColumnID smallint
		,bPrimaryKeyColumn bit
		,nAlternateType int
		,nColumnLength smallint
		,nColumnPrecision smallint
		,nColumnScale int
		,IsNullable int
		,IsIdentity int
		,sTypeName sysname
		,sDefaultValue varchar(4000)
	)
AS
begin
	insert @return
	SELECT	c.name AS sColumnName,
		c.colid AS nColumnID,
		dbo.fnIsColumnPrimaryKey(@sTableName, c.name) AS bPrimaryKeyColumn,
		CASE 	WHEN t.name IN ('char', 'varchar', 'binary', 'varbinary', 'nchar', 'nvarchar') THEN 1
			WHEN t.name IN ('decimal', 'numeric') THEN 2
			ELSE 0
		END AS nAlternateType,
		c.length AS nColumnLength,
		c.prec AS nColumnPrecision,
		c.scale AS nColumnScale, 
		c.IsNullable, 
		SIGN(c.status & 128) AS IsIdentity,
		t.name as sTypeName,
		dbo.fnColumnDefault(@sTableName, c.name) AS sDefaultValue
	FROM	syscolumns c 
		INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
	WHERE	c.id = OBJECT_ID(@sTableName)

	return
end