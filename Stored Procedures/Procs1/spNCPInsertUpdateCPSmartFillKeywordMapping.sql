

CREATE  proc [dbo].[spNCPInsertUpdateCPSmartFillKeywordMapping]
(
	@pkCPSmartFillKeywordMapping decimal = null,
	@PeopleKeyword varchar(100),
	@SmartFillAlias varchar(100),
	@ReturnPK decimal output
)

as

begin
set nocount on

if @pkCPSmartFillKeywordMapping is null
	begin
		insert into CPSmartFillKeywordMapping(PeopleKeyword, SmartFillAlias)
		values (@PeopleKeyword, @SmartFillAlias)

		set @ReturnPK = @@Identity
	end
else
	begin
		update CPSmartFillKeywordMapping
		set PeopleKeyword = @PeopleKeyword,
		    SmartFillAlias = @SmartFillAlias
		where pkCPSmartFillKeywordMapping = @pkCPSmartFillKeywordMapping

		set @ReturnPK = @pkCPSmartFillKeywordMapping
	end
end
