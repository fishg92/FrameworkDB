

--[usp_GetApplicationList] 5

CREATE PROC [dbo].[usp_GetApplicationList]

As
/*
SELECT 
pkNCPApplication
,AppID
,ApplicationName
,CurrentVersion
,AssemblyName
,Registered
,DefaultAppOrder
*/
select * 
 From NCPApplication
where Registered = 1



