
CREATE PROC [dbo].[GetFormQuickListWithModifiedByAndModifiedDate]
(	@pkFormQuickListFormName decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@fkFormUser decimal(10, 0) = NULL,
	@QuickListFormName varchar(255) = NULL,
	@DateAdded smalldatetime = NULL,
	@Inactive tinyint = NULL,
	@FormOrder int = NULL
)
AS

SET NOCOUNT ON

DECLARE @ReturnTable TABLE
(
	pkFormQuickListFormName decimal NOT NULL PRIMARY KEY,
	fkFormName decimal,
	fkFormUser decimal,
	QuickListFormName varchar(255),
	DateAdded smalldatetime,
	Inactive tinyint,
	FormOrder int,
	CreateDate datetime,
	LUPUser varchar(50),
	LUPDate datetime
)

INSERT INTO @ReturnTable
SELECT pkFormQuickListFormName,
	   fkFormName,
	   fkFormUser,
	   QuickListFormName,
	   DateAdded,
	   Inactive,
	   FormOrder,
	   CreateDate,
	   '',
	   LUPDate
FROM	FormQuickListFormName
WHERE 	(@pkFormQuickListFormName IS NULL OR pkFormQuickListFormName = @pkFormQuickListFormName)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@fkFormUser IS NULL OR fkFormUser = @fkFormUser)
 AND 	(@QuickListFormName IS NULL OR QuickListFormName LIKE @QuickListFormName + '%')
 AND 	(@DateAdded IS NULL OR DateAdded = @DateAdded)
 AND 	(@Inactive IS NULL OR Inactive = @Inactive)
 AND 	(@FormOrder IS NULL OR FormOrder = @FormOrder)

 --These updates get the last modified date and last modified by for a form favorite. Because forms are split among many tables
 --these upstes are needed to check for changes made to the various tables

UPDATE @ReturnTable
SET LUPDate = a.LUPDate
FROM @ReturnTable r
INNER JOIN (SELECT MAX(fs.LUPDate) AS LUPDate, fs.fkFormQuickListFormName
		    FROM dbo.FormQuickListAdditionalStamp fs
			GROUP BY fs.fkFormQuickListFormName) a ON r.pkFormQuickListFormName = a.fkFormQuickListFormName 
													  AND a.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPDate = n.LUPDate
FROM @ReturnTable r
INNER JOIN (SELECT MAX(fn.LUPDate) AS LUPDate, fn.fkQuickListFormName
		    FROM dbo.FormPeerReviewNote fn
			GROUP BY fn.fkQuickListFormName) n ON r.pkFormQuickListFormName = n.fkQuickListFormName 
												  AND n.LUPDate > r.LUPDate

UPDATE @ReturnTable
SET LUPDate = j.LUPDate
FROM @ReturnTable r
INNER JOIN (SELECT MAX(fj.LUPDate) AS LUPDate, fj.fkQuickListFormName 
			FROM dbo.FormJoinQuickListFormNameAnnotationAnnotationValue fj
			GROUP BY fj.fkQuickListFormName) j ON r.pkFormQuickListFormName = j.fkQuickListFormName 
												  AND j.LUPDate > r.LUPDate

SELECT * FROM @ReturnTable