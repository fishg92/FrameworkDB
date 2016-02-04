
CREATE  Proc [dbo].[spCPGetCPClientPhone]
(	@Number varchar (10) = Null,
	@Extension varchar (10) = Null
)
as

Select	pkCPClientPhone,
	CreateUser,
	CreateDate,
	LUPUser,
	LUPDate,
	fkCPRefPhoneType,
	Number,
	Extension
From 	CPClientPhone c with (NoLock)
Where 	(@Number is null or c.Number like @Number + '%')
and   	(@Extension is null or c.Extension like @Extension + '%')

