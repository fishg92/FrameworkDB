
CREATE PROC [dbo].[usp_UpdateChildAutofillSchemaDataViewColumns]
(@pkAutofillSchema decimal
,@DateBeforeParentsUpdated datetime
)

As
/* delete viewcolumns records that pointed to fields that are no longer part of the parent data source columns */
delete from dbo.AutofillSchemaDataViewColumns where 
	fkAutoFillSchemaColumns 
--	dbo.[fnGetAutoFillSchemaColumnName] (fkAutoFillSchemaColumns,@DateBeforeParentsUpdated)
not in 
(select pkAutofillSchemaColumns from AutofillSchemaColumns where fkAutofillSchema = @pkAutofillSchema)
--(select FieldName from AutofillSchemaColumns where fkAutofillSchema = @pkAutofillSchema)
and fkAutofillSchemaDataView in 
(select pkAutofillSchemaDataView from AutofillSchemaDataView where fkAutofillSchema = @pkAutofillSchema)

/* update fk refrence on any fields that still exist in the parent but have a new pk */
/* THE UI DOES NOT PROVIDE A WAY THAT THIS CAN HAPPEN, COMMENTING OUT THE CODE 
update dbo.AutofillSchemaDataViewColumns 
set fkAutofillSchemaColumns = (select pkAutofillSchemaColumns from AutofillSchemaColumns
		where FieldName =  dbo.[fnGetAutoFillSchemaColumnName] (fkAutoFillSchemaColumns,@DateBeforeParentsUpdated) )
where 
	 dbo.[fnGetAutoFillSchemaColumnName] (fkAutoFillSchemaColumns,@DateBeforeParentsUpdated) <>
		dbo.[fnGetAutoFillSchemaColumnName] (fkAutoFillSchemaColumns,getdate())
*/

/* add matching fields to dataviews when they now exist in the parent */
insert into AutofillSchemaDataViewColumns 
	(fkAutofillSchemaColumns
	,fkAutofillSchemaDataView
	,FriendlyName
	,Visible
	,SortOrder)
	select 
	pkAutofillSchemaColumns
	, adv.pkAutofillSchemaDataView
	, FieldName
	, 0
	, 0  		
		from AutofillSchemaColumns sc 
		inner join AutofillSchemaDataView adv on adv.fkAutofillSchema = @pkAutofillSchema
		where sc.fkAutofillSchema = @pkAutofillSchema and sc.pkAutofillSchemaColumns not in
		(select vc.fkAutofillSchemaColumns from AutofillSchemaDataViewColumns vc)


exec [usp_UpdateSortOrderOfAutofillSchemaDataViewForChangedAutofillSchema] @DateBeforeParentsUpdated, @pkAutofillSchema
