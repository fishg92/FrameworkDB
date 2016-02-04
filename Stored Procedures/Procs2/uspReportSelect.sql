----------------------------------------------------------------------------
-- Select a single record from Report
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspReportSelect]
(	@pkReport decimal(18, 0) = NULL,
	@FriendlyName varchar(200) = NULL,
	@fkNCPApplication decimal(18, 0) = NULL
)
AS

SELECT	pkReport,
	FriendlyName,
	fkNCPApplication
FROM	Report
WHERE 	(@pkReport IS NULL OR pkReport = @pkReport)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@fkNCPApplication IS NULL OR fkNCPApplication = @fkNCPApplication)

