
CREATE PROCEDURE [dbo].[spCPImportNomadsActive]
AS

SET NOCOUNT ON


/* get batch id */
declare @fkCPImportBatch decimal(18,0)

Insert	CPImportBatch
	(
		CreateUser,
		CreateDate
	)
Values
	(
		User,
		GetDate()
	)

SELECT @fkCPImportBatch = CAST(SCOPE_IDENTITY() AS int) 

exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Searching ALL Cases in NOMADS for member info'

Declare ImportFSISCursor cursor For
SELECT *

/**Swap DummyTable for the commented code**/
from DummyTable

--FROM OPENQUERY(NOMADSPROD, 'SELECT DISTINCT 
--CHAR(CURRENT DATE,USA) || '' '' || rtrim(CHAR(hour(CURRENT TIME))) || '':'' || rtrim(CHAR(minute(CURRENT TIME))) || '':'' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,
--CHAR(T1.SSN) AS Social_Security_Number,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,
--T8.INIT_DCKT_NMB AS County_Case_Number,
--RTRIM(T1.FRST_NM) AS Casehead_First_Name,
--RTRIM(T1.MID_NM) AS Casehead_Middle_Initial,
--RTRIM(T1.LST_NM) AS Casehead_Last_Name,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,
--CHAR(T1.DOB,USA) AS Casehead_Birth_Date,
--T1.SEX_CD AS Casehead_Sex_Code,
--RTRIM(T1.FRST_NM) AS First_Name,
--RTRIM(T1.MID_NM) AS Middle_Initial,
--RTRIM(T1.LST_NM) AS Last_Name,
--SUBSTR(DIGITS(T1.UPI),2,9) AS Individual_Id,
--T1.SEX_CD AS Sex_Code,
--LTRIM(RTRIM(T3.HOUSE_NMB)) || '' '' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '' '' || LTRIM(RTRIM(T3.STR_NM)))) || '' '' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,
--LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '' '' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,
--LTRIM(RTRIM(T3.CITY)) as City,
--LTRIM(RTRIM(T3.ST_CD)) AS State,
--SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,
--SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,
--RTRIM(T5.NOMADS_USRID) AS state_worker_id,
--CHAR(T1.DOB,USA) AS Birth_Date
--FROM W100DP1.TWNIVD_CASE T2

--LEFT OUTER JOIN W100DP1.TWNPERSON T1
--ON T1.UPI = T2.NCP_UPI

--LEFT OUTER JOIN W100DP1.TWNPERSON_ADRS_HST T3
--ON T2.NCP_UPI = T3.UPI
--AND T3.ADR_TYPE = ''CM''
--AND T3.ADR_STS IN (''C'', ''V'')

--LEFT OUTER JOIN W100DP1.TWNIVD_CASELD_CASE T4
--ON T2.NCP_UPI = T4.UPI
--AND T2.CASE_SUFX = T4.CASE_SUFX
--AND T4.CASELD_IND = ''N''

--LEFT OUTER JOIN W100DP1.TWNSUP_UNT_POS_HST T5
--ON T4.OFC_CD = T5.OFC_CD
--AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE
--AND T4.SPRVS_UNIT = T5.SPRVS_UNIT
--AND T4.PSN_NMB    = T5.PSN_NMB
--AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT

--LEFT OUTER JOIN W100DP1.TWNDOCKET T8
--ON T2.NCP_UPI = T8.UPI
--AND T2.CASE_SUFX = T8.CASE_SUFX

--WHERE T2.CASE_STS IN (''A'', ''P'') AND T1.SSN < ''998000000''	--use to load active/pending only

