CREATE PROCEDURE [dbo].[GetAnnotationsForFormFavorite] (
	@pkApplicationUser as decimal(18,0),
	@pkFormQuickListFormName as decimal(18,0))
AS
BEGIN
	
	SET NOCOUNT ON;
	
   -- get annotations
   select fa.fkRefAnnotationType, fa.pkFormAnnotation, fa.AnnotationName, fa.Page, fa.AnnotationFormOrder, fap.x, fap.y, fap.Width, fap.Height, 
   fa.FontSize, fa.DefaultText, fjqlfnaav.AnnotationValue, fqlfn.pkFormQuickListFormName, isnull(fa.Mask, '') Mask, fa.Required, fa.FontStyle, fa.FontColor, 
isnull(fa.SingleUse, 0) SingleUse, fa.fkFormAnnotationSharedObject, isnull(fa.ReadOnly, 0) ReadOnly, isnull(fa.Formula, '') Formula, 
fkFormComboName, fa.DefaultValue, fa.NewLineAfter
from formquicklistfolder folder
	inner join FormQuickListFolderName name 
		on folder.fkFormQuickListFolderName = name.pkFormQuickListFolderName
	inner join FormJoinQuickListFormFolderQuickListFormName JFF 
		on jff.fkFormQuickListFolder = folder.pkFormQuickListFolder
	inner join FormQuickListFormName fqlfn 
		on fqlfn.pkFormQuickListFormName = jff.fkFormQuickListFormName
	inner join FormAnnotation fa on fa.fkform = fqlfn.fkformname
	inner join FormAnnotationPosition fap on fap.fkFormAnnotation = fa.pkFormAnnotation
	left outer join FormJoinQuickListFormNameAnnotationAnnotationValue fjqlfnaav on fjqlfnaav.fkQuickListFormName = fqlfn.pkFormQuickListFormName and
			fjqlfnaav.fkFormAnnotation = fa.pkFormAnnotation
	where name.QuickListFolderName = 'CoPilot_Sync'
		and fqlfn.CreateUser = @pkApplicationUser and fqlfn.pkFormQuickListFormName = @pkFormQuickListFormName and fqlfn.Inactive = 0 and fa.Deleted = 0
	order by fqlfn.QuickListFormName,fqlfn.CreateDate


	-- get stamps
	select stamp.pkFormQuickListAdditionalStamp, stamp.Page, stamp.X, stamp.Y, stamp.Width, stamp.Height, stamp.Bitmap, stamp.AdditionalData, 
	stamp.fkrefAnnotationType, stamp.fkFormQuickListFormName from formquicklistfolder folder
	inner join FormQuickListFolderName name 
		on folder.fkFormQuickListFolderName = name.pkFormQuickListFolderName
	inner join FormJoinQuickListFormFolderQuickListFormName JFF 
		on jff.fkFormQuickListFolder = folder.pkFormQuickListFolder
	inner join FormQuickListFormName fname 
		on fname.pkFormQuickListFormName = jff.fkFormQuickListFormName
	inner join FormQuickListAdditionalStamp stamp 
		on stamp.fkFormQuickListFormName = fname.pkFormQuickListFormName
	where name.QuickListFolderName = 'CoPilot_Sync'
		and fname.CreateUser = @pkApplicationUser and stamp.fkFormQuickListFormName = @pkFormQuickListFormName
	order by fname.QuickListFormName,fname.CreateDate
 
END
