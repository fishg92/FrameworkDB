


CREATE procedure [dbo].[uspGetOnBaseDocTypeNum]
(	@DocTypeName varchar(255),
	@OnBaseDocTypeNum int output
)
as

	/*	Lookup the keyword number from the OnBase keyword table */
	Set @onBaseDocTypeNum = (Select Max(itemtypenum) from OnBase.hsi.doctype where RTrim(LTrim(itemtypename)) = RTrim(LTrim(@DocTypeName)))
