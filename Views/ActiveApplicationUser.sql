create view ActiveApplicationUser
as

select	pkApplicationUser, UserName, FirstName, LastName, [Password], fkDepartment
		, LUPUser, LUPDate, CreateUser, CreateDate, WorkerNumber, LDAPUser, LDAPUniqueID
		, CountyCode, MiddleName, eMail, IsCaseworker, IsActive, eCAFFirstName, eCAFLastName
		, StateID, PhoneNumber, Extension, ExternalIDNumber
from	ApplicationUser
where isnull(IsActive,1) = 1


