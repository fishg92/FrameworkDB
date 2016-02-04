

--[dbo].[uspGetFrameworkReferenceData] 

CREATE      procedure [dbo].[uspGetFrameworkReferenceData] 
as

select pkrefTheme, KeyName, Description 
	from refTheme with (NOLOCK)


