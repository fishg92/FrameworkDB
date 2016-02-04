CREATE Proc [dbo].[spCPGetCaseWorkerFromApplicationUser]

as

Select 	pkApplicationUser ,
	CreateUser ,
	CreateDate ,
	LUPUser ,
	LUPDate ,
	LastName = isnull(LastName,''),
	FirstName = isnull(FirstName,''),
	MiddleName = isnull(MiddleName,''),
	StateID,
	UserName,
	CountyCode,
	NULL AS 'fkAgencyAddress',
	eMail,
	isactive = isnull(IsActive,1)
From	dbo.ApplicationUser c with (NoLock)
Where 	c.IsCaseworker = 1
and isnull(C.IsActive,1) = 1
