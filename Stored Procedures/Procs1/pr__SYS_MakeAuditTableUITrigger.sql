


/***************************************************
exec [dbo].[pr__SYS_MakeAuditTableUITrigger] 'usertasktypedeselected'
exec [dbo].[pr__SYS_MakeAuditTableUITrigger] 'AutoFill'
exec [dbo].[pr__SYS_MakeAuditTableUITrigger] 'CPClientPhone'
exec [dbo].[pr__SYS_MakeAuditTableUITrigger] 'formimagepage',1



****************************************************/


CREATE  PROC [dbo].[pr__SYS_MakeAuditTableUITrigger]
	@sTableName varchar(128),
	@bExecute bit = 0
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
	,@sIpLupColumn varchar(10)


Set @spPrefix = 'tr_'
SET	@sTAB = char(9)
SET @sCRLF = char(13) + char(10)
SET @sAuditTableName  = @sTableName + 'Audit'

SET @sProcText = ''
SET @sKeyFields = ''
SET	@sWhereClause = ''
SET @sAllFields = ''
SET @sAllValues = ''

--Drop existing triggers

SET @sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''' + @spPrefix  + @sAuditTableName + '_UI'')' + @sCRLF
SET @sProcText = @sProcText + @sTAB + 'DROP Trigger ' + @spPrefix + @sAuditTableName + '_UI' + @sCRLF

SET @sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET @sProcText = ''
SET @sProcText = @sProcText + 'CREATE Trigger ' + @spPrefix + @sAuditTableName /*+ @sWithHist*/ + '_UI' + ' On ' + @stableName + @sCRLF
SET @sProcText = @sProcText + 'FOR INSERT, UPDATE' + @sCRLF
SET @sProcText = @sProcText + 'As' + @sCRLF

SET @sProcText = @sProcText + 'SET NOCOUNT ON;' + @sCRLF
SET @sProcText = @sProcText + @sCRLF
SET @sProcText = @sProcText + 'Declare @AuditUser varchar(50)' + @sCRLF
--SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditStartDate datetime' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditEndDate datetime' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditMachine varchar(15)' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@Date datetime' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@HostName varchar(50)' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'select @HostName = host_name()' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@Date = getdate()' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

SET @sProcText = @sProcText + 'select @AuditUser = @HostName' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB + ',@AuditMachine = ''''' + @sCRLF
SET @sProcText = @sProcText + @sTAB + @sTAB +  @sCRLF

SET @sProcText = @sProcText + 'exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output' + @sCRLF
SET @sProcText = @sProcText +  @sCRLF

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
		And @sColumnName <> 'Date_Lup' 
		And @sColumnName <> 'user_lup'
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
		Begin
			SET @sAllFields = @sAllFields + @sTAB + ','
				
			SET @sAllFields = @sAllFields + '[' + @sColumnName + ']' + @sCRLF

			SET @sAllValues = @sAllValues + @sTAB +  ','
			
			If @sTypeName = 'image'
				Or @sTypeName = 'text'
				Begin
				SET @sAllValues = @sAllValues + 'null' + @sCRLF
				End
			else if @sTypeName = 'varbinary'
			and @nColumnLength = -1
				begin
				set @sAllValues = @sAllValues + '0' + @sCRLF
				end
			Else
				Begin
				If substring(@sColumnName,1,5) = 'Audit'
					Begin
					SET @sAllValues = @sAllValues + '@' + @sColumnName + @sCRLF
					End
				Else
					Begin
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

