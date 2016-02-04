



CREATE   PROC [dbo].[pr__SYS_MakeAuditTables]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

--Declare @sTableName varchar(128),
--		@bExecute bit 
--
--Set @sTableName = 'AgencyConfig'
--Set @bExecute = 0

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
	,@sAllFields varchar(8000)
	,@sAllValues varchar(2000)
	,@sAuditTableName varchar(128)

SET	@sTAB = char(9)
SET @sCRLF = char(13) + char(10)
SET @sAuditTableName  = @sTableName + 'Audit'

SET @sProcText = ''
SET @sKeyFields = ''

SET @sProcText = @sProcText + 'USE [CompassFramework]' + @sCRLF

SET @sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = '''  + @sAuditTableName +  ''')' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'DROP Table '  + @sAuditTableName  + @sCRLF
SET @sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET @sProcText = ''
SET @sProcText = @sProcText + 'SET ANSI_NULLS ON' + @sCRLF
--SET @sProcText = @sProcText + 'GO' + @sCRLF
SET @sProcText = @sProcText + 'SET QUOTED_IDENTIFIER ON' + @sCRLF
--SET @sProcText = @sProcText + 'GO' + @sCRLF
SET @sProcText = @sProcText + 'SET ANSI_PADDING ON' + @sCRLF
-- @sProcText = @sProcText + 'GO' + @sCRLF

SET @sProcText = @sProcText + 'CREATE TABLE [dbo].[' + @sAuditTableName + '](' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '[pk] [decimal](18, 0) IDENTITY(1,1) NOT NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditStartDate] [datetime] NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditEndDate] [datetime] NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditUser] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditEffectiveUser] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditEffectiveDate] [datetime] NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditMac] [char](17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditIP] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditMachine] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', [AuditDeleted] [tinyint] NULL' + @sCRLF

SET @sAllFields = ''

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
	ORDER BY colOrder

OPEN crKeyFields


FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 Begin
	--do not include old columns, these will be deleted eventually

	If @sColumnName <> 'CreateIP' 
		And @sColumnName <> 'CreateUser'
		And @sColumnName <> 'CreateDate' 
		And @sColumnName <> 'CreateMachine'
		And @sColumnName <> 'CreateMac'
		And @sColumnName <> 'LUPIP' 
		And @sColumnName <> 'LUPUser'
		And @sColumnName <> 'LUPDate'
		And @sColumnName <> 'LUPMachine'
		And @sColumnName <> 'LUPMac'
		And @sColumnName <> 'EffectiveCreateUser' 
		And @sColumnName <> 'EffectiveCreateDate'
		And @sColumnName <> 'EffectiveLUPUser'
		And @sColumnName <> 'EffectiveLUPDate' 
	Begin

		SET @sAllFields = @sAllFields + @sTAB + ', [' + @sColumnName + ']' + ' [' + @sTypeName + ']'

		If @sTypeName <> 'datetime' And @sTypeName <> 'int' And @sTypeName <> 'bit' and @sTypeName <> 'smallint'
				And @sTypeName <> 'tinyint' And @sTypeName <> 'smalldatetime' And @sTypeName <> 'image' 
				And @sTypeName <> 'text' And @sTypeName <> 'bigint'
		Begin 
			If @sTypeName = 'decimal'
			Begin 
				SET @sAllFields = @sAllFields + '(' + CONVERT(varchar(5), @nColumnPrecision) + ',' + CONVERT(varchar(5), @nColumnScale) + ')'
			End Else Begin
				If (@sTypeName = 'varchar' 
					Or @sTypeName = 'varbinary')
				and @nColumnLength = -1
				Begin
					SET @sAllFields = @sAllFields + '(max)'
				End Else Begin
					SET @sAllFields = @sAllFields + '(' + CONVERT(varchar(5), @nColumnLength) + ')'
				End
			End
		End
		If @sTypeName = 'varchar'
		Begin
			SET @sAllFields = @sAllFields + ' COLLATE SQL_Latin1_General_CP1_CI_AS NULL'
		End Else Begin
			If @IsNullable = 1
				Begin
					SET @sAllFields = @sAllFields + ' NULL'
				End Else Begin
					SET @sAllFields = @sAllFields + ' NOT NULL'
			End
		End
		
		if @sDefaultValue is not null
			begin
			set @sAllFields = @sAllFields + ' default ' + @sDefaultValue
			end

		SET @sAllFields = @sAllFields + @sCRLF
	End

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END
CLOSE crKeyFields
DEALLOCATE crKeyFields

SET @sProcText = @sProcText + @sAllFields
SET @sProcText = @sProcText + 'CONSTRAINT [PK_' + @sAuditTableName + '] PRIMARY KEY NONCLUSTERED' + @sCRLF
SET @sProcText = @sProcText + '(' + @sCRLF + '[pk] ASC' + @sCRLF
SET @sProcText = @sProcText + ')WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]' + @sCRLF
SET @sProcText = @sProcText + ') ON [PRIMARY]' + @sCRLF
SET @sProcText = @sProcText + 'SET ANSI_PADDING OFF' + @sCRLF
If @bExecute = 0
	SET @sProcText = @sProcText + 'GO' + @sCRLF

SET @sProcText = @sProcText + 'If Exists(Select name From sys.indexes' + @sCRLF
SET @sProcText = @sProcText + '          where name = N' + '''' + 'idxPk' + @sAuditTableName + ''''+ ')' + @sCRLF
SET @sProcText = @sProcText + 'Drop Index idxPk' + @sAuditTableName + ' on '+ @sAuditTableName + @sCRLF
If @bExecute = 0
	SET @sProcText = @sProcText + 'GO' + @sCRLF
SET @sProcText = @sProcText + 'Create nonclustered index idxPk' + @sAuditTableName + @sCRLF
SET @sProcText = @sProcText + 'on '+ @sAuditTableName + '(pk' + @sTableName + ')'

Print @sProcText
IF @bExecute = 1 
	EXEC (@sProcText)
