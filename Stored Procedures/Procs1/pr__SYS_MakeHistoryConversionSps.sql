



Create       PROC [dbo].[pr__SYS_MakeHistoryConversionSps]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

DECLARE	@sProcText varchar(8000)
	,@sProcTextB varchar(8000)
	,@sProcTextC varchar(8000)
	,@sKeyFields varchar(2000)
	,@sTableColumns varchar(2000)
	,@sTableValues varchar(2000)
	,@sTableDeclares varchar(2000)
	,@sWhereClause varchar(2000)
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
	,@spPrefix varchar(10)
	,@sAllFields varchar(2000)
	,@sAllValues varchar(2000)
	,@sAuditTableName varchar(128)
	,@sEffTableName varchar(128)
	,@sHistTableName varchar(128)

Set @spPrefix = 'convert_'
SET	@sTAB = char(9)
SET @sCRLF = char(13) + char(10)
SET @sHistTableName  = @sTableName + 'Hist'
SET @sAuditTableName  = @sTableName + 'Audit'
SET @sEffTableName  = @sTableName + 'AuditEff'

SET @sProcText = ''
SET @sProcTextB = ''
SET @sProcTextC = ''
SET @sKeyFields = ''
SET	@sWhereClause = ''

SET @sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sHistTableName + '_HistStep1'')' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'DROP PROCEDURE ' + @spPrefix + @sHistTableName + '_HistStep1' + @sCRLF

SET @sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET @sProcText = ''
SET @sProcText = @sProcText + 'CREATE PROC ' + @spPrefix + @sHistTableName + '_HistStep1' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '@sTableName varchar(128)' + @sCRLF
SET @sProcText = @sProcText + 'As' + @sCRLF

SET @sTableColumns = ''
SET @sTableValues = ''
SET @STableDeclares = 'Declare @Dummy varchar(1)' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sHistTableName)

OPEN crKeyFields


FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN
	If @bPrimaryKeyColumn = 0
	Begin 

		If @sColumnName <> 'CreateIP' 
			And @sColumnName <> 'CreateUser'
			And @sColumnName <> 'CreateDate' 
			And @sColumnName <> 'CreateMachine'
			And @sColumnName <> 'CreateMac'
			And @sColumnName <> 'EffectiveCreateUser' 
			And @sColumnName <> 'EffectiveCreateDate'
			And @sColumnName <> 'Date_Lup' 
			And @sColumnName <> 'effectivedate_lup'
			And @sColumnName <> 'user_lup'
			And @sColumnName <> 'effectiveuser_lup'
			And @sColumnName <> 'ip_mac'
			And @sColumnName <> 'ip_lup'
			And @sColumnName <> 'machine_lup'
			And @sColumnName <> 'mac_lup'
			And @sColumnName <> 'mac_ip'

		Begin
			If @sColumnName <> 'LUPDate'
				And @sColumnName <> 'LUPUser'
				And @sColumnName <> 'LUPMac'
				And @sColumnName <> 'LUPIP' 
				And @sColumnName <> 'LUPMachine'
				And @sColumnName <> 'EffectiveLUPUser'
				And @sColumnName <> 'EffectiveLUPDate' 
			Begin
				If @sTypeName <> 'image'
				Begin
					SET @sTableColumns = @sTableColumns + @sTAB + ','
					
					SET @sTableColumns = @sTableColumns + '[' + @sColumnName + ']' + @sCRLF

					SET @sTableValues = @sTableValues + @sTAB +  ','

					SET @sTableValues = @sTableValues + '@' + @sColumnName + @sCRLF
				End
			End

			If  @sTypeName <> 'image' 
			Begin
				SET @sTableDeclares = @sTableDeclares + @sTAB + ', @' + @sColumnName + ' ' + @sTypeName 
				If @sTypeName <> 'datetime' And @sTypeName <> 'int' And @sTypeName <> 'bit' and @sTypeName <> 'smallint'
						And @sTypeName <> 'tinyint' And @sTypeName <> 'smalldatetime'
						And @sTypeName <> 'text' And @sTypeName <> 'bigint'
				Begin 
					If @sTypeName = 'decimal'
					Begin 
						SET @sTableDeclares = @sTableDeclares + '(' + CONVERT(varchar(5), @nColumnPrecision) + ',' + CONVERT(varchar(5), @nColumnScale) + ')'
					End Else Begin
						If @sTypeName = 'varchar' and @nColumnLength = -1
						Begin
							SET @sTableDeclares = @sTableDeclares + '(max)'
						End Else Begin
							SET @sTableDeclares = @sTableDeclares + '(' + CONVERT(varchar(5), @nColumnLength) + ')'
						End
					End
				End
				SET @sTableDeclares = @sTableDeclares + @sCRLF
			End
		End
	End

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END
CLOSE crKeyFields
DEALLOCATE crKeyFields

