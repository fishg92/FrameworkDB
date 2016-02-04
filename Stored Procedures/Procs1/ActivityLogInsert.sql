
CREATE proc [dbo].[ActivityLogInsert]
	@ActivityID varchar(50)
	,@fkrefActivityType decimal
	,@fkApplicationUser decimal
	,@ParentActivityID  varchar(50) = ''
	,@MachineName varchar(50) = ''
	,@Data1 varchar(255) = ''
	,@Data2 varchar(255) = ''
	,@Data3 varchar(255) = ''
	,@Data4 varchar(255) = ''
	,@Data5 varchar(255) = ''
	,@Data6 varchar(255) = ''
	,@Data7 varchar(255) = ''
	,@Data8 varchar(255) = ''
	,@Data9 varchar(255) = ''
	,@Data10 varchar(255) = ''
	,@DecimalData1 decimal(18,4) = null
	,@DecimalData2 decimal(18,4) = null
	,@DecimalData3 decimal(18,4) = null
	,@DecimalData4 decimal(18,4) = null
	,@DecimalData5 decimal(18,4) = null
	,@DecimalData6 decimal(18,4) = null
	,@DecimalData7 decimal(18,4) = null
	,@DecimalData8 decimal(18,4) = null
	,@DecimalData9 decimal(18,4) = null
	,@DecimalData10 decimal(18,4) = null
	,@BitData1 bit = null
	,@BitData2 bit = null
	,@BitData3 bit = null
	,@BitData4 bit = null
	,@BitData5 bit = null
	,@DateData1 datetime = null
	,@DateData2 datetime = null
	,@DateData3 datetime = null
	,@DateData4 datetime = null
	,@DateData5 datetime = null
	,@pkActivityLog decimal = null output
as
declare  @fkDepartment decimal
		,@fkAgencyLOB decimal
		,@now datetime = getdate()

SET @fkDepartment = 0
SET @fkAgencyLOB = 0

SELECT   @fkDepartment = au.fkDepartment
		,@fkAgencyLOB = d.fkAgencyLOB
FROM ApplicationUser au (NOLOCK)
JOIN Department d ON au.fkDepartment = d.pkDepartment
WHERE au.pkApplicationUser = @fkApplicationUser 

insert dbo.ActivityLog
	(
		ActivityID
		,fkrefActivityType
		,fkApplicationUser
		,fkDepartment
		,fkAgencyLOB
		,ParentActivityID
		,MachineName
		,Data1
		,Data2
		,Data3
		,Data4
		,Data5
		,Data6
		,Data7
		,Data8
		,Data9
		,Data10
		,DecimalData1
		,DecimalData2
		,DecimalData3
		,DecimalData4
		,DecimalData5
		,DecimalData6
		,DecimalData7
		,DecimalData8
		,DecimalData9
		,DecimalData10
		,BitData1
		,BitData2
		,BitData3
		,BitData4
		,BitData5
		,DateData1
		,DateData2
		,DateData3
		,DateData4
		,DateData5
		,LupUser
	    ,LupDate
        ,CreateUser
        ,CreateDate
	)
values
	(
        @ActivityID
		,@fkrefActivityType
		,@fkApplicationUser
		,@fkDepartment
		,@fkAgencyLOB
		,@ParentActivityID
		,@MachineName
		,@Data1
		,@Data2
		,@Data3
		,@Data4
		,@Data5
		,@Data6
		,@Data7
		,@Data8
		,@Data9
		,@Data10
		,@DecimalData1
		,@DecimalData2
		,@DecimalData3
		,@DecimalData4
		,@DecimalData5
		,@DecimalData6
		,@DecimalData7
		,@DecimalData8
		,@DecimalData9
		,@DecimalData10
		,@BitData1
		,@BitData2
		,@BitData3
		,@BitData4
		,@BitData5
		,@DateData1
		,@DateData2
		,@DateData3
		,@DateData4
		,@DateData5
		,@fkApplicationUser
        ,@now
        ,@fkApplicationUser
        ,@now
	)

set @pkActivityLog = scope_identity()
