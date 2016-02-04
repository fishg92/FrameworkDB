

CREATE PROC [dbo].[usp_GetCustomAttributeNames]

AS

SELECT	
	 pkColumnNameFriendlyNameMapping
	,TableName
    ,ColumnName
    ,FriendlyName
    ,LUPUser
    ,LUPDate
    ,CreateUser
    ,CreateDate
FROM	ColumnNameFriendlyNameMapping (nolock)

