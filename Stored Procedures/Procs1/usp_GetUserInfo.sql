

/* 
usp_GetUserInfo 8

usp_GetUserInfo -1

*/

CREATE PROC [dbo].[usp_GetUserInfo]
(	@fkApplicationUser decimal
)
As
--Table 0
select	pkApplicationUser
		,Username
		,FirstName
		,LastName
		,Password
		,fkDepartment
		,LDAPUser
		,WorkerNumber
		,CountyCode
		,eCAFFirstName
		,eCAFLastName
		,eMail
		,IsCaseworker
		,StateID
		,PhoneNumber
		,Extension
		,isActive
								
from ApplicationUser with (NOLOCK)
where pkApplicationUser = @fkApplicationUser


union

select 
-1
,''
,''
,''
,''
,fkDepartment = (select top 1 pkDepartment from Department with (NOLOCK) order by DepartmentName)
,0
,''
,''
,''
,''
,''
,1
,''
,''
,''
, 1
where @fkApplicationUser = -1

--Table 1
select	pkrefRole
		,Description
		,DetailedDescription
		,fkrefRoleType 
from refRole with (NOLOCK)
where fkrefRoleType <> 1

--Table 2
select	pkJoinApplicationUserrefRole
		,fkApplicationUser
		,fkrefRole
from JoinApplicationUserrefRole with (NOLOCK)
where fkApplicationUser = @fkApplicationUser

--Table 3
select	pkDepartment
		,DepartmentName
		,fkAgencyLOB
from Department with (NOLOCK) 


select	pkApplicationUser
		,Username
		,Firstname
		,Lastname
		,fkDepartment=pkDepartment
into #HoldUser
From  ApplicationUser  with (NOLOCK) 
inner join dbo.Department with (NOLOCK)
	on Department.pkDepartment = ApplicationUser.fkDepartment
where 1=0

insert into #HoldUser
select	pkApplicationUser
		,Username
		,Firstname
		,Lastname
		,fkDepartment=pkDepartment
From  ApplicationUser  with (NOLOCK) 
inner join dbo.Department  with (NOLOCK)
	on Department.pkDepartment = ApplicationUser.fkDepartment

--Table 4
select	pkAgencyConfig
		,AgencyName
from AgencyConfig with (NOLOCK)
where pkAgencyConfig in (select fkAgencyLOB from AgencyLOB with (NOLOCK)
		inner join Department  with (NOLOCK) on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
        inner join #HoldUser on #HoldUser.fkDepartment = Department.pkDepartment)

--Table 5
select pkAgencyLOB,AgencyLOBName
from AgencyLOB  with (NOLOCK) 
        /*
		where pkAgencyLOB in (select pkAgencyLOB from AgencyLOB with (NOLOCK)
        inner join Department  with (NOLOCK) on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
        inner join #HoldUser on #HoldUser.fkDepartment = Department.pkDepartment)
		*/

--Table 6
select pkDepartment
		,DepartmentName
		,fkAgencyLOB
from Department with (NOLOCK) 
        /*
		where pkDepartment in (select fkDepartment from #HoldUser)
		*/

--Table 7
select distinct #HoldUser.* 
		, fkAgencyLOB
		, fkAgency
		, Department = ''
		, AgencyLOB = ''
		, Agency = ''
From #HoldUser
inner join Department  with (NOLOCK) on fkDepartment = Department.pkDepartment
inner join AgencyLOB on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
        drop table #HoldUser

--shouldn't have to do this due to Cycle 50 fixes , but just in case...
/*
delete from WorkShareAssignment where
 dbo.[GetDeletableWorkShareAssignment](pkWorkShareAssignment, fkSharer, fkSharee, fkrefWorkSharingType) = 1
*/

--Table 8
select	pkWorkShareAssignment
		, fkSharer
		, fkSharee
		, fkrefWorkSharingType = isnull(fkrefWorkSharingType,1)
from WorkShareAssignment with (NOLOCK)
where fkSharee = @fkApplicationUser

--Table 9
select 
pkProgramType
,Description = ProgramType
 from ProgramType

--Table 10
select 
pkJoinApplicationUserProgramType
,fkApplicationUser
,fkProgramType
 from JoinApplicationUserProgramType
where fkApplicationUser =  @fkApplicationUser

--Table 11
select	pkCPCaseWorkerAltId
		,WorkerId
		,fkApplicationUser
from CPCaseWorkerAltId with (NOLOCK)
where fkApplicationUser = @fkApplicationUser

--Table 12
select	pkApplicationUserCustomAttribute
		,fkApplicationUser
		,ItemKey
		,ItemValue
from ApplicationUserCustomAttribute with (NOLOCK)
where fkApplicationUser = @fkApplicationUser
