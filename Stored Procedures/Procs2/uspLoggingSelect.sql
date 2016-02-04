----------------------------------------------------------------------------
-- Select a single record from [Logging]
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLoggingSelect]
(	@AssociateWith varchar (200)
)
AS

SELECT	pkTrace
, DateTime
, Source
, ApplicationID
, EntryType
, Message
, AssociateWith
, Object
, ObjectLen
, LupUser
, LupDate
, CreateUser
, CreateDate
from dbo.Logging (nolock)
where AssociateWith = @AssociateWith

