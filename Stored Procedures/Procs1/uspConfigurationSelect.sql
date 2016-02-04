
----------------------------------------------------------------------------
-- Select a single record from Configuration
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspConfigurationSelect]
(	@pkConfiguration decimal(18, 0) = NULL,
	@Grouping varchar(200) = NULL,
	@ItemKey varchar(200) = NULL,
	@ItemValue nvarchar(300) = NULL,
	@ItemDescription varchar(300) = NULL,
	@AppID int = NULL,
	@Sequence int = NULL
)
AS

SELECT	pkConfiguration,
	Grouping,
	ItemKey,
	ItemValue,
	ItemDescription,
	AppID,
	Sequence
FROM	Configuration
WHERE 	(@pkConfiguration IS NULL OR pkConfiguration = @pkConfiguration)
 AND 	(@Grouping IS NULL OR Grouping LIKE @Grouping + '%')
 AND 	(@ItemKey IS NULL OR ItemKey LIKE @ItemKey + '%')
 AND 	(@ItemValue IS NULL OR ItemValue LIKE @ItemValue + '%')
 AND 	(@ItemDescription IS NULL OR ItemDescription LIKE @ItemDescription + '%')
 AND 	(@AppID IS NULL OR AppID = @AppID)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)


