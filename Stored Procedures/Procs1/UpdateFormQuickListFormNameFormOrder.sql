
Create proc [dbo].[UpdateFormQuickListFormNameFormOrder]
(	
	@FormOrder int,
	@pkQuickListFormName decimal(10, 0) 
)

as

	UPDATE FormQuickListFormName
	SET FormOrder = @FormOrder
	WHERE pkFormQuickListFormName = @pkQuickListFormName