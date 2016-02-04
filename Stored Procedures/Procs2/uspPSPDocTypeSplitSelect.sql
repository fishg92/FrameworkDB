----------------------------------------------------------------------------
-- Select a single record from PSPDocTypeSplit
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocTypeSplitSelect]
(	@pkPSPDocTypeSplit decimal(18, 0) = NULL,
	@fkPSPDocType decimal(18, 0) = NULL,
	@SubmitToDMS bit = NULL,
	@CopyToFolder bit = NULL,
	@fkKeywordForFolderName decimal(18, 0) = NULL,
	@StaticFolderName varchar(100) = NULL,
	@Enabled bit = NULL
)
AS

SELECT	pkPSPDocTypeSplit,
	fkPSPDocType,
	SubmitToDMS,
	CopyToFolder,
	fkKeywordForFolderName,
	StaticFolderName,
	Enabled
FROM	PSPDocTypeSplit
WHERE 	(@pkPSPDocTypeSplit IS NULL OR pkPSPDocTypeSplit = @pkPSPDocTypeSplit)
 AND 	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)
 AND 	(@SubmitToDMS IS NULL OR SubmitToDMS = @SubmitToDMS)
 AND 	(@CopyToFolder IS NULL OR CopyToFolder = @CopyToFolder)
 AND 	(@fkKeywordForFolderName IS NULL OR fkKeywordForFolderName = @fkKeywordForFolderName)
 AND 	(@StaticFolderName IS NULL OR StaticFolderName LIKE @StaticFolderName + '%')
 AND 	(@Enabled IS NULL OR Enabled = @Enabled)


