----------------------------------------------------------------------------
-- Update a single record in FormAnnotation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationUpdate]
(	  @pkFormAnnotation decimal(18, 0)
	, @fkForm decimal(18, 0) = NULL
	, @AnnotationName varchar(100) = NULL
	, @AnnotationFormOrder int = NULL
	, @Page int = NULL
	, @Deleted tinyint = NULL
	, @Mask varchar(50) = NULL
	, @Required bit = NULL
	, @fkFormComboName decimal(18, 0) = NULL
	, @Tag varchar(50) = NULL
	, @fkrefAnnotationType decimal(18, 0) = NULL
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
	, @NewLineAfter bit = 0
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormAnnotation
SET	fkForm = ISNULL(@fkForm, fkForm),
	AnnotationName = ISNULL(@AnnotationName, AnnotationName),
	AnnotationFormOrder = ISNULL(@AnnotationFormOrder, AnnotationFormOrder),
	Page = ISNULL(@Page, Page),
	Deleted = ISNULL(@Deleted, Deleted),
	Mask = ISNULL(@Mask, Mask),
	Required = ISNULL(@Required, Required),
	fkFormComboName = ISNULL(@fkFormComboName, fkFormComboName),
	Tag = ISNULL(@Tag, Tag),
	fkrefAnnotationType = ISNULL(@fkrefAnnotationType, fkrefAnnotationType),
	DefaultText = ISNULL(@DefaultText, DefaultText),
	FontName = ISNULL(@FontName, FontName),
	FontSize = ISNULL(@FontSize, FontSize),
	FontStyle = ISNULL(@FontStyle, FontStyle),
	FontColor = ISNULL(@FontColor, FontColor),
	SingleUse = ISNULL(@SingleUse, SingleUse),
	fkFormAnnotationSharedObject = ISNULL(@fkFormAnnotationSharedObject, fkFormAnnotationSharedObject),
	[ReadOnly] = ISNULL(@ReadOnly, [ReadOnly]),
	Formula = ISNULL(@Formula, Formula),
	DefaultValue = @DefaultValue,
	fkAutofillViewForQuickName = ISNULL(@fkAutofillViewForQuickName, fkAutofillViewForQuickName),
	NewLineAfter = @NewLineAfter
WHERE 	pkFormAnnotation = @pkFormAnnotation
