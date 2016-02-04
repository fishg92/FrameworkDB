
CREATE       PROC [dbo].[pr__SYS_MakeSelectRecordProc]
	@sTableName varchar(128),
	@bExecute bit = 0	
AS

select @sTableName = name
from sys.tables
where name = @sTableName

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(MAX),
	@sKeyFields varchar(MAX),
	@sSelectClause varchar(MAX),
	@sWhereClause varchar(MAX),
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
	@sDefaultValue varchar(MAX),
	@sCRLF char(2),
	@sTAB char(1),
	@spPrefix varchar(10),
	@sQuote char(1)

SET 	@spPrefix = 'usp'
SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)
SET	@sQuote = char(39)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sSelectClause = ''
SET	@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix + @sTableName + 'Select'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC ' + @spPrefix + @sTableName + 'Select' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Select a single record from ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC ' + @spPrefix + @sTableName + 'Select' + @sCRLF

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

	if @sColumnName not in ('CreateUser','CreateDate','LUPUser','LUPDate','EffectiveLUPUser','EffectiveLUPDate','EffectiveCreateUser','EffectiveCreateDate','LUPMac','LUPIP','LUPMachine','CreateMAC','CreateIP','CreateMachine')
	begin
		IF (@sKeyFields <> '')
		BEGIN
			SET @sKeyFields = @sKeyFields + ',' + @sCRLF 
		END

		SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName

		IF (@nAlternateType = 2) --decimal, numeric
		BEGIN
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
					+ CAST(@nColumnScale AS varchar(3)) + ')'
		END
		ELSE IF (@nAlternateType = 1) --character and binary
		BEGIN
			IF (@nColumnLength = -1)
			BEGIN
				SET @sKeyFields =  @sKeyFields + '(MAX)'
			END
			ELSE
			BEGIN
				SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
			END
			--SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
		END
	
		SET @sKeyFields =  @sKeyFields + ' = NULL'
	end

	if @sColumnName not in ('CreateUser','CreateDate','LUPUser','LUPDate','EffectiveLUPUser','EffectiveLUPDate','EffectiveCreateUser','EffectiveCreateDate','LUPMac','LUPIP','LUPMachine','CreateMAC','CreateIP','CreateMachine')
	begin
		IF (@sWhereClause = '')
		BEGIN
			SET @sWhereClause = @sWhereClause + 'WHERE '
		END
		ELSE
		BEGIN
			IF (@sTypeName <> 'binary' AND @sTypeName <> 'text' AND @sTypeName <> 'ntext' AND @sTypeName <> 'varbinary' AND @sTypeName <> 'image')
			BEGIN
				SET @sWhereClause = @sWhereClause + ' AND ' 
			END
		END

		IF (@sTypeName <> 'binary' AND @sTypeName <> 'text' AND @sTypeName <> 'ntext' AND @sTypeName <> 'varbinary' AND @sTypeName <> 'image')
		BEGIN
			SET @sWhereClause = @sWhereClause + @sTAB + '(@' + @sColumnName  + ' IS NULL OR ' + @sColumnName
		
			/* need to parse the type of the data and figure out where we need to parse a 'like' or '=' */
			IF (@nAlternateType = 1) --character and binary
			BEGIN
				SET @sWhereClause = @sWhereClause + ' LIKE @' + @sColumnName + ' + ' + @sQuote + '%' + @sQuote + ')'
			END
			ELSE
			BEGIN
				SET @sWhereClause = @sWhereClause  + ' = @' + @sColumnName + ')'
			END
		
			SET @sWhereClause = @sWhereClause + @sCRLF
		END 
	end
	IF (@sSelectClause = '')
	BEGIN
		SET @sSelectClause = @sSelectClause + 'SELECT'
	END
	ELSE
	BEGIN
		SET @sSelectClause = @sSelectClause + ',' + @sCRLF 
	END

	SET @sSelectClause = @sSelectClause + @sTAB + @sColumnName 

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sSelectClause = @sSelectClause + @sCRLF

SET 	@sProcText = @sProcText + '(' + @sKeyFields + @sCRLF + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + @sSelectClause
SET 	@sProcText = @sProcText + 'FROM	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)