--UNION
--SELECT DISTINCT 
--CHAR(CURRENT DATE,USA) || '' '' || rtrim(CHAR(hour(CURRENT TIME))) || '':'' || rtrim(CHAR(minute(CURRENT TIME))) || '':'' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,
--T6.SSN AS Social_Security_Number,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,
--T8.INIT_DCKT_NMB AS County_Case_Number,
--RTRIM(T1.FRST_NM) AS Casehead_First_Name,
--RTRIM(T1.MID_NM) AS Casehead_Middle_Initial,
--RTRIM(T1.LST_NM) AS Casehead_Last_Name,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,
--CHAR(T1.DOB,USA) AS Casehead_Birth_Date,
--T1.SEX_CD AS Casehead_Sex_Code,
--RTRIM(T6.FRST_NM) AS First_Name,
--RTRIM(T6.MID_NM) AS Middle_Initial,
--RTRIM(T6.LST_NM) AS Last_Name,
--SUBSTR(DIGITS(T6.UPI),2,9) AS Individual_Id,
--T6.SEX_CD AS Sex_Code,
--LTRIM(RTRIM(T3.HOUSE_NMB)) || '' '' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '' '' || LTRIM(RTRIM(T3.STR_NM)))) || '' '' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,
--LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '' '' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,
--LTRIM(RTRIM(T3.CITY)) as City,
--LTRIM(RTRIM(T3.ST_CD)) AS State,
--SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,
--SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,
--LTRIM(RTRIM(T5.NOMADS_USRID)) AS state_worker_id,
--CHAR(T6.DOB,USA) AS Birth_Date
--FROM W100DP1.TWNIVD_CASE T2

--LEFT OUTER JOIN W100DP1.TWNPERSON T1
--ON T1.UPI = T2.NCP_UPI

--LEFT OUTER JOIN W100DP1.TWNPERSON T6
--ON T2.CST_UPI = T6.UPI

--LEFT OUTER JOIN W100DP1.TWNPERSON_ADRS_HST T3
--ON T6.UPI = T3.UPI
--AND T3.ADR_TYPE = ''CM''
--AND T3.ADR_STS IN (''C'', ''V'')

--LEFT OUTER JOIN W100DP1.TWNIVD_CASELD_CASE T4
--ON T2.NCP_UPI = T4.UPI
--AND T2.CASE_SUFX = T4.CASE_SUFX
--AND T4.CASELD_IND = ''N''

--LEFT OUTER JOIN W100DP1.TWNSUP_UNT_POS_HST T5
--ON T4.OFC_CD = T5.OFC_CD
--AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE
--AND T4.SPRVS_UNIT = T5.SPRVS_UNIT
--AND T4.PSN_NMB    = T5.PSN_NMB
--AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT

--LEFT OUTER JOIN W100DP1.TWNDOCKET T8
--ON T2.NCP_UPI = T8.UPI
--AND T2.CASE_SUFX = T8.CASE_SUFX

--WHERE T2.CASE_STS IN (''A'', ''P'') AND T1.SSN < ''998000000'' AND T6.SSN < ''998000000''	--use to load active/pending only
----WHERE T1.SSN < ''998000000'' AND T6.SSN < ''998000000''

--UNION
--SELECT DISTINCT 
--CHAR(CURRENT DATE,USA) || '' '' || rtrim(CHAR(hour(CURRENT TIME))) || '':'' || rtrim(CHAR(minute(CURRENT TIME))) || '':'' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,
--T6.SSN AS Social_Security_Number,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,
--T8.INIT_DCKT_NMB AS County_Case_Number,
--LTRIM(RTRIM(T1.FRST_NM)) AS Casehead_First_Name,
--LTRIM(RTRIM(T1.MID_NM)) AS Casehead_Middle_Initial,
--LTRIM(RTRIM(T1.LST_NM)) AS Casehead_Last_Name,
--SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,
--CHAR(T1.DOB,USA) AS Casehead_Birth_Date,
--T1.SEX_CD AS Casehead_Sex_Code,
--LTRIM(RTRIM(T6.FRST_NM)) AS First_Name,
--LTRIM(RTRIM(T6.MID_NM)) AS Middle_Initial,
--LTRIM(RTRIM(T6.LST_NM)) AS Last_Name,
--SUBSTR(DIGITS(T6.UPI),2,9) AS Individual_Id,
--T6.SEX_CD AS Sex_Code,
--LTRIM(RTRIM(T3.HOUSE_NMB)) || '' '' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '' '' || LTRIM(RTRIM(T3.STR_NM)))) || '' '' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,
--LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '' '' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,
--LTRIM(RTRIM(T3.CITY)) as City,
--LTRIM(RTRIM(T3.ST_CD)) AS State,
--SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,
--SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,
--LTRIM(RTRIM(T5.NOMADS_USRID)) AS state_worker_id,
--CHAR(T6.DOB,USA) AS Birth_Date
--FROM W100DP1.TWNIVD_CASE T2

