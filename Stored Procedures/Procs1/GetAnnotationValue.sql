







CREATE      procedure [dbo].[GetAnnotationValue]
(	@pkAnnotation decimal(18,0),
	@UserAdded varchar(50) = NULL,
	@MaxRows int = NULL,
	@SearchText varchar(255) = NULL
)
as
	Declare @SQL varchar(2000)

	/** If the max rows passed into the proeedure is null then assume 50 **/
	If IsNull(@MaxRows,0) = 0 
	begin
		SET @MaxRows = 50
	end

	/* Build SQL Statement with current parameters */
	SET @SQL = '
		Select TOP ' + Convert(varchar(50),@MaxRows) + '
			v.AnnotationValue,
			r.pkRendition,
			r.DateLUP,
			r.CaseNumber,
			r.SSN,
			r.FirstName,
			r.LastName,
			IsNull(r.UnFinished,0) as UnFinished
		From 	AnnotationValue a
		Join 	(
			select 	pkAnnotationValue,
				Coalesce(s.AnnotationValue,m.AnnotationValue,l.AnnotationValue,h.AnnotationValue) as ''AnnotationValue''
			From 	AnnotationValue a
			Left Join AnnotationValueSmall s on a.fkAnnotationValueSmall = s.pkAnnotationValueSmall 
			Left Join AnnotationValueMedium m on a.fkAnnotationValueMedium = m.pkAnnotationValueMedium 
			Left Join AnnotationValueLarge l on a.fkAnnotationValueLarge = l.pkAnnotationValueLarge 
			Left Join AnnotationValueHuge h on a.fkAnnotationValueHuge = h.pkAnnotationValueHuge 
			Where 	a.fkAnnotation = ' + Convert(varchar(50),@pkAnnotation) + '
			) v on a.pkAnnotationValue = v.pkAnnotationValue
		Join	Rendition r on a.fkRendition = r.pkRendition	
		Where 	a.fkAnnotation = ' + Convert(varchar(50),@pkAnnotation)

	If IsNull(@UserAdded,'') <> ''
	begin
		SET @SQL = @SQL + ' AND r.UserLUP = ' + @UserAdded
	end

	If IsNull(@SearchText,'') <> '' 
	begin
		SET @SQL = @SQL + ' AND v.AnnotationValue like ''' + @SearchText + '%'''
	end

	SET @SQL = @SQL + ' ORDER BY r.pkRendition DESC ' 

	Exec(@SQL)

