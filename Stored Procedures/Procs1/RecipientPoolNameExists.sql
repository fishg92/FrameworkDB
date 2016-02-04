--[RecipientPoolNameExists] 3, 'Pool of Life2'
CREATE PROC [dbo].[RecipientPoolNameExists]
(
	@pkRecipientPool decimal
	,@RecipientPoolName varchar(50)
)
AS

select case when exists 
	(
	select * 
	from RecipientPool with (NOLOCK)
	where [Name] = @RecipientPoolName
	and pkRecipientPool <> @pkRecipientPool
	)
then 1 
else 0 
end