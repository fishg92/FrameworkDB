----------------------------------------------------------------------------
-- Select a single record from FormAnnotation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationSelect]
(	@pkFormAnnotation decimal(18, 0) = NULL,
	@fkForm decimal(18, 0) = NULL,
	@AnnotationName varchar(100) = NULL,
	@AnnotationFormOrder int = NULL,
	@Page int = NULL,
	@Deleted tinyint = NULL,
	@Mask varchar(50) = NULL,
	@Required bit = NULL,
	@fkFormComboName decimal(18, 0) = NULL,
	@Tag varchar(50) = NULL,
	@fkrefAnnotationType decimal(18, 0) = NULL,
	@DefaultText varchar(2000) = NULL,
	@FontName varchar(255) = NULL,
	@FontSize float = NULL,
	@FontStyle int = NULL,
	@FontColor varchar(100) = NULL,
	@SingleUse bit = NULL,
	@fkFormAnnotationSharedObject decimal(18, 0) = NULL,
	@ReadOnly bit = NULL,
	@Formula varchar(500) = NULL,
	@DefaultValue decimal(18,5) = NULL,
	@fkAutofillViewForQuickName decimal(18,0) = NULL,
	@NewLineAfter BIT = NULL
)
AS

SELECT	pkFormAnnotation,
	fkForm,
	AnnotationName,
	AnnotationFormOrder,
	Page,
	Deleted,
	Mask,
	[Required],
	fkFormComboName,
	Tag,
	fkrefAnnotationType,
	DefaultText,
	FontName,
	FontSize,
	FontStyle,
	FontColor,
	SingleUse,
	fkFormAnnotationSharedObject,
	[ReadOnly],
	Formula,
	DefaultValue,
	fkAutofillViewForQuickName,
	NewLineAfter
FROM	FormAnnotation
WHERE 	(@pkFormAnnotation IS NULL OR pkFormAnnotation = @pkFormAnnotation)
 AND 	(@fkForm IS NULL OR fkForm = @fkForm)
 AND 	(@AnnotationName IS NULL OR AnnotationName LIKE @AnnotationName + '%')
 AND 	(@AnnotationFormOrder IS NULL OR AnnotationFormOrder = @AnnotationFormOrder)
 AND 	(@Page IS NULL OR Page = @Page)
 AND 	(@Deleted IS NULL OR Deleted = @Deleted)
 AND 	(@Mask IS NULL OR Mask LIKE @Mask + '%')
 AND 	(@Required IS NULL OR [Required] = @Required)
 AND 	(@fkFormComboName IS NULL OR fkFormComboName = @fkFormComboName)
 AND 	(@Tag IS NULL OR Tag LIKE @Tag + '%')
 AND 	(@fkrefAnnotationType IS NULL OR fkrefAnnotationType = @fkrefAnnotationType)
 AND 	(@DefaultText IS NULL OR DefaultText LIKE @DefaultText + '%')
 AND 	(@FontName IS NULL OR FontName LIKE @FontName + '%')
 AND 	(@FontSize IS NULL OR FontSize = @FontSize)
 AND 	(@FontStyle IS NULL OR FontStyle = @FontStyle)
 AND 	(@FontColor IS NULL OR FontColor LIKE @FontColor + '%')
 AND 	(@SingleUse IS NULL OR SingleUse = @SingleUse)
 AND 	(@fkFormAnnotationSharedObject IS NULL OR fkFormAnnotationSharedObject = @fkFormAnnotationSharedObject)
 AND	(@ReadOnly IS NULL OR [ReadOnly] = @ReadOnly)
 AND	(@Formula IS NULL OR Formula LIKE @Formula + '%')
 AND	(@DefaultValue IS NULL OR DefaultValue = @DefaultValue)
 AND	(@fkAutofillViewForQuickName IS NULL OR fkAutofillViewForQuickName = @fkAutofillViewForQuickName)
 AND	(@NewLineAfter IS NULL OR NewLineAfter = @NewLineAfter)
