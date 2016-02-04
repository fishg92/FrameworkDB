

CREATE  Proc [dbo].[spCPImportProcessSpreadsheetCleanup]	
as
set nocount on
/*	As some of the spreadsheets will contain blank rows from the export process,
	we need to remove all of the invalid data for the batch from the import table
	so that we do not try to process blank information.  */

/* Empty out all of the invalid fields in the import */
Update 	CPImportStaging
SET FirstName			= (Case When FirstName = '#EMPTY' Then Null Else FirstName End)
  , MiddleName			= (Case When MiddleName = '#EMPTY' Then Null Else MiddleName End)
  , LastName			= (Case When LastName = '#EMPTY' Then Null Else LastName End)
  , Suffix				= (Case When Suffix = '#EMPTY' Then Null Else Suffix End)
  , SSN					= (Case When SSN = '#EMPTY' Then Null Else SSN End)
  , UniqueID			= (Case When UniqueID = '#EMPTY' Then Null Else UniqueID End)
  , BirthLocation		= (Case When BirthLocation = '#EMPTY' Then Null Else BirthLocation End)
  , Sex					= (Case When Sex = '#EMPTY' Then Null Else Sex End)
  , Education			= (Case When Education = '#EMPTY' Then Null Else Education End)
  , MaidenName			= (Case When MaidenName = '#EMPTY' Then Null Else MaidenName End)
  , SchoolName			= (Case When SchoolName = '#EMPTY' Then Null Else SchoolName End)
  , MailingStreet1		= (Case When MailingStreet1 = '#EMPTY' Then Null Else MailingStreet1 End)
  , MailingStreet2		= (Case When MailingStreet2 = '#EMPTY' Then Null Else MailingStreet2 End)
  , MailingStreet3		= (Case When MailingStreet3 = '#EMPTY' Then Null Else MailingStreet3 End)
  , MailingCity			= (Case When MailingCity = '#EMPTY' Then Null Else MailingCity End)
  , MailingState		= (Case When MailingState = '#EMPTY' Then Null Else MailingState End)
  , MailingZip			= (Case When MailingZip = '#EMPTY' Then Null Else MailingZip End)
  , MailingZipPlus4		= (Case When MailingZipPlus4 = '#EMPTY' Then Null Else MailingZipPlus4 End)
  , PhysicalStreet1		= (Case When PhysicalStreet1 = '#EMPTY' Then Null Else PhysicalStreet1 End)
  , PhysicalStreet2		= (Case When PhysicalStreet2 = '#EMPTY' Then Null Else PhysicalStreet2 End)
  , PhysicalStreet3		= (Case When PhysicalStreet3 = '#EMPTY' Then Null Else PhysicalStreet3 End)
  , PhysicalCity		= (Case When PhysicalCity = '#EMPTY' Then Null Else PhysicalCity End)
  , PhysicalState		= (Case When PhysicalState = '#EMPTY' Then Null Else PhysicalState End)
  , PhysicalZip			= (Case When PhysicalZip = '#EMPTY' Then Null Else PhysicalZip End)
  , PhysicalZipPlus4	= (Case When PhysicalZipPlus4 = '#EMPTY' Then Null Else PhysicalZipPlus4 End)
  , HomePhoneNumber		= (Case When HomePhoneNumber = '#EMPTY' Then Null Else HomePhoneNumber End)
  , CellPhoneNumber		= (Case When CellPhoneNumber = '#EMPTY' Then Null Else CellPhoneNumber End)
  , CaseWorkerNumber	= (Case When CaseWorkerNumber = '#EMPTY' Then Null Else CaseWorkerNumber End)
  , CaseHead			=  isnull(CaseHead,0)
  , StateCaseNumber		= (Case When StateCaseNumber = '#EMPTY' Then Null Else StateCaseNumber End)
  , LocalCaseNumber		= (Case When LocalCaseNumber = '#EMPTY' Then Null Else LocalCaseNumber End)			
  , ProgramType			= (Case When ProgramType = '#EMPTY' Then Null Else ProgramType End)
  , Data1				= (Case When Data1 = '#EMPTY' Then Null Else Data1 End)
  , Data2				= (Case When Data2 = '#EMPTY' Then Null Else Data2 End)
  , Data3				= (Case When Data3 = '#EMPTY' Then Null Else Data3 End)
  , Data4				= (Case When Data4 = '#EMPTY' Then Null Else Data4 End)
  , Data5				= (Case When Data5 = '#EMPTY' Then Null Else Data5 End)
  , Data6				= (Case When Data6 = '#EMPTY' Then Null Else Data6 End)
  , Data7				= (Case When Data7 = '#EMPTY' Then Null Else Data7 End)
  , Data8				= (Case When Data8 = '#EMPTY' Then Null Else Data8 End)
  , Data9				= (Case When Data9 = '#EMPTY' Then Null Else Data9 End)
  , Data10				= (Case When Data10 = '#EMPTY' Then Null Else Data10 End)
  , Data11				= (Case When Data11 = '#EMPTY' Then Null Else Data11 End)
  , Data12				= (Case When Data12 = '#EMPTY' Then Null Else Data12 End)
  , Data13				= (Case When Data13 = '#EMPTY' Then Null Else Data13 End)
  , Data14				= (Case When Data14 = '#EMPTY' Then Null Else Data14 End)
  , Data15				= (Case When Data15 = '#EMPTY' Then Null Else Data15 End)
  , Data16				= (Case When Data16 = '#EMPTY' Then Null Else Data16 End)
  , Data17				= (Case When Data17 = '#EMPTY' Then Null Else Data17 End)
  , Data18				= (Case When Data18 = '#EMPTY' Then Null Else Data18 End)
  , Data19				= (Case When Data19 = '#EMPTY' Then Null Else Data19 End)
  , Data20				= (Case When Data20 = '#EMPTY' Then Null Else Data20 End)
  , Data21				= (Case When Data21 = '#EMPTY' Then Null Else Data21 End)
  , Data22				= (Case When Data22 = '#EMPTY' Then Null Else Data22 End)
  , Data23				= (Case When Data23 = '#EMPTY' Then Null Else Data23 End)
  , Data24				= (Case When Data24 = '#EMPTY' Then Null Else Data24 End)
  , Data25				= (Case When Data25 = '#EMPTY' Then Null Else Data25 End)
  , Data26				= (Case When Data26 = '#EMPTY' Then Null Else Data26 End)
  , Data27				= (Case When Data27 = '#EMPTY' Then Null Else Data27 End)
  , Data28				= (Case When Data28 = '#EMPTY' Then Null Else Data28 End)
  , Data29				= (Case When Data29 = '#EMPTY' Then Null Else Data29 End)
  , Data30				= (Case When Data30 = '#EMPTY' Then Null Else Data30 End)
  , Data31				= (Case When Data31 = '#EMPTY' Then Null Else Data31 End)
  , Data32				= (Case When Data32 = '#EMPTY' Then Null Else Data32 End)
  , Data33				= (Case When Data33 = '#EMPTY' Then Null Else Data33 End)
  , Data34				= (Case When Data34 = '#EMPTY' Then Null Else Data34 End)
  , Data35				= (Case When Data35 = '#EMPTY' Then Null Else Data35 End)
  , Data36				= (Case When Data36 = '#EMPTY' Then Null Else Data36 End)
  , Data37				= (Case When Data37 = '#EMPTY' Then Null Else Data37 End)
  , Data38				= (Case When Data38 = '#EMPTY' Then Null Else Data38 End)
  , Data39				= (Case When Data39 = '#EMPTY' Then Null Else Data39 End)
  , Data40				= (Case When Data40 = '#EMPTY' Then Null Else Data40 End)
from CPImportStaging

/*Here is where we decide what bad rows will not be imported */
Delete from CPImportStaging
Where UniqueID is Null

