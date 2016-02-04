




CREATE           PROC [dbo].[pr__SYS_MakeUpdateRecordProc]
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
	@sSetClause varchar(2000),
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
	@spPrefix varchar(25)

SET 	@spPrefix = 'usp'
SET		@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET		@sSetClause = ''
SET		@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sTableName + 'Update'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC ' + @spPrefix + @sTableName + 'Update' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Update a single record in ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC ' + @spPrefix + @sTableName + 'Update' + @sCRLF

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
	IF (@sKeyFields <> '')
	BEGIN
		SET @sKeyFields = @sKeyFields + @sCRLF
		SET @sKeyFields = @sKeyFields + @sTAB + ', @' + @sColumnName + ' ' + @sTypeName 
	END
	ELSE
	BEGIN
		SET @sKeyFields = @sKeyFields + @sTAB + '  @' + @sColumnName + ' ' + @sTypeName 
	END

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
	
	IF (@bPrimaryKeyColumn = 0)
	BEGIN
		IF @sTableName = 'CPClient' and @sColumnName = 'NorthwoodsNumber'
		begin
			set @sKeyFields = @sKeyFields + 'OUTPUT'
		end
		else
		begin
			SET @sKeyFields =  @sKeyFields + ' = NULL'
		end
	END

	IF (@bPrimaryKeyColumn = 1)
	BEGIN
		IF (@sWhereClause = '')
			SET @sWhereClause = @sWhereClause + 'WHERE ' 
		ELSE
			SET @sWhereClause = @sWhereClause + ' AND ' 

		SET @sWhereClause = @sWhereClause + @sTAB + @sColumnName  + ' = @' + @sColumnName  
	END
	ELSE
		IF (@IsIdentity = 0)
		 BEGIN
			IF (@sSetClause = '')
			BEGIN
				SET @sSetClause = @sSetClause + 'SET'
			END
			ELSE
			BEGIN
				SET @sSetClause = @sSetClause + ',' + @sCRLF 
			END

			SET @sSetClause = @sSetClause + @sTAB + @sColumnName  + ' = ISNULL('

			IF (@sTypeName = 'timestamp')
			BEGIN
				SET @sSetClause = @sSetClause + 'NULL'
			END
			/*ELSE IF (@sDefaultValue IS NOT NULL)
			BEGIN
				SET @sSetClause = @sSetClause + 'COALESCE(@' + @sColumnName + ', ' + @sDefaultValue + ')'
			END*/
			ELSE
			BEGIN
				SET @sSetClause = @sSetClause + '@' + @sColumnName 
			END
			
			SET @sSetClause = @sSetClause + ', ' + @sColumnName + ')' 
		 END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sSetClause = @sSetClause + @sCRLF

SET 	@sProcText = @sProcText + '(' + @sKeyFields + @sCRLF + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'UPDATE	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sSetClause
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)





