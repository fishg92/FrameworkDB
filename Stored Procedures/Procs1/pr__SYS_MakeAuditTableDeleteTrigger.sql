
CREATE  PROC [dbo].[pr__SYS_MakeAuditTableDeleteTrigger]
	@sTableName varchar(128),
	@bExecute bit = 0
/***********************************************************
exec pr__sys_MakeAuditTableDeleteTriggerProc 'cpcaseworker',1

************************************************************/	
AS

set @sTableName = object_name(object_id(@sTableName))

DECLARE	@sProcText varchar(8000)
	,@sKeyFields varchar(2000)
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
	--,@sEffTableName varchar(128)

Set @spPrefix = 'tr_'
SET	@sTAB = char(9)
SET @sCRLF = char(13) + char(10)
SET @sAuditTableName  = @sTableName + 'Audit'
--SET @sEffTableName  = @sTableName + 'AuditEff'

SET @sProcText = ''
SET @sKeyFields = ''
SET	@sWhereClause = ''
SET @sAllFields = ''
SET @sAllValues = ''

SET @sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sTableName + '_d'')' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'DROP Trigger ' + @spPrefix + @sTableName + '_d' + @sCRLF
--IF @bExecute = 0
--	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET @sProcText = @sProcText + @sCRLF

SET @sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sAuditTableName + '_d'')' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'DROP Trigger ' + @spPrefix + @sAuditTableName + '_d' + @sCRLF
--IF @bExecute = 0
--	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET @sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET @sProcText = ''
SET @sProcText = @sProcText + 'CREATE Trigger ' + @spPrefix + @sAuditTableName + '_d' + ' On ' + @stableName + @sCRLF
SET @sProcText = @sProcText + 'FOR Delete' + @sCRLF
SET @sProcText = @sProcText + 'As' + @sCRLF

SET @sProcText = @sProcText + 'SET NOCOUNT ON;' + @sCRLF
SET @sProcText = @sProcText + @sCRLF
SET @sProcText = @sProcText + 'Declare @AuditUser varchar(50)' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditStartDate datetime' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEndDate datetime' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffectiveUser varchar(50)' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffectiveDate datetime' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffStartDate datetime' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffEndDate datetime' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditMachine varchar(15)' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditDeleted tinyint' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffDeleted tinyint' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffUser varchar(50)' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@Date datetime' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'select @Date = getdate()' + @sCRLF

