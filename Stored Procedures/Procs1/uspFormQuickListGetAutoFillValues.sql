CREATE PROCEDURE [dbo].[uspFormQuickListGetAutoFillValues]
(	
	@fkFormQuickListFormName decimal(18,0)
)
AS

SELECT 	  FormQuickListAutoFillValue
		, KeywordName
		, RowNumber
		, AutoFillGroupName
FROM 	FormQuickListAutoFillValue
WHERE 	fkFormQuickListFormName = @fkFormQuickListFormName
ORDER BY RowNumber