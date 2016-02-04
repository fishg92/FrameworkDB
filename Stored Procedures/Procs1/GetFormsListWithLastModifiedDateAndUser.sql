CREATE PROC [dbo].[GetFormsListWithLastModifiedDateAndUser]
(	@pkFormName decimal(18, 0) = NULL,
	@FriendlyName varchar(255) = NULL,
	@SystemName varchar(255) = NULL,
	@NotToDMS tinyint = NULL,
	@Renditions tinyint = NULL,
	@Status tinyint = NULL,
	@BarcodeDocType varchar(50) = NULL,
	@BarcodeDocTypeName varchar(255) = NULL,
	@FormDocType varchar(50) = NULL,
	@HasBarcode bit = NULL,
	@BarcodeRequired int = NULL,
	@RouteDocument smallint = NULL,
	@ForceSubmitOnFavorite bit = NULL,
	@RequireClientSignature bit = NULL,
	@SingleUseDocType varchar(50) = NULL,
	@SingleUseDocTypeName varchar(255) = NULL,
	@DefaultFollowUpDays int = NULL,
	@CompressionWarning bit = NULL,
	@PrintRequired int = NULL
)

AS

SET NOCOUNT ON

DECLARE @ReturnTable TABLE
(
	pkFormName decimal NOT NULL PRIMARY KEY,
	FriendlyName varchar(255),
	SystemName varchar(255),
	NotToDMS tinyint,
	Renditions tinyint,
	[Status] tinyint,
	BarcodeDocType varchar(50),
	BarcodeDocTypeName varchar(255),
	FormDocType varchar(50),
	HasBarcode bit,
	BarcodeRequired int,
	RouteDocument smallint,
	ForceSubmitOnFavorite bit,
	RequireClientSignature bit,
	SingleUseDocType varchar(50),
	SingleUseDocTypeName varchar(255),
	DefaultFollowUpDays int,
	CompressionWarning bit,
	PrintRequired int,
	LUPUser varchar(50),
	LUPDate datetime
)

INSERT INTO @ReturnTable
SELECT	pkFormName,
	FriendlyName,
	SystemName,
	NotToDMS,
	Renditions,
	[Status],
	BarcodeDocType,
	BarcodeDocTypeName,
	FormDocType,
	HasBarcode,
	BarcodeRequired,
	RouteDocument,
	ForceSubmitOnFavorite,
	RequireClientSignature,
	SingleUseDocType,
	SingleUseDocTypeName,
	DefaultFollowUpDays,
	CompressionWarning,
	PrintRequired,
	LUPUser,
	LUPDate
FROM	FormName
WHERE 	(@pkFormName IS NULL OR pkFormName = @pkFormName)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@SystemName IS NULL OR SystemName LIKE @SystemName + '%')
 AND 	(@NotToDMS IS NULL OR NotToDMS = @NotToDMS)
 AND 	(@Renditions IS NULL OR Renditions = @Renditions)
 AND 	(@Status IS NULL OR Status = @Status)
 AND 	(@BarcodeDocType IS NULL OR BarcodeDocType LIKE @BarcodeDocType + '%')
 AND 	(@BarcodeDocTypeName IS NULL OR BarcodeDocTypeName LIKE @BarcodeDocTypeName + '%')
 AND 	(@FormDocType IS NULL OR FormDocType LIKE @FormDocType + '%')
 AND 	(@HasBarcode IS NULL OR HasBarcode = @HasBarcode)
 AND 	(@BarcodeRequired IS NULL OR BarcodeRequired = @BarcodeRequired)
 AND 	(@RouteDocument IS NULL OR RouteDocument = @RouteDocument)
 AND 	(@ForceSubmitOnFavorite IS NULL OR ForceSubmitOnFavorite = @ForceSubmitOnFavorite)
 AND 	(@RequireClientSignature IS NULL OR RequireClientSignature = @RequireClientSignature)
 AND 	(@SingleUseDocType IS NULL OR SingleUseDocType LIKE @SingleUseDocType + '%')
 AND 	(@SingleUseDocTypeName IS NULL OR SingleUseDocTypeName LIKE @SingleUseDocTypeName + '%')
 AND 	(@DefaultFollowUpDays IS NULL OR DefaultFollowUpDays = @DefaultFollowUpDays)
 AND	(@CompressionWarning IS NULL OR CompressionWarning = @CompressionWarning)
 AND	(@PrintRequired IS NULL OR PrintRequired = @PrintRequired)

 --These updates get the last modified date and last modified by for a form. Because forms are split among many tables
 --these upstes are needed to check for changes made to the various tables

UPDATE @ReturnTable
SET LUPUser = f.LUPUser,
	LUPDate = f.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormImage f ON r.pkFormName = f.fkFormName AND f.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = f.LUPUser,
	LUPDate = f.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormAnnotation f ON r.pkFormName = f.fkForm AND f.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = p.LUPUser,
	LUPDate = p.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormAnnotation f ON r.pkFormName = f.fkForm
INNER JOIN dbo.FormAnnotationPosition p ON p.fkFormAnnotation = f.pkFormAnnotation AND p.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = g.LUPUser,
	LUPDate = g.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormAnnotation f ON r.pkFormName = f.fkForm
INNER JOIN dbo.FormJoinFormAnnotationFormAnnotationGroup j ON j.fkFormAnnotation = f.pkFormAnnotation 
INNER JOIN dbo.FormAnnotationGroup g ON g.pkFormAnnotationGroup = j.fkFormAnnotationGroup AND g.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = cv.LUPUser,
	LUPDate = cv.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormAnnotation f ON r.pkFormName = f.fkForm
INNER JOIN dbo.FormJoinFormComboNameFormComboValue j ON j.fkFormComboName = f.fkFormComboName
INNER JOIN dbo.FormComboValue cv ON cv.pkFormComboValue = j.fkFormComboValue AND cv.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = s.LUPUser,
	LUPDate = s.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.FormAnnotation f ON r.pkFormName = f.fkForm
INNER JOIN dbo.FormAnnotationSharedObject s ON s.pkFormAnnotationSharedObject = f.fkFormAnnotationSharedObject AND s.LUPDate > r.LUPDate

SELECT * FROM @ReturnTable