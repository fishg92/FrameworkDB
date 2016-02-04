

CREATE  procedure [dbo].[GetAllAgencyGroupsDepartments]
as
set nocount on
set transaction isolation level read uncommitted

select 
	pkAgencyConfig
	,AgencyName
	,fkSupervisor
from 
AgencyConfig

select 
	pkAgencyLOB
	,AgencyLOBName
	,fkAgency
	,fkSupervisor
from 
AgencyLOB

select 
	pkDepartment
	,DepartmentName
	,fkAgencyLOB
	,fkSupervisor
 from 
Department


