
/*
select * From ApplicationUser ApplicationUser 
GetAllAgencyGroupsDepartmentsUsers 1
GetAllAgencyGroupsDepartmentsUsers -1
*/
--delete from joinapplicationuserrefrole where fkrefrole = -1

CREATE	procedure [dbo].[GetAllAgencyGroupsDepartmentsUsers](@fkrefRole decimal)
as
set nocount on
set transaction isolation level read uncommitted

        select pkApplicationUser
			,Username
			,Firstname
			,Lastname
			,fkDepartment=pkDepartment
			,WorkerNumber
			,LDAPUser = isnull(LDAPUser,0)
			,IsActive = ISNULL(isActive,1) 
        into #HoldUser
        From  ApplicationUser  with (NOLOCK) 
        inner join dbo.Department with (NOLOCK) on Department.pkDepartment = ApplicationUser.fkDepartment
        where 1=0

        insert into #HoldUser
        select pkApplicationUser
			,Username
			,Firstname
			,Lastname
			,fkDepartment=pkDepartment
			, WorkerNumber
			, LDAPUser = isnull(LDAPUser,0)
			,IsActive = ISNULL(isActive,1)
        From  ApplicationUser  with (NOLOCK) 
        inner join dbo.Department  with (NOLOCK) on Department.pkDepartment = ApplicationUser.fkDepartment
        --where ApplicationUser.pkApplicationUser <>  @pkApplicationUser 

		Select pkAgencyConfig
				,AgencyName 
		from AgencyConfig with (NOLOCK)
		where pkAgencyConfig in (select fkAgencyLOB from AgencyLOB with (NOLOCK)
		inner join Department  with (NOLOCK) on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
        inner join #HoldUser on #HoldUser.fkDepartment = Department.pkDepartment)

        select pkAgencyLOB
			,AgencyLOBName
        from AgencyLOB  with (NOLOCK) 
        where pkAgencyLOB in (select pkAgencyLOB from AgencyLOB with (NOLOCK)
        inner join Department  with (NOLOCK) on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
        inner join #HoldUser on #HoldUser.fkDepartment = Department.pkDepartment)

        select pkDepartment
				,DepartmentName
				,fkAgencyLOB
        from Department with (NOLOCK) 
        where pkDepartment in (select fkDepartment from #HoldUser)

        select distinct #HoldUser.* 
			, fkAgencyLOB
			, fkAgency
			, Department = ''
			, AgencyLOB = ''
			, Agency = ''
			, LDAPUser
			, IsActive
		From #HoldUser
		inner join Department  with (NOLOCK) on fkDepartment = Department.pkDepartment
		inner join AgencyLOB on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
				drop table #HoldUser


		select 
			pkJoinApplicationUserrefRole
			,fkApplicationUser
			,fkrefRole 
		from dbo.JoinApplicationUserrefRole with (NOLOCK)
		where fkrefRole = @fkrefRole
