----------------------------------------------------------------------------
-- Select a single record from CPClientPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientPhoneSelect]
(	@pkCPClientPhone decimal(18, 0) = NULL,
	@fkCPRefPhoneType decimal(18, 0) = NULL,
	@Number varchar(10) = NULL,
	@Extension varchar(10) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPClientPhone,
	fkCPRefPhoneType,
	Number,
	Extension,
	LockedUser,
	LockedDate
FROM	CPClientPhone
WHERE 	(@pkCPClientPhone IS NULL OR pkCPClientPhone = @pkCPClientPhone)
 AND 	(@fkCPRefPhoneType IS NULL OR fkCPRefPhoneType = @fkCPRefPhoneType)
 AND 	(@Number IS NULL OR Number LIKE @Number + '%')
 AND 	(@Extension IS NULL OR Extension LIKE @Extension + '%')
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)