SET @sProcText = @sProcText + 'select @AuditUser = host_name()' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditStartDate = @Date' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEndDate = null' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffectiveUser = host_name()' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffectiveDate = @Date' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffStartDate = @Date' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffEndDate = null' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditMachine = ''''' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditDeleted = 0' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffDeleted = 0' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEffUser = host_name()' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB +  @sCRLF


SET @sProcText = @sProcText + 'exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + '--End date current audit record' + @sCRLF
SET @sProcText = @sProcText + 'Update dbTable' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'Set AuditEndDate = @Date' + @sCRLF
SET @sProcText = @sProcText + 'From ' + @sAuditTableName + ' dbTable' + @sCRLF
SET @sProcText = @sProcText + 'Inner Join deleted d ON dbTable.[pk' + @sTableName + '] = d.[pk' + @sTableName + ']' + @sCRLF
SET @sProcText = @sProcText + 'Where dbTable.AuditEndDate is null' + @sCRLF
SET @sProcText = @sProcText + @sCRLF

SET @sProcText = @sProcText + '--create new audit record' + @sCRLF
SET @sProcText = @sProcText + 'Insert into ' +  @sAuditTableName + @sCRLF
SET @sProcText = @sProcText + @sTAB + '(' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'AuditStartDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditEndDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffectiveUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffectiveDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditMachine' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditDeleted' + @sCRLF

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
 BEGIN

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
			SET @sAllFields = @sAllFields + @sTAB + ','
				
			SET @sAllFields = @sAllFields + '[' + @sColumnName + ']' + @sCRLF

			SET @sAllValues = @sAllValues + @sTAB +  ','
			
			if @sTableName = 'PSPPrintJobPage'
			and @sColumnName = 'PageData'
				begin
				set @sAllValues = @sAllValues + '0' + @sCRLF
				end
			else If @sTypeName = 'image'
				Or @sTypeName = 'text'
			Begin
				SET @sAllValues = @sAllValues + 'null' + @sCRLF
			End Else Begin
				If substring(@sColumnName,1,5) = 'Audit'
				Begin
					SET @sAllValues = @sAllValues + '@' + @sColumnName + @sCRLF
				End Else Begin
					SET @sAllValues = @sAllValues + '[' + @sColumnName + ']' + @sCRLF
				End
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

SET @sAllFields = @sAllFields + @sTAB + ')'
SET @sAllValues = @sAllValues + 'From  Deleted'
	

SET @sProcText = @sProcText + @sAllFields + @sCRLF

SET @sProcText = @sProcText + @sTAB + 'Select' + @sCRLF
SET @sProcText = @sProcText + @sTAB + '@Date' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditEndDate = null' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @AuditUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', @AuditEffectiveUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', @AuditEffectiveDate' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', @AuditMachine' + @sCRLF
SET @sProcText = @sProcText + @sTAB + ', AuditDeleted = 1' + @sCRLF

SET @sProcText = @sProcText + @sAllValues + @sCRLF

--SET @sProcText = @sProcText + @sCRLF
--SET @sProcText = @sProcText + '--if a backdated change, delete the old audit eff records' + @sCRLF
--SET @sProcText = @sProcText + 'Delete from ' + @sEffTableName + @sCRLF
--SET @sProcText = @sProcText + 'Where pk in ' + @sCRLF
--SET @sProcText = @sProcText + '	(' + @sCRLF
--SET @sProcText = @sProcText + '	Select pk ' + @sCRLF
--SET @sProcText = @sProcText + '	From ' + @sEffTableName + ' dbTable' + @sCRLF
--SET @sProcText = @sProcText + '	Inner Join deleted d ON dbTable.[pk' + @sTableName + '] = d.[pk' + @sTableName + ']' + @sCRLF
--SET @sProcText = @sProcText + '	Where dbTable.AuditEffStartDate >= @AuditEffectiveDate' + @sCRLF
--SET @sProcText = @sProcText + '	)' + @sCRLF

--SET @sProcText = @sProcText + @sCRLF
--SET @sProcText = @sProcText + '--Enddate current auditeffective record' + @sCRLF
--SET @sProcText = @sProcText + 'Update dbTable' + @sCRLF 
--SET @sProcText = @sProcText + 'Set AuditEffEndDate = @AuditEffectiveDate' + @sCRLF
--SET @sProcText = @sProcText + 'FROM ' + @sEffTableName + ' dbTable' + @sCRLF
--SET @sProcText = @sProcText + 'Where pk in' + @sCRLF
--SET @sProcText = @sProcText + '	(' + @sCRLF
--SET @sProcText = @sProcText + '	Select max(pk)' + @sCRLF
--SET @sProcText = @sProcText + '	From ' + @sEffTableName + ' dbTable' + @sCRLF
--SET @sProcText = @sProcText + '	Inner Join deleted d ON dbTable.[pk' + @sTableName + '] = d.[pk' + @sTableName + ']' + @sCRLF
--SET @sProcText = @sProcText + '	Group by dbTable.[pk' + @sTableName + ']' + @sCRLF
--SET @sProcText = @sProcText + '	)' + @sCRLF

--SET @sProcText = @sProcText + @sCRLF
--SET @sProcText = @sProcText + '--create new audit effective record' + @sCRLF
--SET @sProcText = @sProcText + 'Insert into ' + @sEffTableName + @sCRLF
--SET @sProcText = @sProcText + @sTAB + '(' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + 'AuditEffStartDate' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffEndDate' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffDeleted' + @sCRLF

--SET @sProcText = @sProcText + @sAllFields + @sCRLF

--SET @sProcText = @sProcText + @sTAB + 'Select' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + '@AuditEffectiveDate' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffEndDate = null' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', @AuditEffectiveUser' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + ', AuditEffDeleted = 1' + @sCRLF


--SET @sProcText = @sProcText + @sAllValues + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)