----------------------------------------------------------------------------
-- Insert a single record into FormAnnotation
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationInsert]
(	  @fkForm decimal(18, 0)
	, @AnnotationName varchar(100)
	, @AnnotationFormOrder int
	, @Page int = NULL
	, @Deleted tinyint
	, @Mask varchar(50) = NULL
	, @Required bit
	, @fkFormComboName decimal(18, 0) = NULL
	, @Tag varchar(50) = NULL
	, @fkrefAnnotationType decimal(18, 0)
	, @DefaultText varchar(2000) = NULL
	, @FontName varchar(255) = NULL
	, @FontSize float = NULL
	, @FontStyle int = NULL
	, @FontColor varchar(100) = NULL
	, @SingleUse bit = NULL
	, @fkFormAnnotationSharedObject decimal(18, 0) = NULL
	, @ReadOnly bit = NULL
	, @Formula varchar(500) = NULL
	, @DefaultValue decimal(18,5) = NULL
	, @fkAutofillViewForQuickName decimal(18,0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormAnnotation decimal(18, 0) = NULL OUTPUT 
	, @NewLineAfter BIT = 0
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormAnnotation
(	  fkForm
	, AnnotationName
	, AnnotationFormOrder
	, Page
	, Deleted
	, Mask
	, [Required]
	, fkFormComboName
	, Tag
	, fkrefAnnotationType
	, DefaultText
	, FontName
	, FontSize
	, FontStyle
	, FontColor
	, SingleUse
	, fkFormAnnotationSharedObject
	, [ReadOnly]
	, Formula
	, DefaultValue
	, fkAutofillViewForQuickName
	, NewLineAfter
)
VALUES 
(	  @fkForm
	, @AnnotationName
	, @AnnotationFormOrder
	, COALESCE(@Page, (0))
	, @Deleted
	, @Mask
	, @Required
	, COALESCE(@fkFormComboName, (0))
	, @Tag
	, @fkrefAnnotationType
	, @DefaultText
	, @FontName
	, @FontSize
	, @FontStyle
	, @FontColor
	, @SingleUse
	, @fkFormAnnotationSharedObject
	, @ReadOnly
	, @Formula
	, @DefaultValue
	, @fkAutofillViewForQuickName
	, @NewLineAfter
)

SET @pkFormAnnotation = SCOPE_IDENTITY()
