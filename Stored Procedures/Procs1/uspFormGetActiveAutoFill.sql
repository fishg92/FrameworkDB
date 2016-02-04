
create proc [dbo].[uspFormGetActiveAutoFill]
	@fkFrameworkUserID decimal
as

declare @fkActiveAutofill int

select	@fkActiveAutoFill = fkActiveAutofill
from	dbo.FormUserSetting
where	fkFrameworkUserID = @fkFrameworkUserID

select fkActiveAutofill = isnull(@fkActiveAutofill,-1)



