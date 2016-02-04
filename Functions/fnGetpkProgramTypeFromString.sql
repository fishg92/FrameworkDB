CREATE FUNCTION [dbo].[fnGetpkProgramTypeFromString]
(
	@ProgramTypeName varchar(255)
)
RETURNS decimal(18,0)
AS
BEGIN
	DECLARE @return decimal(18,0)

	SELECT @return = 0

	SELECT @return = pkProgramType
	FROM ProgramType
	WHERE ProgramType = RTRIM(LTRIM(@ProgramTypeName))

	RETURN @return
END
