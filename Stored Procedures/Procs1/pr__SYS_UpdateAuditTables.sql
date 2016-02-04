

CREATE PROC [dbo].[pr__SYS_UpdateAuditTables]
	@sTableName varchar(128)
	,@bExecute bit
	,@bAuditEff bit
AS

/***************************************
exec pr__sys_updateaudittables 'schematest',1,0
****************************************/

DECLARE	@sProcText varchar(8000)
	,@sKeyFields varchar(2000)
	,@sColumnName varchar(128)
	,@nColumnID smallint
	,@bPrimaryKeyColumn bit
	,@nAlternateType int
	,@nColumnLength int
	,@nColumnPrecision int
	,@nColumnScale int
	,@IsNullable bit
	,@IsIdentity int
	,@sTypeName varchar(128)
	,@sDefaultValue varchar(4000)
	,@sCRLF char(2)
	,@sTAB char(1)
	--,@sAllFields varchar(8000)
	,@sAllValues varchar(2000)
	,@sAuditTableName varchar(128)


SET	@sTAB = char(9)
SET @sCRLF = char(13) + char(10)
SET @sAuditTableName  = @sTableName + 'Audit'
if @bAuditEff = 1
	set @sAuditTableName = @sAuditTableName + 'Eff'
	
SET @sProcText = ''
SET @sKeyFields = ''

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET @sProcText = ''

DECLARE crKeyFields cursor for
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
	and c.name not in 
		(
			'CreateIP' 
			,'CreateUser'
			,'CreateDate' 
			,'CreateMachine'
			,'CreateMac'
			,'LUPIP' 
			,'LUPUser'
			,'LUPDate'
			,'LUPMachine'
			,'LUPMac'
			,'EffectiveCreateUser' 
			,'EffectiveCreateDate'
			,'EffectiveLUPUser'
			,'EffectiveLUPDate' 
		)
	ORDER BY colOrder

OPEN crKeyFields


FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
	Begin
	
	set @sProcText = 'if not exists (select * from syscolumns where id = object_id(''' 
	+ @sAuditTableName + ''') and name = ''' + @sColumnName + ''') 
	alter table ' + @sAuditTableName + ' add ' + @sColumnName + ' ' + @sTypeName

	If @sTypeName not in 
		(
			'datetime' 
			,'int' 
			,'bit' 
			,'smallint'
			,'tinyint' 
			,'smalldatetime' 
			,'image' 
			,'text' 
			,'bigint'
		)
		Begin 
		If @sTypeName = 'decimal'
			Begin 
				SET @sProcText = @sProcText + '(' + CONVERT(varchar(5), @nColumnPrecision) + ',' + CONVERT(varchar(5), @nColumnScale) + ')'
			End
		Else
			Begin
			If (@sTypeName = 'varchar' 
				Or @sTypeName = 'varbinary')
			and @nColumnLength = -1
				Begin
				SET @sProcText = @sProcText + '(max)'
				End
			Else
				Begin
				SET @sProcText = @sProcText + '(' + CONVERT(varchar(5), @nColumnLength) + ')'
				End
			End
		End
	--If @sTypeName = 'varchar'
	--	Begin
	--	SET @sProcText = @sProcText + ' COLLATE SQL_Latin1_General_CP1_CI_AS NULL'
	--	End
	--Else
	--	Begin
		If @IsNullable = 1 
		or @sDefaultValue is null
			Begin
			SET @sProcText = @sProcText + ' NULL'
			End
		Else
			Begin
			SET @sProcText = @sProcText + ' NOT NULL'
			End
		--End
		
	if @sDefaultValue is not null
		begin
		set @sProcText = @sProcText + ' default ' + @sDefaultValue
		end

	print @sProcText
	
	if @bExecute = 1
		exec (@sProcText)

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
	END
CLOSE crKeyFields
DEALLOCATE crKeyFields


