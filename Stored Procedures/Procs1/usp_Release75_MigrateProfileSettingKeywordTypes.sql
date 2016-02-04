CREATE procedure [dbo].[usp_Release75_MigrateProfileSettingKeywordTypes]
as
/*
This script assumes you have upgraded to Pilot Version 3.75
*/

SET NOCOUNT ON
SET XACT_ABORT ON

-- backup data just in case
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProfileSettingBackup]') AND type in (N'U'))
DROP TABLE [dbo].[ProfileSettingBackup]

select pkProfileSetting, ItemKey, ItemValue, AppID, fkProfile into ProfileSettingBackup 
from profileSetting
where [Grouping] = 'KeywordSettings'
and ItemKey <> 'UseDefaultKeywords'

DECLARE @NextString NVARCHAR(max)
DECLARE @Pos INT
DECLARE @NextPos INT
DECLARE @String VARCHAR(max)
DECLARE @Delimiter CHAR(1)

DECLARE @pkProfileSetting int
DECLARE @ItemKey varchar(max)
DECLARE @ItemValue varchar(max)
DECLARE @AppID int
DECLARE @fkProfile varchar(255)

BEGIN TRANSACTION

UPDATE [KeywordTypeDisplaySetting] set fkProfile = -1

DECLARE merge_cursor CURSOR FAST_FORWARD FOR
select pkProfileSetting, ItemKey, ItemValue, AppID, fkProfile 
from ProfileSetting
where [Grouping] = 'KeywordSettings'
and ItemKey <> 'UseDefaultKeywords'

OPEN merge_cursor

FETCH NEXT FROM merge_cursor INTO @pkProfileSetting, @ItemKey, @ItemValue, @AppID, @fkProfile
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @String = @ItemValue
	SET @Delimiter = '|'
	SET @String = @String + @Delimiter
	SET @Pos = charindex(@Delimiter, @String)
	DECLARE @count int
	DECLARE @DisplayName varchar(max)
	DECLARE @SearchChecked tinyint
	DECLARE @DisplayChecked tinyint
	DECLARE @ExportChecked tinyint
	DECLARE @FreeformChecked tinyint
	DECLARE @IsCaseManager tinyint
	DECLARE @IsKeepInWorkflow tinyint
	DECLARE @fkKeywordType int
		
	SET @count = 0
	SET @SearchChecked = 0
	SET @DisplayChecked = 0
	SET @ExportChecked = 0
	SET @FreeformChecked = 0
	SET @IsKeepInWorkflow = 0
	SET @IsCaseManager = 0
	SET @fkKeywordType = '-99'
		
	WHILE (@count < 7)
	BEGIN
		IF (@Pos > 0)
		BEGIN
			SET @NextString = substring(@String, 1, @Pos - 1)
			
			IF @count = 0
				SET @DisplayName = @NextString
			ELSE IF @count = 1
				SET @SearchChecked = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			ELSE IF @count = 2
				SET @DisplayChecked = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			ELSE IF @count = 3
				SET @ExportChecked = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			ELSE IF @count = 4
				SET @FreeformChecked = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			ELSE IF @count = 5
				SET @IsKeepInWorkflow = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			ELSE IF @count = 6
				SET @IsCaseManager = CASE WHEN UPPER(@NextString) = 'TRUE' THEN 1 ELSE 0 END
			SET @String = substring(@String, @pos + 1, len(@String))
			SET @pos = charindex(@Delimiter, @String)
			
			SET @count = @count + 1
		END
		ELSE
		BEGIN
			set @count = 7
		END
	END

	--SELECT @DisplayName, @DisplayChecked,@SearchChecked,@ExportChecked,@FreeformChecked
	set @fkKeywordType = ISNULL((SELECT top 1 fkKeywordType 
						from [KeywordTypeDisplaySetting]
						where KeywordName = @DisplayName
						and	fkProfile = -1), '-99')

	-- Do the insert
	INSERT INTO [KeywordTypeDisplaySetting]
           ([fkKeywordType]
           ,[KeywordName]
           ,[DisplayInResultGrid]
           ,[IsSearchable]
           ,[IncludeInExportManifest]
           ,[IsFreeform]
           ,[fkProfile])
     VALUES
           (@fkKeywordType
           ,@DisplayName
           ,@DisplayChecked
           ,@SearchChecked
           ,@ExportChecked
           ,@FreeformChecked
           ,@fkProfile)
	
	FETCH NEXT FROM merge_cursor INTO @pkProfileSetting, @ItemKey, @ItemValue, @AppID, @fkProfile
END

CLOSE merge_cursor
DEALLOCATE merge_cursor

SELECT 'Manual clean up required for the following:'
SELECT '(Case Tag should be set to the next negative unused number in sequence.)'
SELECT '(Any keywords left with a -99 need to be manually updated using common sense)'
SELECT * FROM [KeywordTypeDisplaySetting]
WHERE fkKeywordType = '-99'

-- clean up old tables
delete from ProfileSetting
where [Grouping] = 'KeywordSettings'
and ItemKey <> 'UseDefaultKeywords'

declare @errValue int

set @errValue = @@error

if @errValue = 0
BEGIN
print 'here'
	COMMIT TRANSACTION
END
else
BEGIN
	ROLLBACK TRANSACTION
END

print @errValue