--LEFT OUTER JOIN W100DP1.TWNPERSON T1
--ON T1.UPI = T2.NCP_UPI

--LEFT OUTER JOIN W100DP1.TWNIVD_CASELD_CASE T4
--ON T2.NCP_UPI = T4.UPI
--AND T2.CASE_SUFX = T4.CASE_SUFX
--AND T4.CASELD_IND = ''N''

--LEFT OUTER JOIN W100DP1.TWNSUP_UNT_POS_HST T5
--ON T4.OFC_CD = T5.OFC_CD
--AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE
--AND T4.SPRVS_UNIT = T5.SPRVS_UNIT
--AND T4.PSN_NMB    = T5.PSN_NMB
--AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT

--LEFT OUTER JOIN W100DP1.TWNIVD_CASE_CHILD T7
--ON T2.NCP_UPI = T7.NCP_UPI
--AND T2.CASE_SUFX = T7.CASE_SUFX
--AND T4.UPI = T7.NCP_UPI
--AND T4.CASE_SUFX = T7.CASE_SUFX

--LEFT OUTER JOIN W100DP1.TWNPERSON T6
--ON T7.CHD_UPI = T6.UPI

--LEFT OUTER JOIN W100DP1.TWNPERSON_ADRS_HST T3
--ON T6.UPI = T3.UPI
--AND T3.ADR_TYPE = ''CM''
--AND T3.ADR_STS IN (''C'', ''V'')

--LEFT OUTER JOIN W100DP1.TWNDOCKET T8
--ON T2.NCP_UPI = T8.UPI
--AND T2.CASE_SUFX = T8.CASE_SUFX

--WHERE T2.CASE_STS IN (''A'', ''P'') AND T1.SSN < ''998000000'' AND T6.SSN < ''998000000''	--use to load active/pending only
----WHERE T1.SSN < ''998000000'' AND T6.SSN < ''998000000''

--UNION ALL
--SELECT
--CAST(''Daily FSIS Load Date'' as VARCHAR(20)),
--CAST(''Social Security Number'' as VARCHAR(20)),
--CAST(''FSIS Case Id'' as VARCHAR(50)),
--CAST(''County Case Num'' as VARCHAR(50)),
--CAST(''Casehead First Name'' as VARCHAR(50)),
--CAST(''Casehead Midde Initial'' as VARCHAR(50)),
--CAST(''Casehead Last Name'' as VARCHAR(50)),
--CAST(''Casehead Individual Id'' as VARCHAR(50)),
--CAST(''Casehead Birth Date'' as VARCHAR(10)),
--CAST(''Casehead Sex Code'' as VARCHAR(17)),
--CAST(''First Name'' as VARCHAR(50)),
--CAST(''Middle Initial'' as VARCHAR(50)),
--CAST(''Last Name'' as VARCHAR(50)),
--CAST(''Individual Id'' as VARCHAR(50)),
--CAST(''Sex Code'' as VARCHAR(10)),
--CAST(''Address Line 1'' as VARCHAR(50)),
--CAST(''Address Line 2'' as VARCHAR(50)),
--CAST(''City'' as VARCHAR(100)),
--CAST(''State'' as VARCHAR(50)),
--CAST(''Zip Code'' as VARCHAR(5)),
--CAST(''Zip Code Plus 4'' as VARCHAR(4)),
--CAST(''State Worker Id'' as VARCHAR(20)),
--CAST(''Birth Date'' as VARCHAR(10))
--FROM sysibm.sysdummy1
--WITH UR')

exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Query complete, loading clients'


 declare @Daily_FSIS_Load_Date Varchar(20)
		,@Social_Security_Number VARCHAR(20)
		,@FSIS_Case_Id VARCHAR(50)
		,@County_Case_Num VARCHAR(50)
		,@Casehead_First_Name VARCHAR(50)
		,@Casehead_Midde_Initial VARCHAR(50)
		,@Casehead_Last_Name VARCHAR(50)
		,@Casehead_Individual_Id VARCHAR(50)
		,@Casehead_Birth_Date VARCHAR(10)
		,@Casehead_Sex_Code VARCHAR(17)
		,@First_Name VARCHAR(50)
		,@Middle_Initial VARCHAR(50)
		,@Last_Name VARCHAR(50)
		,@Individual_Id VARCHAR(50)
		,@Sex_Code VARCHAR(10)
		,@Address_Line_1 VARCHAR(50)
		,@Address_Line_2 VARCHAR(50)
		,@City VARCHAR(100)
		,@State varchar(50)
		,@Zip_Code VARCHAR(5)
		,@Zip_Code_Plus_4 VARCHAR(4)
		,@State_Worker_Id VARCHAR(20)
		,@Birth_Date VARCHAR(10)

Open ImportFSISCursor

Fetch Next
from ImportFSISCursor 
into  	@Daily_FSIS_Load_Date 
		,@Social_Security_Number
		,@FSIS_Case_Id 
		,@County_Case_Num 
		,@Casehead_First_Name 
		,@Casehead_Midde_Initial
		,@Casehead_Last_Name 
		,@Casehead_Individual_Id 
		,@Casehead_Birth_Date 
		,@Casehead_Sex_Code 
		,@First_Name 
		,@Middle_Initial 
		,@Last_Name 
		,@Individual_Id 
		,@Sex_Code 
		,@Address_Line_1 
		,@Address_Line_2 
		,@City
		,@State 
		,@Zip_Code 
		,@Zip_Code_Plus_4 
		,@State_Worker_Id 
		,@Birth_Date 

/*-- skip the header */
if @@FETCH_STATUS = 0 
	begin
	Fetch Next
	from	ImportFSISCursor 
	into	@Daily_FSIS_Load_Date 
			,@Social_Security_Number
			,@FSIS_Case_Id 
			,@County_Case_Num 
			,@Casehead_First_Name 
			,@Casehead_Midde_Initial
			,@Casehead_Last_Name 
			,@Casehead_Individual_Id 
			,@Casehead_Birth_Date 
			,@Casehead_Sex_Code 
			,@First_Name 
			,@Middle_Initial 
			,@Last_Name 
			,@Individual_Id 
			,@Sex_Code 
			,@Address_Line_1 
			,@Address_Line_2 
			,@City
			,@State 
			,@Zip_Code 
			,@Zip_Code_Plus_4 
			,@State_Worker_Id 
			,@Birth_Date 

	end

