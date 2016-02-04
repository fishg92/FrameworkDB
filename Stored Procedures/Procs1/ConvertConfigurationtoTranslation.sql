CREATE proc [dbo].[ConvertConfigurationtoTranslation]

as

declare @fklanguage decimal
declare @language varchar(50)

declare crLanguage cursor 
for 
	select pklanguage, [description]
	from [language]

	open crLanguage
		fetch next from crLanguage into @fklanguage, @language
		while @@fetch_status = 0
begin
	update trans 
	set trans.DisplayText = Config.ItemValue
	from translation trans inner join Configuration Config
	on ltrim(rtrim(trans.ItemKey))=ltrim(rtrim(Config.ItemKey))
	where fklanguage = @fklanguage and [grouping] =   @language
	
	update [language]
	set [language].DisplayText = (Select ItemValue 
								  from Configuration
								  where ltrim(rtrim(ItemKey)) = 'SelfScanKiosk' + @language + 'Localized')
	where pkLanguage = @fklanguage
	and Exists (Select ItemValue 
				from Configuration
				where ltrim(rtrim(ItemKey)) = 'SelfScanKiosk' + @language + 'Localized')
				
	update [language]
	set [language].Active = (Select Upper(ItemValue) 
								  from Configuration
								  where ltrim(rtrim(ItemKey)) = 'SelfScanKioskDisplay' + @language)
	where pkLanguage = @fklanguage
	and Exists (Select ItemValue 
				from Configuration
				where ltrim(rtrim(ItemKey)) = 'SelfScanKioskDisplay' + @language)
	
	fetch next from crLanguage into @fklanguage, @language
end

close crLanguage
deallocate crLanguage

If exists (Select ItemValue
			from Configuration
			where ItemKey = 'SSKLabelSelectALanguageText'
			and [Grouping] = 'English')
	begin
		declare @newValue Varchar(300)
		set @newValue = (Select ItemValue
						from Configuration
						where ItemKey = 'SSKLabelSelectALanguageText'
						and [Grouping] = 'English')
	
		If exists (Select ItemValue
					from Configuration
					where ItemKey = 'LanguageScreenCaption')
			begin
				Update Configuration
				Set ItemValue = @newValue
				where ItemKey = 'LanguageScreenCaption'
			end
		Else
			begin
				Insert Configuration
				(	  
					[Grouping]
					, ItemKey
					, ItemValue
					, ItemDescription
					, AppID
					, Sequence
				)
				Values
				(	
					''
					, 'LanguageScreenCaption'
					, @newValue
					, ''
					, 20
					, 0
				)
			end
	end