



CREATE proc [dbo].[uspFormGetFormPath] 
(	@pkFormName decimal(10, 0),
	@FormPath varchar(500) output
)
as

	Set @FormPath = IsNull((Select TOP 1 Path From FormPath where fkFormName = @pkFormName),'')

