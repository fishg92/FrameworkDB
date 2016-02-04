
CREATE  proc [dbo].[spNCPDeleteCPSmartFillKeywordMapping]
(
	@pkCPSmartFillKeywordMapping decimal 
)

as

begin
set nocount on

delete from CPSmartFillKeywordMapping
where pkCPSmartFillKeywordMapping = @pkCPSmartFillKeywordMapping

end

