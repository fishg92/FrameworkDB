

CREATE proc [dbo].[GetScannedDocMappings]
(
	@ScannedDocType varchar(100)
)

as 

select MappedDocType 
from ScannedDocTypeMapping
where ScannedDocType = @ScannedDocType
