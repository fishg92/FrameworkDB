CREATE PROCEDURE [dbo].[uspPSPGetAllDocTypes]
AS

	SELECT	  pkPSPDocType
			, DocName
			, MatchString
			, SendToOnBase
			, DMSDocType
			, DMSDocTypeName
			, Deleted
	FROM PSPDocType