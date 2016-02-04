
/****** Object:  Stored Procedure dbo.spGetOnBaseKeyTypeNum    Script Date: 8/21/2006 8:02:16 AM ******/
CREATE procedure [dbo].[spGetOnBaseKeyTypeNum]
(	@KeywordName varchar(255),
	@OnBaseKeyTypeNum int output
)
as

	/*	Lookup the keyword number from the OnBase keyword table */
	Set @OnBaseKeyTypeNum = (Select Max(keytypenum) from OnBase.hsi.keytypetable where keytype = @KeywordName)
