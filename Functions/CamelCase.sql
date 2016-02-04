

CREATE FUNCTION [dbo].[CamelCase]
(
	@input varchar(255)
)
RETURNS varchar(255)
AS
BEGIN
	DECLARE @return varchar(255)
			,@spacePos int
			,@word varchar(255)

	set @input = ltrim(rtrim(@input))
	--Remove multiple spaces
	while charindex(space(2),@input)>0
		set @input = replace(@input,space(2),space(1))

	set @spacePos = charindex(' ',@input)
	
	if @spacePos = 0
		set @return = upper(substring(@input,1,1)) + substring(@input,2,255)
	else
		begin
		set @return = ''
		while @spacePos <> 0
			begin
			set @spacePos = charindex(' ',@input)
			if @spacePos = 0
				set @word = @input
			else
				set @word = ltrim(rtrim(substring(@input,1,@spacePos)))

			set @word = upper(substring(@word,1,1)) + substring(@word,2,255)
			set @return = @return + @word
			
			if @spacePos <> 0
				set @input = ltrim(substring(@input,@spacePos+1,255))-- ltrim(right(@input,(datalength(@input) - datalength(@word))))
			end
		end


	RETURN @return
END