SET @sProcText = @sProcText +  @sTableDeclares
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'DECLARE crHistRecords cursor for' + @sCRLF
SET @sProcText = @sProcText + '	SELECT	' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ' LupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', LupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', EffectiveLupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', EffectiveLupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', LupMac' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', LupIP' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', LupMachine' + @sCRLF
SET @sProcText = @sProcText +  @sTableColumns 
SET @sProcText = @sProcText + 'FROM ' +  @sHistTableName + @sCRLF
SET @sProcText = @sProcText + 'ORDER BY pk' +  @sTableName + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', pk' +  @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'OPEN crHistRecords' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'FETCH 	NEXT ' + @sCRLF
SET @sProcText = @sProcText + 'FROM 	crHistRecords ' + @sCRLF
SET @sProcText = @sProcText + 'INTO ' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '@LupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupMac' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupIP' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcText = @sProcText +  @sTableValues + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'WHILE (@@FETCH_STATUS = 0)' + @sCRLF
SET @sProcText = @sProcText + 'Begin' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '--End date current audit record' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'Update ' +  @sAuditTableName + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + 'Set AuditEndDate = @LupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'Where AuditEndDate is null' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'And pk' + @sTableName +  ' = @pk' + @sTableName + @sCRLF
SET @sProcText = @sProcText + @sCRLF

SET @sAllFields = ''
SET @sAllValues = ''

SET @sProcText = @sProcText + @sTAB + '--create new audit record' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'Insert into ' +  @sAuditTableName + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + '(' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + 'AuditStartDate' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditEndDate' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditUser' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditEffectiveUser' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditEffectiveDate' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditMac' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditIP' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditMachine' + @sCRLF
SET @sAllFields = @sAllFields + @sTAB + ', AuditDeleted' + @sCRLF
SET @sAllFields = @sAllFields + @sTableColumns
SET @sAllFields = @sAllFields + @sTAB + ')' + @sCRLF
SET @sAllValues = @sTAB + 'Values (' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + '@LupDate' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', Null' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @LupUser' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @LupMac' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @LupIP' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', @LupMachine' + @sCRLF
SET @sAllValues = @sAllValues + @sTAB + ', 0' + @sCRLF
SET @sAllValues = @sAllValues + @sTableValues
SET @sAllValues = @sAllValues + @sTAB + ')'

SET @sProcText = @sProcText + @sAllFields
SET @sProcText = @sProcText + @sAllValues + @sCRLF

SET @sProcText = @sProcText + @sCRLF
SET @sProcText = @sProcText + '--if a backdated change, delete the old audit eff records' + @sCRLF
SET @sProcText = @sProcText + 'Delete from ' + @sEffTableName + @sCRLF
SET @sProcText = @sProcText + '	Where AuditEffStartDate >= @EffectiveLUPDate' + @sCRLF
SET @sProcText = @sProcText + '	And pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF

SET @sProcText = @sProcText + @sCRLF
SET @sProcText = @sProcText + '--Enddate current auditeffective record' + @sCRLF
SET @sProcText = @sProcText + 'Update ' + @sEffTableName + @sCRLF 
SET @sProcText = @sProcText + 'Set AuditEffEndDate = @EffectiveLUPDate' + @sCRLF
SET @sProcText = @sProcText + 'Where pk in' + @sCRLF
SET @sProcText = @sProcText + '	(' + @sCRLF
SET @sProcText = @sProcText + '	Select max(pk)' + @sCRLF
SET @sProcText = @sProcText + '	From ' + @sEffTableName + ' dbTable' + @sCRLF
SET @sProcText = @sProcText + '	Where dbTable.pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF
SET @sProcText = @sProcText + '	Group by dbTable.pk' + @sTableName  + @sCRLF
SET @sProcText = @sProcText + '	)' + @sCRLF

SET @sProcText = @sProcText + @sCRLF
SET @sProcText = @sProcText + '--create new audit effective record' + @sCRLF
SET @sProcText = @sProcText + 'Insert into ' + @sEffTableName + @sCRLF
SET @sProcText = @sProcText + @sTAB + '(' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'AuditEffStartDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditEffEndDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditEffUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditEffDeleted' + @sCRLF
SET @sProcText = @sProcText + @sTableColumns
SET @sProcText = @sProcText + '	)' 
SET @sProcText = @sProcText + @sTAB + 'Values (' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '@EffectiveLupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', Null' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', 0' + @sCRLF
SET @sProcText = @sProcText + @sTableValues
SET @sProcText = @sProcText + @sTAB + ')' + @sCRLF
SET @sProcText = @sProcText + @sCRLF

