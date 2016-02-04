


/****** Object:  Stored Procedure dbo.SetRenditionToFinished    Script Date: 8/21/2006 8:02:14 AM ******/



CREATE  PROCEDURE [dbo].[SetRenditionToFinished] 
(	@pkRendition decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@RenditionFinishedAlready tinyint output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

Declare @CurStatus tinyint

If Exists(Select pkRendition from Rendition where pkRendition = @pkRendition)
begin
	/* JM 8-31-04 */
	Set @CurStatus = (Select IsNull(UnFinished,0) From Rendition Where pkRendition = @pkRendition)
	If @CurStatus = 1
	begin
		Update 	Rendition
		Set	UnFinished = 0 
		Where	pkRendition = @pkRendition

		Set @RenditionFinishedAlready = 0
	end
	Else
	begin
		Set @RenditionFinishedAlready = 1
	end
end
