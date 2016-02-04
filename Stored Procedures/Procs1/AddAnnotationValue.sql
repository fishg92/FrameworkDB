




/****** Object:  Stored Procedure dbo.AddAnnotationValue    Script Date: 8/21/2006 8:02:14 AM ******/




CREATE    PROCEDURE [dbo].[AddAnnotationValue]
(	@pkRendition decimal(18,0),
	@pkAnnotation decimal(18,0),
	@AnnotationValue varchar(2000)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	
)
as

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Declare @Len int,
		@pkRet int

	Set @Len = Len(@AnnotationValue)
	If @Len Is Null 
	begin
		Set @Len = 0
	end	

	If @Len <= 25
	begin
		If not Exists(Select pkAnnotationValueSmall from AnnotationValueSmall WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		begin
			Insert into AnnotationValueSmall(AnnotationValue) 
			Values(@AnnotationValue)
	
			Set @pkRet = Scope_Identity()
		end
		Else
		begin
			Set @pkRet = (Select Max(pkAnnotationValueSmall) from AnnotationValueSmall WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		end

		/* JM 8-30-04 */
		If Exists(Select pkAnnotationValue From AnnotationValue WITH (NOLOCK) Where fkRendition = @pkRendition and fkAnnotation = @pkAnnotation)
		begin
			Update	AnnotationValue
			Set 	fkAnnotationValueSmall = @pkRet
			Where	fkRendition = @pkRendition 
			and	fkAnnotation = @pkAnnotation
		end
		Else
		begin
			INSERT INTO AnnotationValue(fkAnnotationValueSmall,fkRendition,fkAnnotation)
			VALUES(@pkRet,@pkRendition,@pkAnnotation)
		end
	end
	Else If @Len > 25 and @Len <= 100
	begin
		If not Exists(Select pkAnnotationValueMedium from AnnotationValueMedium WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		begin
			Insert into AnnotationValueMedium(AnnotationValue)
			Values(@AnnotationValue)
	
			Set @pkRet = Scope_Identity()
		end
		Else
		begin
			Set @pkRet = (Select Max(pkAnnotationValueMedium) from AnnotationValueMedium WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		end

		/* JM 8-30-04 */
		If Exists(Select pkAnnotationValue From AnnotationValue WITH (NOLOCK) Where fkRendition = @pkRendition and fkAnnotation = @pkAnnotation)
		begin
			Update	AnnotationValue
			Set 	fkAnnotationValueMedium = @pkRet
			Where	fkRendition = @pkRendition 
			and	fkAnnotation = @pkAnnotation
		end
		Else
		begin
			Insert INTO AnnotationValue(fkAnnotationValueMedium,fkRendition,fkAnnotation)
			Values(@pkRet,@pkRendition,@pkAnnotation)
		end

	end
	Else If @Len > 100 and @Len <= 500
	begin
		If not Exists(Select pkAnnotationValueLarge from AnnotationValueLarge WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		begin
			Insert into AnnotationValueLarge(AnnotationValue)
			Values(@AnnotationValue)
	
			Set @pkRet = Scope_Identity()
		end
		Else
		begin
			Set @pkRet = (Select Max(pkAnnotationValueLarge) from AnnotationValueLarge WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		end

		/* JM 8-30-04 */
		If Exists(Select pkAnnotationValue From AnnotationValue WITH (NOLOCK) Where fkRendition = @pkRendition and fkAnnotation = @pkAnnotation)
		begin
			Update	AnnotationValue
			Set 	fkAnnotationValueLarge = @pkRet
			Where	fkRendition = @pkRendition 
			and	fkAnnotation = @pkAnnotation
		end
		Else
		begin
			Insert 	AnnotationValue(fkAnnotationValueLarge,fkRendition,fkAnnotation)
			Values(@pkRet,@pkRendition,@pkAnnotation)
		end

	end
	Else If @Len > 500 
	begin
		If not Exists(Select pkAnnotationValueHuge from AnnotationValueHuge WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		begin
			Insert into AnnotationValueHuge(AnnotationValue)
			Values(@AnnotationValue)
	
			Set @pkRet = Scope_Identity()
		end
		Else
		begin
			Set @pkRet = (Select Max(pkAnnotationValueHuge) from AnnotationValueHuge WITH (NOLOCK) where AnnotationValue = @AnnotationValue)
		end

		/* JM 8-30-04 */
		If Exists(Select pkAnnotationValue From AnnotationValue WITH (NOLOCK) Where fkRendition = @pkRendition and fkAnnotation = @pkAnnotation)
		begin
			Update	AnnotationValue
			Set 	fkAnnotationValueHuge = @pkRet
			Where	fkRendition = @pkRendition 
			and	fkAnnotation = @pkAnnotation
		end
		Else
		begin
			Insert 	AnnotationValue(fkAnnotationValueHuge,fkRendition,fkAnnotation)
			Values(@pkRet,@pkRendition,@pkAnnotation)
		end
	end