SET @sProcText = @sProcText + 'FETCH 	NEXT ' + @sCRLF
SET @sProcText = @sProcText + 'FROM 	crHistRecords ' + @sCRLF
SET @sProcText = @sProcText + 'INTO ' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '@LupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupMac' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupIP' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcText = @sProcText +  @sTableValues + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'END'  + @sCRLF
SET @sProcText = @sProcText + 'CLOSE crHistRecords'  + @sCRLF
SET @sProcText = @sProcText + 'DEALLOCATE crHistRecords'  + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)


--************************************************************************************
SET @sProcTextB = ''
SET @sProcTextB = @sProcTextB + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sHistTableName + '_HistStep2'')' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'DROP PROCEDURE ' + @spPrefix + @sHistTableName + '_HistStep2' + @sCRLF
PRINT @sProcTextB

IF @bExecute = 1 
	EXEC (@sProcTextB)

SET @sProcTextB = ''
SET @sProcTextB = @sProcTextB + 'CREATE PROC ' + @spPrefix + @sHistTableName + '_HistStep2' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '@sTableName varchar(128)' + @sCRLF
SET @sProcTextB = @sProcTextB + 'As' + @sCRLF
SET @sProcTextB = @sProcTextB + @sCRLF
SET @sProcTextB = @sProcTextB +  @sTableDeclares
SET @sProcTextB = @sProcTextB +  @sCRLF

SET @sProcTextB = @sProcTextB +  '--Create Audit records for base record ' + @sCRLF
SET @sProcTextB = @sProcTextB + 'DECLARE crBaseRecords cursor for' + @sCRLF
SET @sProcTextB = @sProcTextB + '	SELECT	' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ' LupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', LupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', EffectiveLupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', EffectiveLupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', LupMac' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', LupIP' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', LupMachine' + @sCRLF
SET @sProcTextB = @sProcTextB +  @sTableColumns 
SET @sProcTextB = @sProcTextB + 'FROM ' +  @sTableName + @sCRLF
SET @sProcTextB = @sProcTextB + 'Order by pk' +  @sTableName + @sCRLF
SET @sProcTextB = @sProcTextB +  @sCRLF

SET @sProcTextB = @sProcTextB + 'OPEN crBaseRecords' + @sCRLF
SET @sProcTextB = @sProcTextB +  @sCRLF

SET @sProcTextB = @sProcTextB + 'FETCH 	NEXT ' + @sCRLF
SET @sProcTextB = @sProcTextB + 'FROM 	crBaseRecords ' + @sCRLF
SET @sProcTextB = @sProcTextB + 'INTO ' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '@LupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextB = @sProcTextB +  @sTableValues + @sCRLF
SET @sProcTextB = @sProcTextB +  @sCRLF

SET @sProcTextB = @sProcTextB + 'WHILE (@@FETCH_STATUS = 0)' + @sCRLF
SET @sProcTextB = @sProcTextB + 'Begin' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '--End date current audit record' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'Update ' +  @sAuditTableName + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + @sTAB + 'Set AuditEndDate = @LupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'Where AuditEndDate is null' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'And pk' + @sTableName +  ' = @pk' + @sTableName + @sCRLF
SET @sProcTextB = @sProcTextB + @sCRLF

SET @sProcTextB = @sProcTextB + @sTAB + '--create new audit record' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB  + 'Insert into ' +  @sAuditTableName + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '(' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'AuditStartDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEndDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEffectiveUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEffectiveDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditMac' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditIP' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditMachine' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditDeleted' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTableColumns
SET @sProcTextB = @sProcTextB + @sTAB + ')' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB +'Values (' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '@LupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', Null' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', 0' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTableValues
SET @sProcTextB = @sProcTextB + @sTAB + ')' + @sCRLF
SET @sProcTextB = @sProcTextB + @sCRLF

SET @sProcTextB = @sProcTextB + @sCRLF
SET @sProcTextB = @sProcTextB + '--if a backdated change, delete the old audit eff records' + @sCRLF
SET @sProcTextB = @sProcTextB + 'Delete from ' + @sEffTableName + @sCRLF
SET @sProcTextB = @sProcTextB + '	Where AuditEffStartDate >= @EffectiveLUPDate' + @sCRLF
SET @sProcTextB = @sProcTextB + '	And pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF

