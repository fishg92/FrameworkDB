




CREATE          PROC [dbo].[pr__SYS_MakeInsertRecordProc]
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
	@sPrimaryKeyField varchar(250),
	@sPrimaryKeyFieldReturn varchar(250),
	@sAllFields varchar(2000),
	@sAllParams varchar(2000),
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
	@HasIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1),
	@spPrefix varchar(10)

SET 	@spPrefix = 'usp'
SET 	@HasIdentity = 0
SET		@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)
SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET		@sAllFields = ''
SET		@sWhereClause = ''
SET		@sAllParams  = ''
SET 	@sPrimaryKeyField = ''
SET 	@sPrimaryKeyFieldReturn = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sTableName + 'Insert'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC ' + @spPrefix + @sTableName + 'Insert' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Insert a single record into ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC ' + @spPrefix + @sTableName + 'Insert' + @sCRLF

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
	IF (@bPrimaryKeyColumn = 1) 
	begin
		SET @sPrimaryKeyField = + @sTAB + ', @' + @sColumnName + ' ' + @sTypeName

		/* If we have a decimal or numeric key then it changes our variable declaration */
		IF (@nAlternateType = 2) --decimal, numeric
		BEGIN
			SET @sPrimaryKeyField =  @sPrimaryKeyField + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
					+ CAST(@nColumnScale AS varchar(3)) + ')'
		END
		
		SET @sPrimaryKeyField = @sPrimaryKeyField + ' = NULL OUTPUT '
		SET @sPrimaryKeyFieldReturn = 'SET @' + @sColumnName + ' = SCOPE_IDENTITY()'
	END
		
	IF (@IsIdentity = 0)
	BEGIN
		
		/* Dont add to the key fields if this is a primary key, we already have it*/
		If (@bPrimaryKeyColumn = 0)
		BEGIN
			/* if there already is a value in the key field we need to line feed */
			IF (@sKeyFields <> '')
			BEGIN
				SET @sKeyFields = @sKeyFields + @sCRLF 
				SET @sKeyFields = @sKeyFields + @sTAB + ', @' + @sColumnName + ' ' + @sTypeName
			END
			ELSE
			BEGIN
				SET @sKeyFields = @sKeyFields + @sTAB +'  @' + @sColumnName + ' ' + @sTypeName
			END
		END


		IF (@sAllFields <> '')
		BEGIN
			SET @sAllParams = @sAllParams + @sTAB + ', '
			SET @sAllFields = @sAllFields + @sTAB + ', '
		END
		ELSE
		BEGIN
			SET @sAllParams = @sAllParams + @sTAB + '  '
			SET @sAllFields = @sAllFields + @sTAB + '  '
		END

		IF (@sTypeName = 'timestamp')
			SET @sAllParams = @sAllParams + 'NULL' + @sCRLF
		ELSE IF (@sDefaultValue IS NOT NULL)
			SET @sAllParams = @sAllParams + 'COALESCE(@' + @sColumnName + ', ' + @sDefaultValue + ')' + @sCRLF
		ELSE
			SET @sAllParams = @sAllParams + '@' + @sColumnName + @sCRLF

		SET @sAllFields = @sAllFields + @sColumnName + @sCRLF

	END
	ELSE
	BEGIN
		If (@bPrimaryKeyColumn = 0)
		begin
			SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName
		end
	END
	IF (@nAlternateType = 2) --decimal, numeric
	begin
		If (@bPrimaryKeyColumn = 0)
		begin
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
					+ CAST(@nColumnScale AS varchar(3)) + ')'
		end
	end
	ELSE IF (@nAlternateType = 1) --character and binary
	begin
		If (@bPrimaryKeyColumn = 0)
		begin
			IF (@nColumnLength = -1)
			BEGIN
				SET @sKeyFields =  @sKeyFields + '(MAX)'
			END
			ELSE
			BEGIN
				SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
			END
			--SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
		end
	end

	IF (@IsIdentity = 0)
	BEGIN
		IF (@sDefaultValue IS NOT NULL) OR (@IsNullable = 1) OR (@sTypeName = 'timestamp')
			SET @sKeyFields = @sKeyFields + ' = NULL'
	END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sProcText = @sProcText + '(' + @sKeyFields + @sCRLF + @sPrimaryKeyField + @sCRLF + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'INSERT ' + @sTableName + @sCRLF + '(' + @sAllFields + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'VALUES ' + @sCRLF + '(' + @sAllParams + @sCRLF + ')' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET	@sProcText = @sProcText + @sPrimaryKeyFieldReturn + @sCRLF

IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)