While @@FETCH_STATUS = 0
	begin
	insert into CPImportFSIS
		(
			fkCPImportBatch
			,SSN
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
			,State
			,Zip
			,ZipPlus4
			,WorkerNum
			,BirthDate
			,Phone
			,EffectiveDate
			,ProcessDate
			,CityState
			,SSNFormatted
			,BirthDateString
			,CaseHeadBirthDateString
			,CaseHeadSex
		)
	Values 
		(
			@fkCPImportBatch
			,substring(@Social_Security_Number,1,20)
			,@FSIS_Case_Id 
			,@County_Case_Num 
			,@Casehead_First_Name 
			,@Casehead_Midde_Initial
			,@Casehead_Last_Name
			,@Casehead_Individual_Id 
			,@First_Name 
			,@Middle_Initial 
			,@Last_Name 
			,@Individual_Id 
			,@Sex_Code
			,@Address_Line_1 
			,@Address_Line_2 
			,@City
			,@State
			,@Zip_Code 
			,substring(@Zip_Code_Plus_4 ,1,10)
			,@State_Worker_Id
			,null
			,null
			,@Daily_FSIS_Load_Date 
			,null
			,null
			,null
			,@Birth_Date
			,@Casehead_Birth_Date
			,@Casehead_Sex_Code
		)
		
	Fetch Next 
	from ImportFSISCursor 
	into	@Daily_FSIS_Load_Date 
			,@Social_Security_Number
			,@FSIS_Case_Id 
			,@County_Case_Num 
			,@Casehead_First_Name 
			,@Casehead_Midde_Initial
			,@Casehead_Last_Name 
			,@Casehead_Individual_Id 
			,@Casehead_Birth_Date 
			,@Casehead_Sex_Code 
			,@First_Name 
			,@Middle_Initial 
			,@Last_Name 
			,@Individual_Id 
			,@Sex_Code 
			,@Address_Line_1 
			,@Address_Line_2 
			,@City
			,@State 
			,@Zip_Code 
			,@Zip_Code_Plus_4 
			,@State_Worker_Id 
			,@Birth_Date 
	end

Close ImportFSISCursor
Deallocate ImportFSISCursor

exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Client load completed, searching for case workers'


 /*--- Import CaseManager Data  */
Declare ImportCaseWorkerCursor cursor For
SELECT *
/**Swap DummyTable for the commented code**/
from DummyTable