SET @sProcTextB = @sProcTextB + @sCRLF
SET @sProcTextB = @sProcTextB + '--Enddate current auditeffective record' + @sCRLF
SET @sProcTextB = @sProcTextB + 'Update ' + @sEffTableName + @sCRLF 
SET @sProcTextB = @sProcTextB + 'Set AuditEffEndDate = @EffectiveLUPDate' + @sCRLF
SET @sProcTextB = @sProcTextB + 'Where pk in' + @sCRLF
SET @sProcTextB = @sProcTextB + '	(' + @sCRLF
SET @sProcTextB = @sProcTextB + '	Select max(pk)' + @sCRLF
SET @sProcTextB = @sProcTextB + '	From ' + @sEffTableName + ' dbTable' + @sCRLF
SET @sProcTextB = @sProcTextB + '	Where dbTable.pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF
SET @sProcTextB = @sProcTextB + '	Group by dbTable.pk' + @sTableName  + @sCRLF
SET @sProcTextB = @sProcTextB + '	)' + @sCRLF

SET @sProcTextB = @sProcTextB + @sCRLF
SET @sProcTextB = @sProcTextB + '--create new audit effective record' + @sCRLF
SET @sProcTextB = @sProcTextB + 'Insert into ' + @sEffTableName + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '(' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + 'AuditEffStartDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEffEndDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEffUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', AuditEffDeleted' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTableColumns
SET @sProcTextB = @sProcTextB + '	)' 
SET @sProcTextB = @sProcTextB + @sTAB + 'Values (' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '@EffectiveLupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', Null' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', 0' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTableValues
SET @sProcTextB = @sProcTextB + @sTAB + ')' + @sCRLF
SET @sProcTextB = @sProcTextB + @sCRLF

SET @sProcTextB = @sProcTextB + 'FETCH 	NEXT ' + @sCRLF
SET @sProcTextB = @sProcTextB + 'FROM 	crBaseRecords ' + @sCRLF
SET @sProcTextB = @sProcTextB + 'INTO ' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + '@LupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextB = @sProcTextB + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextB = @sProcTextB +  @sTableValues + @sCRLF
SET @sProcTextB = @sProcTextB +  @sCRLF

SET @sProcTextB = @sProcTextB + 'END'  + @sCRLF
SET @sProcTextB = @sProcTextB + 'CLOSE crBaseRecords'  + @sCRLF
SET @sProcTextB = @sProcTextB + 'DEALLOCATE crBaseRecords'  + @sCRLF
SET @sProcTextB = @sProcTextB +  @sCRLF

PRINT @sProcTextB

IF @bExecute = 1 
	EXEC (@sProcTextB)

--************************************************************************************
SET @sProcTextC = ''
SET @sProcTextC = @sProcTextC + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sHistTableName + '_HistStep3'')' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + 'DROP PROCEDURE ' + @spPrefix + @sHistTableName + '_HistStep3' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF
PRINT @sProcTextC

IF @bExecute = 1 
	EXEC (@sProcTextC)

SET @sProcTextC = ''

SET @sProcTextC = @sProcTextC + 'CREATE PROC ' + @spPrefix + @sHistTableName + '_HistStep3' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + '@sTableName varchar(128)' + @sCRLF
SET @sProcTextC = @sProcTextC + 'As' + @sCRLF
SET @sProcTextC = @sProcTextC + @sCRLF
SET @sProcTextC = @sProcTextC +  @sTableDeclares
SET @sProcTextC = @sProcTextC +  @sCRLF

SET @sProcTextC = @sProcTextC + '--Mark Deleted records' + @sCRLF
SET @sProcTextC = @sProcTextC + 'DECLARE crDeletedRecords cursor for' + @sCRLF
SET @sProcTextC = @sProcTextC + '	SELECT	' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ' Date_LUP' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', LupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', EffectiveLupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', EffectiveLupDate' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', LupMac' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', LupIP' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', LupMachine' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sTableColumns 
SET @sProcTextC = @sProcTextC + 'FROM ' +  @sHistTableName + ' a' + @sCRLF
SET @sProcTextC = @sProcTextC + 'WHERE pk' +  @sTableName + ' in' + @sCRLF
SET @sProcTextC = @sProcTextC +  '  (' + @sCRLF
SET @sProcTextC = @sProcTextC + '    SELECT a.pk' +  @sTableName + @sCRLF
SET @sProcTextC = @sProcTextC + '    FROM ' +  @sHistTableName + ' a' + @sCRLF
SET @sProcTextC = @sProcTextC + '    Left Join ' +  @sTableName + ' b' + ' on a.pk' + @sTableName + '= b.pk' + @sTableName + @sCRLF
SET @sProcTextC = @sProcTextC + '    Where b.pk' +  @sTableName + ' is Null' +  @sCRLF
SET @sProcTextC = @sProcTextC +  '   )' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF

