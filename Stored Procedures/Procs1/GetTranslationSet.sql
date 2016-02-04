
CREATE proc [dbo].[GetTranslationSet]
as
select pkScreenName, Description, AppID, FriendlyDescription, Sequence from ScreenName
  order by Sequence
select pkScreenControl, controlName, fkScreenName from ScreenControl
select pkLanguage, Description, Active, DisplayText from Language
select pkTranslation, fkScreenControl, fkLanguage, Description, DisplayText, Context, Sequence from Translation
  order by Sequence, fkScreenControl, fkLanguage

SET ANSI_NULLS OFF
