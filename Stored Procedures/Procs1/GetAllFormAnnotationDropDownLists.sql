CREATE PROCEDURE [dbo].[GetAllFormAnnotationDropDownLists]

AS

select fkFormComboName, fcv.ComboValue, fcn.ComboName
from FormJoinFormComboNameFormComboValue f
inner join FormComboValue fcv on f.fkFormComboValue = fcv.pkFormComboValue
inner join FormComboName fcn on f.fkFormComboName = fcn.pkFormComboName
order by fkFormComboName