SET @sProcTextC = @sProcTextC + 'OPEN crDeletedRecords' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF

SET @sProcTextC = @sProcTextC + 'FETCH 	NEXT ' + @sCRLF
SET @sProcTextC = @sProcTextC + 'FROM 	crDeletedRecords ' + @sCRLF
SET @sProcTextC = @sProcTextC + 'INTO ' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + '@LupDate' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sTableValues + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF

SET @sProcTextC = @sProcTextC + 'WHILE (@@FETCH_STATUS = 0)' + @sCRLF
SET @sProcTextC = @sProcTextC + 'Begin' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + '--End date current audit record' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + 'Update ' +  @sAuditTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + @sTAB + 'Set AuditEndDate = @LupDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + 'Where AuditEndDate is null' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + 'And pk' + @sTableName +  ' = @pk' + @sTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ @sCRLF

SET @sProcTextC= @sProcTextC+ @sTAB + '--create new audit record' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB  + 'Insert into ' +  @sAuditTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + '(' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + 'AuditStartDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEndDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEffectiveUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEffectiveDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditMac' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditIP' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditMachine' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditDeleted' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTableColumns
SET @sProcTextC= @sProcTextC+ @sTAB + ')' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB +'Values (' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + '@LupDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', Null' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', 0' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTableValues
SET @sProcTextC= @sProcTextC+ @sTAB + ')' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sCRLF

SET @sProcTextC= @sProcTextC+ @sCRLF
SET @sProcTextC= @sProcTextC+ '--if a backdated change, delete the old audit eff records' + @sCRLF
SET @sProcTextC= @sProcTextC+ 'Delete from ' + @sEffTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ '	Where AuditEffStartDate >= @EffectiveLUPDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ '	And pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF

SET @sProcTextC= @sProcTextC+ @sCRLF
SET @sProcTextC= @sProcTextC+ '--Enddate current auditeffective record' + @sCRLF
SET @sProcTextC= @sProcTextC+ 'Update ' + @sEffTableName + @sCRLF 
SET @sProcTextC= @sProcTextC+ 'Set AuditEffEndDate = @EffectiveLUPDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ 'Where pk in' + @sCRLF
SET @sProcTextC= @sProcTextC+ '	(' + @sCRLF
SET @sProcTextC= @sProcTextC+ '	Select max(pk)' + @sCRLF
SET @sProcTextC= @sProcTextC+ '	From ' + @sEffTableName + ' dbTable' + @sCRLF
SET @sProcTextC= @sProcTextC+ '	Where dbTable.pk' + @sTableName + ' = @pk' + @sTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ '	Group by dbTable.pk' + @sTableName  + @sCRLF
SET @sProcTextC= @sProcTextC+ '	)' + @sCRLF

SET @sProcTextC= @sProcTextC+ @sCRLF
SET @sProcTextC= @sProcTextC+ '--create new audit effective record' + @sCRLF
SET @sProcTextC= @sProcTextC+ 'Insert into ' + @sEffTableName + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + '(' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + 'AuditEffStartDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEffEndDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEffUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', AuditEffDeleted' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTableColumns
SET @sProcTextC= @sProcTextC+ '	)' 
SET @sProcTextC= @sProcTextC+ @sTAB + 'Values (' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + '@EffectiveLupDate' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', Null' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTAB + ', 0' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sTableValues
SET @sProcTextC= @sProcTextC+ @sTAB + ')' + @sCRLF
SET @sProcTextC= @sProcTextC+ @sCRLF

SET @sProcTextC = @sProcTextC + 'FETCH 	NEXT ' + @sCRLF
SET @sProcTextC = @sProcTextC + 'FROM 	crDeletedRecords ' + @sCRLF
SET @sProcTextC = @sProcTextC + 'INTO ' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + '@LupDate' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @EffectiveLupUser' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @EffectiveLupDate' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupMac' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupIP' + @sCRLF
SET @sProcTextC = @sProcTextC + @sTAB + ', @LupMachine' + @sCRLF
SET @sProcTextC = @sProcTextC +  @sTableValues + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF

SET @sProcTextC = @sProcTextC + 'END'  + @sCRLF
SET @sProcTextC = @sProcTextC + 'CLOSE crDeletedRecords'  + @sCRLF
SET @sProcTextC = @sProcTextC + 'DEALLOCATE crDeletedRecords'  + @sCRLF
SET @sProcTextC = @sProcTextC +  @sCRLF

PRINT @sProcTextC

IF @bExecute = 1 
	EXEC (@sProcTextC)




