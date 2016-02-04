



CREATE       PROC [dbo].[pr__SYS_MakeDeleteRecordProcAuditFields]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(8000),
	@sKeyFields varchar(2000),
	@sWhereClause varchar(2000),
	@sColumnName varchar(128),
	@nColumnID smallint,
	@bPrimaryKeyColumn bit,
	@nAlternateType int,
	@nColumnLength int,
	@nColumnPrecision int,
	@nColumnScale int,
	@IsNullable bit, 
	@IsIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1),
	@spPrefix varchar(10)

Set @spPrefix = 'usp'
SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sTableName + 'Delete'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC ' + @spPrefix + @sTableName + 'Delete' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Delete a single record from ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC ' + @spPrefix + @sTableName + 'Delete' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sTableName)
	ORDER BY 2

OPEN crKeyFields

FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN

	--Dont bother with our audit fields
	IF (@sColumnName <> 'LUPUser' AND 
		@sColumnName <> 'LUPDate' AND 
		@sColumnName <> 'CreateUser' AND 
		@sColumnName <> 'CreateDate' AND 
		@sColumnName <> 'EffectiveLUPUser' AND 
		@sColumnName <> 'EffectiveLUPDate' AND
		@sColumnName <> 'EffectiveCreateUser' AND
		@sColumnName <> 'EffectiveCreateDate' AND 
		@sColumnName <> 'LUPMac' AND
		@sColumnName <> 'LUPIP' AND
		@sColumnName <> 'LUPMachine' AND
		@sColumnName <> 'CreateMac' AND 
		@sColumnName <> 'CreateMachine' AND 
		@sColumnName <> 'CreateIP')
	BEGIN

		IF (@bPrimaryKeyColumn = 1)
		 BEGIN
			IF (@sKeyFields <> '')
				SET @sKeyFields = @sKeyFields + ',' + @sCRLF 
		
			SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName

			IF (@nAlternateType = 2) --decimal, numeric
				SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
						+ CAST(@nColumnScale AS varchar(3)) + ')'
		
			ELSE IF (@nAlternateType = 1) --character and binary
				SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
		
			IF (@sWhereClause = '')
				SET @sWhereClause = @sWhereClause + 'WHERE ' 
			ELSE
				SET @sWhereClause = @sWhereClause + ' AND ' 

			SET @sWhereClause = @sWhereClause + @sTAB + @sColumnName  + ' = @' + @sColumnName + @sCRLF 
		 END

	END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

DECLARE @AuditFields varchar(2000)
DECLARE @AuditInsert varchar(2000)

SET @AuditFields = '	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)'
	
SET @AuditInsert = '
exec dbo.SetAuditDataContext @LupUser, @LupMachine
'

SET 	@sProcText = @sProcText + '(' + @sKeyFields + @sCRLF + @AuditFields + @sCRLF + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET		@sProcText = @sProcText + @AuditInsert + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'DELETE	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)





