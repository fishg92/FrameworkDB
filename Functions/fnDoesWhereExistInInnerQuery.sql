
CREATE FUNCTION [dbo].[fnDoesWhereExistInInnerQuery](@TextToSearch  varchar(max))

RETURNS bit
AS
BEGIN

Declare @WhereFound bit
set @WhereFound = 0
set @TextToSearch = reverse(@TextToSearch)

Declare @ParenPosition integer
Declare @FromPosition integer
Declare @WherePosition integer

set @FromPosition = charindex(reverse('from'),@TexttoSearch)
set @ParenPosition = charindex(reverse(')'),@TexttoSearch)
set @WherePosition = charindex(reverse('where'),@TexttoSearch)

if ((@FromPosition > @WherePosition) and (@ParenPosition > @WherePosition)) and @WherePosition <> 0
BEGIN
	set	@WhereFound = 1
END

return @WhereFound

END
