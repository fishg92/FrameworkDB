----------------------------------------------------------------------------
-- Select a single record from uspActivityLogSelect
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspActivityLogSelect]
(	@ActivityID varchar (50)
)
AS

SELECT	
pkActivityLog
, ActivityID
, fkrefActivityType
, fkApplicationUser
, fkDepartment
, fkAgencyLOB
, ParentActivityID
, ActivityDate
, MachineName
, Data1
, Data2
, Data3
, Data4
, Data5
, Data6
, Data7
, Data8
, Data9
, Data10
, DecimalData1
, DecimalData2
, DecimalData3
, DecimalData4
, DecimalData5
, DecimalData6
, DecimalData7
, DecimalData8
, DecimalData9
, DecimalData10
, BitData1
, BitData2
, BitData3
, BitData4
, BitData5
, DateData1
, DateData2
, DateData3
, DateData4
, DateData5
, LUPUser
, LUPDate
, CreateUser
, CreateDate

from dbo.ActivityLog
where ActivityID = @ActivityID