if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name in ('CreateUser','CreateDate','LUPUser','LUPDate'))
	begin

	SET @sProcText = @sProcText + 'Update ' + @sTableName + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ' Set '
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'CreateUser')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[CreateUser] = @AuditUser' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'CreateDate')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[CreateDate] = @Date' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'LUPUser')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[LUPUser] = @AuditUser' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'LUPDate')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[LUPDate] = @Date' + @sCRLF
		end
		
		
	--SET @sProcText = @sProcText + @sTAB + ',[CreateDate] = @Date' + @sCRLF
	--SET @sProcText = @sProcText + @sTAB + ',[LUPUser] = @AuditUser' + @sCRLF
	--SET @sProcText = @sProcText + @sTAB + ',[LUPDate] = @Date' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'From ' + @sTableName + ' dbTable' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'Inner Join Inserted i on dbtable.pk' + @sTableName + ' = i.pk' + @sTableName + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'Left Join Deleted d on d.pk' + @sTableName + ' = d.pk' + @sTableName + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'Where d.pk' + @sTableName + ' is null' + @sCRLF
	SET @sProcText = @sProcText + @sCRLF

	SET @sProcText = @sProcText + 'Update ' + @sTableName + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ' Set '
	
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'CreateUser')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[CreateUser] = d.CreateUser' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'CreateDate')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[CreateDate] = d.CreateDate' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'LUPUser')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[LUPUser] = @AuditUser' + @sCRLF
		end
		
	if exists (select * from syscolumns
			where id = object_id(@sTableName)
			and name = 'LUPDate')
		begin
		if right(rtrim(@sProcText),3) <> 'Set'
			set @sProcText = @sProcText + ','
		set @sProcText = @sProcText + '[LUPDate] = @Date' + @sCRLF
		end
	
	--[CreateUser] = d.CreateUser' + @sCRLF
	--SET @sProcText = @sProcText + @sTAB + ',[CreateDate] = d.CreateDate' + @sCRLF
	--SET @sProcText = @sProcText + @sTAB + ',[LUPUser] = @AuditUser' + @sCRLF
	--SET @sProcText = @sProcText + @sTAB + ',[LUPDate] = @Date' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'From ' + @sTableName + ' dbTable' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'Inner Join Deleted d on dbTable.pk' + @sTableName + ' = d.pk' + @sTableName + @sCRLF
	end
	
SET @sProcText = @sProcText + @sCRLF

if exists (select * 
			from sysobjects
			where name = @sAuditTableName
			and xtype = 'U')
	begin
	SET @sProcText = @sProcText + '--End date current audit record' + @sCRLF
	SET @sProcText = @sProcText + 'Update dbTable' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'Set AuditEndDate = @Date' + @sCRLF
	SET @sProcText = @sProcText + 'From ' + @sAuditTableName + ' dbTable' + @sCRLF
	SET @sProcText = @sProcText + 'Inner Join inserted i ON dbTable.[pk' + @sTableName + '] = i.[pk' + @sTableName + ']' + @sCRLF
	SET @sProcText = @sProcText + 'Where dbTable.AuditEndDate is null' + @sCRLF
	SET @sProcText = @sProcText + @sCRLF

	if @sTableName = 'CPClient'
	begin
		SET @sProcText = @sProcText + 
'Update CPClient
	set CPClient.NorthwoodsNumber =	case when CPClient.NorthwoodsNumber = '''' then
								dbo.GetNorthwoodsNumber(CPClient.pkCPClient)
							else
								CPClient.NorthwoodsNumber
							end
From CPClient 
Inner Join inserted i ON CPClient.[pkCPClient] = i.[pkCPClient]
'

	end

	SET @sProcText = @sProcText + '--create new audit record' + @sCRLF
	SET @sProcText = @sProcText + 'Insert into ' +  @sAuditTableName + @sCRLF
	SET @sProcText = @sProcText + @sTAB + '(' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + 'AuditStartDate' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditEndDate' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditUser' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditMachine' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditDeleted' + @sCRLF
	SET @sProcText = @sProcText + @sAllFields + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ')' + @sCRLF

	SET @sProcText = @sProcText + @sTAB + 'Select' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + '@Date' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditEndDate = null' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', @AuditUser' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', @AuditMachine' + @sCRLF
	SET @sProcText = @sProcText + @sTAB + ', AuditDeleted = 0' + @sCRLF

	SET @sProcText = @sProcText + @sAllValues + @sCRLF
	SET @sProcText = @sProcText + 'From  Inserted'
	end
	
SET @sProcText = @sProcText + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)