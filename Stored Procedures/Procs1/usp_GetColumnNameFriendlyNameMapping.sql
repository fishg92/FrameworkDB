
-- usp_GetColumnNameFriendlyNameMapping 'CPClientCustomAttribute'
CREATE PROC [dbo].[usp_GetColumnNameFriendlyNameMapping] (@TableName varchar(250))
As
select ColumnName, FriendlyName from ColumnnameFriendlynamemapping 
	where TableName = @TableName


