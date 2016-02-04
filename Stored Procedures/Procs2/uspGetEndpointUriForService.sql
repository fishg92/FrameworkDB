
-- [uspGetEndpointUriForService] 1
----------------------------------------------------------------------------
-- Select a single record from ServiceDirectory
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspGetEndpointUriForService]
(	@ServiceName varchar(100) 
)
AS
declare @ReturnVal varchar(100)

select @ReturnVal   = ''

	SELECT	
		@ReturnVal = EndPointUri
	FROM	ServiceDirectory with (NOLOCK)
	WHERE 	(ServiceName = @ServiceName)


select @ReturnVal
