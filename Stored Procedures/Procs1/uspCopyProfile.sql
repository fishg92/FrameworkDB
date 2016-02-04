-- Stored Procedure

-- uspCopyProfile 1 ,'nenoj','nenoj','5/5/2007','1','1'

CREATE PROC [dbo].[uspCopyProfile] @pkProfile decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
As

declare @pkProfileNew decimal

exec dbo.SetAuditDataContext @LupUser, @LupMachine

insert into Profile
(Description, LongDescription)
select 'Copy of ' + Description, LongDescription
From Profile where pkProfile = @pkProfile

SET @pkProfileNew = SCOPE_IDENTITY()

insert into JoinrefroleProfile
(fkrefRole, fkProfile)
select fkrefRole, @pkProfileNew
from JoinrefroleProfile where fkProfile = @pkProfile


	insert into JoinProfileAutoFillSchemaDataView
	(fkprofile, fkAutoFillSchemaDataView)
	select @pkProfileNew, fkAutoFillSchemaDataView
	from JoinProfileAutoFillSchemaDataView where  fkProfile = @pkProfile

select @pkProfileNew
