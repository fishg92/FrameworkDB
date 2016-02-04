


CREATE procedure [dbo].[uspGetOnBaseKeyTypeNum]
(	@KeywordName varchar(255),
	@OnBaseKeyTypeNum int output
)
as

	/*	Lookup the keyword number from the OnBase keyword table */
	Set @OnBaseKeyTypeNum = (Select isnull(Max(keytypenum), 0) from hsi.keytypetable where keytype = @KeywordName)