--FROM OPENQUERY(NOMADSPROD, 'SELECT DISTINCT
--CHAR(T2.ASMNT_BEG_DT, USA) || '' 0:00'' AS Effective_Date,
--RTRIM(T2.NOMADS_USRID) AS District_Id,
--RTRIM(T2.NOMADS_USRID) AS PC_Logon_ID,
--RTRIM(FRST_NM) AS First_Name,
--RTRIM(LST_NM) AS Last_Name,
--RTRIM(PHN_NMB) AS Phone_Number,
--RTRIM(PHN_EXT) AS Extension,
--CAST(NULL AS CHAR) AS Worker_ID1,
--CAST(NULL AS CHAR) AS Worker_ID2,
--CAST(NULL AS CHAR) AS Worker_ID3,
--CAST(NULL AS CHAR) AS Worker_ID4,
--CAST(NULL AS CHAR) AS Worker_ID5,
--CAST(NULL AS CHAR) AS Worker_ID6,
--CAST(NULL AS CHAR) AS Worker_ID7,
--CAST(NULL AS CHAR) AS Worker_ID8,
--CAST(NULL AS CHAR) AS Worker_ID9,
--CAST(NULL AS CHAR) AS Worker_ID10,
--T1.OFC_CD AS County_Number
--FROM W100DP1.TWNIVD_CASELD_CASE T1,
--W100DP1.TWNSUP_UNT_POS_HST T2,
--W100DP1.TWNNOMADS_USER T3
--WHERE T1.OFC_CD = T2.OFC_CD
--AND T1.PRGM_OFC_TYPE = T2.PRGM_OFC_TYPE
--AND T1.SPRVS_UNIT = T2.SPRVS_UNIT
--AND T1.PSN_NMB    = T2.PSN_NMB
--AND T1.CASELD_IND = ''N''
--AND T2.NOMADS_USRID = T3.NOMADS_USRID
--AND CURRENT DATE  BETWEEN T2.ASMNT_BEG_DT AND T2.ASMNT_END_DT')

exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Loading case workers'

declare  @Effective_Date datetime
,@District_ID varchar(50)
,@PC_Logon_ID varchar(20)
,@CFirst_Name varchar(30)
,@CLast_Name varchar(30)
,@Phone_Number varchar(30)
,@Extension varchar(50)
,@Worker_ID1 varchar(50)
,@Worker_ID2 varchar(50)
,@Worker_ID3 varchar(50)
,@Worker_ID4 varchar(50)
,@Worker_ID5 varchar(50)
,@Worker_ID6 varchar(50)
,@Worker_ID7 varchar(50)
,@Worker_ID8 varchar(50)
,@Worker_ID9 varchar(50)
,@Worker_ID10 varchar(50)
,@County_Number varchar(10)
Open ImportCaseWorkerCursor
Fetch Next from ImportCaseWorkerCursor 
into  	@Effective_Date 
,@District_ID 
,@PC_Logon_ID 
,@CFirst_Name 
,@CLast_Name 
,@Phone_Number 
,@Extension 
,@Worker_ID1 
,@Worker_ID2
,@Worker_ID3
,@Worker_ID4 
,@Worker_ID5 
,@Worker_ID6 
,@Worker_ID7 
,@Worker_ID8 
,@Worker_ID9 
,@Worker_ID10 
,@County_Number 

While @@FETCH_STATUS = 0
	begin
	/*-- insert into CPImportFSIS  */
	insert	CPImportCaseWorker
		(
			fkCPImportBatch
			,UserName
			,FirstName 
			,LastName 
			,PhoneNumber
			,CountyCode
			,EffectiveDate 
			,ProcessDate
			,Extension 
			,DistrictID 
			,WorkerID1 
			,WorkerID2
			,WorkerID3
			,WorkerID4 
			,WorkerID5 
			,WorkerID6 
			,WorkerID7 
			,WorkerID8 
			,WorkerID9 
			,WorkerID10
		)
	Values
		(
			@fkCPImportBatch
			,@PC_Logon_ID 
			,@CFirst_Name 
			,@CLast_Name 
			,@Phone_Number 
			,@County_Number
			,@Effective_Date 
			,null
			,@Extension 
			,@District_ID 
			,@Worker_ID1 
			,@Worker_ID2
			,@Worker_ID3
			,@Worker_ID4 
			,@Worker_ID5 
			,@Worker_ID6 
			,@Worker_ID7 
			,@Worker_ID8 
			,@Worker_ID9 
			,@Worker_ID10 		
		)
		
	Fetch Next from ImportCaseWorkerCursor 
	into @Effective_Date 
		,@District_ID 
		,@PC_Logon_ID 
		,@CFirst_Name 
		,@CLast_Name 
		,@Phone_Number 
		,@Extension 
		,@Worker_ID1 
		,@Worker_ID2
		,@Worker_ID3
		,@Worker_ID4 
		,@Worker_ID5 
		,@Worker_ID6 
		,@Worker_ID7 
		,@Worker_ID8 
		,@Worker_ID9 
		,@Worker_ID10 
		,@County_Number 

	end

Close ImportCaseWorkerCursor
Deallocate ImportCaseWorkerCursor

exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Load complete'

/*-- Call stored procedures to import data to pilot tables */
PRINT 'Calling spCPImportProcessPreProcessBatchV2'
exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Calling spCPImportProcessPreProcessBatchV2'
exec spCPImportProcessPreProcessBatchV2 @fkCPImportBatch


PRINT 'Calling spCPImportProcessCaseWorkerV2'
exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Calling spCPImportProcessCaseWorkerV2'
exec spCPImportProcessCaseWorkerV2 @fkCPImportBatch


PRINT 'Calling spCPImportProcessFSISNomadsV2'
exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'Calling spCPImportProcessFSISNomadsV2'
exec spCPImportProcessFSISNomadsV2 @fkCPImportBatch


exec CPImportBatchStepInsert
	@fkCPImportBatch = @fkCPImportBatch
	,@StepDescription = 'End run'


