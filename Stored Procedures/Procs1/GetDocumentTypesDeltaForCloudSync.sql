
CREATE PROCEDURE [dbo].[GetDocumentTypesDeltaForCloudSync]
(
	@pkApplicationUser decimal,
	@pkConnectType decimal 
)

AS

DECLARE @AllDocTypes TABLE
(
 fkDocumentType decimal,
 SystemGeneratedCaption int
)

insert into @AllDocTypes
SELECT DISTINCT fkDocumentType, SystemGeneratedCaption FROM
(
/* Select the Audio Document Types */
SELECT fkDocumentType,
    SystemGeneratedCaption = 0
FROM JoinEventTypeDocumentTypeAudio da

UNION

/* Select the Capture Document Types */
SELECT fkDocumentType,
    SystemGeneratedCaption = 0
FROM JoinEventTypeDocumentTypeCapture dc
) AllDocTypes

update @AllDocTypes 
set SystemGeneratedCaption = dc.SystemGeneratedCaption
from @AllDocTypes adt
inner join JoinEventTypeDocumentTypeCapture dc on dc.fkDocumentType = adt.fkDocumentType

select * from @AllDocTypes
