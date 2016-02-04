
/****** Object:  Stored Procedure dbo.spGetOnBaseDocTypeNum    Script Date: 8/21/2006 8:02:16 AM ******/
CREATE procedure [dbo].[spGetOnBaseDocTypeNum]
(	@DocTypeName varchar(255),
	@OnBaseDocTypeNum int output
)
as

	/*	Lookup the keyword number from the OnBase keyword table */
	Set @onBaseDocTypeNum = (Select Max(itemtypenum) from OnBase.hsi.doctype where RTrim(LTrim(itemtypename)) = RTrim(LTrim(@DocTypeName)))
