

CREATE view [dbo].[UserDepartmentGroupSupervisors]
as

select	pkApplicationUser = uUser.pkApplicationUser
		,UserFirstName = uUser.FirstName
		,UserLastName = uUser.LastName
		,UserUserName = uUser.UserName
		,UserCountyCode = isnull(uUser.CountyCode,'')
		,UserWorkerNumber = isnull(uUser.WorkerNumber,'')
		,DepartmentPk = Department.pkDepartment
		,DepartmentName = Department.DepartmentName
		,DepartmentSupervisorPk = isnull(uDepartment.pkApplicationUser,-1)
		,DepartmentSupervisorFirstName = isnull(uDepartment.FirstName,'')
		,DepartmentSupervisorLastName = isnull(uDepartment.LastName,'')
		,DepartmentSupervisorUserName = isnull(uDepartment.UserName,'')
		,DepartmentSupervisorCountyCode = isnull(uDepartment.CountyCode,'')
		,DepartmentSupervisorWorkerNumber = isnull(uDepartment.WorkerNumber,'')
		,GroupPk = AgencyLOB.pkAgencyLOB
		,GroupName = AgencyLOB.AgencyLOBName
		,GroupSupervisorPk = isnull(uGroup.pkApplicationUser,-1)
		,GroupSupervisorFirstName = isnull(uGroup.FirstName,'')
		,GroupSupervisorLastName = isnull(uGroup.LastName,'')
		,GroupSupervisorUserName = isnull(uGroup.UserName,'')
		,GroupSupervisorCountyCode = isnull(uGroup.CountyCode,'')
		,GroupSupervisorWorkerNumber = isnull(uGroup.WorkerNumber,'')
		,AgencyPk = AgencyConfig.pkAgencyConfig
		,AgencyName = AgencyConfig.AgencyName
		,AgencySupervisorPk = isnull(uAgency.pkApplicationUser,-1)
		,AgencySupervisorFirstName = isnull(uAgency.FirstName,'')
		,AgencySupervisorLastName = isnull(uAgency.LastName,'')
		,AgencySupervisorUserName = isnull(uAgency.UserName,'')
		,AgencySupervisorCountyCode = isnull(uAgency.CountyCode,'')
		,AgencySupervisorWorkerNumber = isnull(uAgency.WorkerNumber,'')
from ApplicationUser uUser
join Department
	on uUser.fkDepartment = Department.pkDepartment
join AgencyLOB
	on Department.fkAgencyLOB = AgencyLOB.pkAgencyLOB
join AgencyConfig
	on AgencyLOB.fkAgency = AgencyConfig.pkAgencyConfig
left join ApplicationUser uDepartment
	on Department.fkSupervisor = uDepartment.pkApplicationUser
left join ApplicationUser uGroup
	on AgencyLOB.fkSupervisor = uGroup.pkApplicationUser
left join ApplicationUser uAgency
	on AgencyConfig.fkSupervisor = uAgency.pkApplicationUser


