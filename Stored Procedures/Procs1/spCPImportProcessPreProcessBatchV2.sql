

CREATE  Proc [dbo].[spCPImportProcessPreProcessBatchV2](	
	@pkCPImportBatch decimal(18,0)
)
as


/*	As some of the spreadsheets will contain blank rows from the export process,
	we need to remove all of the invalid data for the batch from the import table
	so that we do not try to process blank information.  */



/* Empty out all of the invalid fields in the import */
Update 	CPImportEISIndividual
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,FirstName = (Case When FirstName = '#EMPTY' Then Null Else FirstName End)
	,MiddleName = (Case When MiddleName = '#EMPTY' Then Null Else MiddleName End)
	,LastName = (Case When LastName = '#EMPTY' Then Null Else LastName End)
	,IndividualID = (Case When IndividualID = '#EMPTY' Then Null Else IndividualID End)
	,Sex = (Case When CaseID = '#EMPTY' Then Null Else Sex End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)

Where	fkCPImportBatch = @pkCPImportBatch

Update	CPImportEISCase  /* Name and demographic info is the case head */
Set	CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,FirstName = (Case When FirstName = '#EMPTY' Then Null Else FirstName End)
	,MiddleName = (Case When MiddleName = '#EMPTY' Then Null Else MiddleName End)
	,LastName = (Case When LastName = '#EMPTY' Then Null Else LastName End)
	,IndividualID = (Case When IndividualID = '#EMPTY' Then Null Else IndividualID End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,DistrctNo = (Case When DistrctNo = '#EMPTY' Then Null Else DistrctNo End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Sex = (Case When Sex = '#EMPTY' Then Null Else Sex End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End)
	,WorkerNumber = (Case When WorkerNumber = '#EMPTY' Then Null Else WorkerNumber End)
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportFSIS
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch


Delete from CPImportFSIS
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete CPImportEISCase
Where 
	fkCPImportBatch = @pkCPImportBatch
and	CaseID Is Null
and	CountyCaseNum Is Null
and	FirstName is Null
and	MiddleName is Null
and	LastName is Null
and	IndividualID is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null
and	ZipPlus4 is Null
and	DistrctNo is Null
and	BirthDateString is Null
and	WorkerNumber is Null

Delete from CPImportEISIndividual
Where
	fkCPImportBatch = @pkCPImportBatch
and	SSN is Null
and	caseID is null
and	FirstName is null 
and	LastName is null
and	MiddleName is Null
and	IndividualID is Null
and	BirthDateString is Null
and	Sex is Null


Update	CPImportFSIS
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9)
	,Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

update	CPImportFSIS
set		DataChecksum = BINARY_CHECKSUM (
						SSN
						,CaseID
						,CountyCaseNum
						,CaseHeadFirstName
						,CaseHeadMiddleName
						,CaseHeadLastName
						,CaseHeadIndividualID
						,ParticipantFirstName
						,ParticipantMiddleName
						,ParticipantLastName
						,ParticipantIndividualID
						,ParticipantSex
						,Street1
						,Street2
						,City
						,[State]
						,Zip
						,ZipPlus4
						,WorkerNum
						,BirthDate
						,Phone
						,CaseHeadSex)
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportEISIndividual
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9)
	,Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end

Where	fkCPImportBatch = @pkCPImportBatch


Update	CPImportEISCase
Set	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
where	fkCPImportBatch = @pkCPImportBatch


/* Clean out our tables of the invalid data */
Update 	CPImportCalWorks
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportCAPI
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportFoodStamps
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportGenAsst
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportMediCal
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportMinorConsent
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

/* Clean out our tables of the invalid data */
Update 	CPImportTANF
Set	SSN = (Case When SSN = '#EMPTY' Then Null Else SSN End)
	,CaseID = (Case When CaseID = '#EMPTY' Then Null Else CaseID End)
	,CountyCaseNum = (Case When CountyCaseNum = '#EMPTY' Then Null Else CountyCaseNum End)
	,CaseHeadFirstName = (Case When CaseHeadFirstName = '#EMPTY' Then Null Else CaseHeadFirstName End)
	,CaseHeadMiddleName = (Case When CaseHeadMiddleName = '#EMPTY' Then Null Else CaseHeadMiddleName End)
	,CaseHeadLastName = (Case When CaseHeadLastName = '#EMPTY' Then Null Else CaseHeadLastName End)
	,CaseHeadIndividualID = (Case When CaseHeadIndividualID = '#EMPTY' Then Null Else CaseHeadIndividualID End)
	,ParticipantFirstName = (Case When ParticipantFirstName = '#EMPTY' Then Null Else ParticipantFirstName End)
	,ParticipantMiddleName = (Case When ParticipantMiddleName = '#EMPTY' Then Null Else ParticipantMiddleName End)
	,ParticipantLastName = (Case When ParticipantLastName = '#EMPTY' Then Null Else ParticipantLastName End)
	,ParticipantIndividualID = (Case When ParticipantIndividualID = '#EMPTY' Then Null Else ParticipantIndividualID End)
	,ParticipantSex = (Case When ParticipantSex = '#EMPTY' Then Null Else ParticipantSex End)
	,Street1 = (Case When Street1 = '#EMPTY' Then Null Else Street1 End)
	,Street2 = (Case When Street2 = '#EMPTY' Then Null Else Street2 End)
	,City = (Case When City = '#EMPTY' Then Null Else City End)
	,[State] = (Case When [State] = '#EMPTY' Then Null Else [State] End)
	,Zip = (Case When Zip = '#EMPTY' Then Null Else Zip End)
	,ZipPlus4 = (Case When ZipPlus4 = '#EMPTY' Then Null Else ZipPlus4 End)
	,WorkerNum = (Case When WorkerNum = '#EMPTY' Then Null Else WorkerNum End)
	,BirthDateString = (Case When BirthDateString = '#EMPTY' Then Null Else BirthDateString End)
	,Phone = (Case When Phone = '#EMPTY' Then Null Else Phone End) -- Phone is NOT part of the spreadsheet
	--,EffectiveDate = (Case When EffectiveDate = '#EMPTY' Then Null Else EffectiveDate End)
Where	fkCPImportBatch = @pkCPImportBatch

Delete from CPImportCalWorks
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportCAPI
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportFoodStamps
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportGenAsst
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportMediCal
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportMinorConsent
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Delete from CPImportTANF
Where
	fkCPImportBatch = @pkCPImportBatch	
and	SSN is Null
and	CaseID is Null
and	CountyCaseNum is Null
and	CaseHeadFirstName is null
and	CaseHeadMiddleName is Null
and	CaseHeadLastName is Null
and	CaseHeadIndividualID is Null 
and	ParticipantFirstName is Null
and	ParticipantMiddleName is Null
and	ParticipantLastName is Null
and	ParticipantIndividualID is Null
and	ParticipantSex is Null
and	Street1 is Null
and	Street2 is Null
and	City is Null
and	[State] is Null
and	Zip is Null 
and ZipPlus4 is Null
and	WorkerNum is Null
and	BirthDateString is Null
and	Phone is Null

Update	CPImportCalWorks
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportCAPI
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportFoodStamps
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportGenAsst
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportMediCal
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportMinorConsent
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch

Update	CPImportTANF
Set	SSNFormatted = right('000000000' + rtrim(ltrim(isnull(SSN,''))), 9),
	Birthdate = case when isdate(BirthdateString)=1 then 
						case when convert(Datetime,BirthDateString) = '1/1/1753' then null
						else
							convert(Datetime,BirthDateString)
						end
					else null
				end
Where fkCPImportBatch = @pkCPImportBatch