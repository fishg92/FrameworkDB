





/* 
[usp_GetViewsByProfile] 1

[usp_GetViewsByProfile] -2

*/

CREATE PROC [dbo].[usp_GetViewsByProfile]
(	@fkProfile decimal
)
As
	select 
	pkAutoFillSchemaDataView
	,FriendlyName 
	from AutoFillSchemaDataView  with (NOLOCK)
	where pkAutoFillSchemaDataView in
	 (select fkAutoFillSchemaDataView from  dbo.JoinProfileAutoFillSchemaDataView with (NOLOCK)
		where fkProfile = @fkProfile	  
	  )
