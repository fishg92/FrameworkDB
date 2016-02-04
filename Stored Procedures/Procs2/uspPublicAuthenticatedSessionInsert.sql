-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into PublicAuthenticatedSession
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPublicAuthenticatedSessionInsert]
(	  @fkApplicationUser decimal(18, 0) = NULL
	, @AuthenticationToken varchar(75) = NULL
	, @KeepAlive datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPublicAuthenticatedSession decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT dbo.PublicAuthenticatedSession
(	  fkApplicationUser
	, AuthenticationToken
	, KeepAlive

)
VALUES 
(	  @fkApplicationUser
	, @AuthenticationToken
	, @KeepAlive
)

SET @pkPublicAuthenticatedSession = SCOPE_IDENTITY()
