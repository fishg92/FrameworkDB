CREATE PROCEDURE [dbo].[GetPSPAllDocTypesWithLastModifiedDateAndUser]
AS

SET NOCOUNT ON

DECLARE @ReturnTable TABLE
(
	pkPSPDocType decimal NOT NULL PRIMARY KEY,
	DocName varchar(255),
	MatchString varchar(255),
	SendToOnBase bit,
	DMSDocType varchar(50),
	DMSDocTypeName varchar(500),
	Deleted bit,
	LUPUser varchar(50),
	LUPDate datetime
)

INSERT INTO @ReturnTable
SELECT	  pkPSPDocType
		, DocName
		, MatchString
		, SendToOnBase
		, DMSDocType
		, DMSDocTypeName
		, Deleted
		, LUPUser
		, LUPDate
FROM PSPDocType

 --These updates get the last modified date and last modified by for a PSP form. Because PSP forms are split among many tables
 --these upstes are needed to check for changes made to the various tables

UPDATE @ReturnTable
SET LUPUser = d.LUPUser,
    LUPDate = d.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.PSPDocImage d ON r.pkPSPDocType = d.fkPSPDocType AND d.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = s.LUPUser,
    LUPDate = s.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.PSPDocTypeSplit s ON r.pkPSPDocType = s.fkPSPDocType AND s.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = k.LUPUser,
    LUPDate = k.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.PSPKeyword k ON r.pkPSPDocType = k.fkPSPDocType AND k.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPUser = p.LUPUser,
    LUPDate = p.LUPDate
FROM @ReturnTable r
INNER JOIN dbo.PSPPage p ON r.pkPSPDocType = p.fkPSPDocType AND p.LUPDate > r.LUPDate

SELECT * FROM @ReturnTable