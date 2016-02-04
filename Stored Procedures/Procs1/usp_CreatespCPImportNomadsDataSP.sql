

CREATE PROCEDURE [dbo].[usp_CreatespCPImportNomadsDataSP]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists ( select 1 from sysobjects where name = 'spCPImportNomadsData')
		drop procedure spCPImportNomadsData



	declare @spText  varchar(8000)
			,@spText2 varchar(8000)
			,@spText3 varchar(8000)
			,@sCRLF char(2)


	SET @sCRLF = char(13) + char(10)
	set @spText = ' '
	set @spText2 = ' '
	set @spText3 = ' '


/*
set @spText = @spText + 'SET ANSI_NULLS ON '+ @sCRLF
set @spText = @spText + 'go '+ @sCRLF



set @spText = @spText +  'SET QUOTED_IDENTIFIER ON '+ @sCRLF
set @spText = @spText + 'go '+ @sCRLF
*/

set @spText = @spText +  'CREATE PROCEDURE spCPImportNomadsData'+ @sCRLF
	
set @spText = @spText + 'AS'+ @sCRLF
set @spText = @spText + 'BEGIN'+ @sCRLF
set @spText = @spText + '	SET NOCOUNT ON;'+ @sCRLF

	
set @spText = @spText + '/* get batch id */'+ @sCRLF

set @spText = @spText + 'declare @fkCPImportBatch decimal(18,0)'+ @sCRLF

set @spText = @spText + 'Insert Into CPImportBatch'+ @sCRLF
set @spText = @spText + '(	CreateUser,'+ @sCRLF
	set @spText = @spText + 'CreateDate)'+ @sCRLF
set @spText = @spText + 'Values'+ @sCRLF
set @spText = @spText + '(	User,'+ @sCRLF
	set @spText = @spText + 'GetDate())'+ @sCRLF

set @spText = @spText + 'SELECT @fkCPImportBatch = CAST(SCOPE_IDENTITY() AS int) '+ @sCRLF

--set @spText = @spText + '/* ----- import FSIS data ----- */'+ @sCRLF
set @spText = @spText + 'Declare ImportFSISCursor cursor For' + @sCRLF
set @spText = @spText + 'SELECT *'+ @sCRLF
set @spText = @spText + 'FROM OPENQUERY(NOMADSDEV, ''SELECT DISTINCT '+ @sCRLF
set @spText = @spText + 'CHAR(CURRENT DATE,USA) || '''' '''' || rtrim(CHAR(hour(CURRENT TIME))) || '''':'''' || rtrim(CHAR(minute(CURRENT TIME))) || '''':'''' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.SSN) AS Social_Security_Number,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,'+ @sCRLF
set @spText = @spText + 'CAST(NULL AS CHAR) AS County_Case_Number,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.FRST_NM) AS Casehead_First_Name,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.MID_NM) AS Casehead_Middle_Initial,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.LST_NM) AS Casehead_Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Casehead_Birth_Date,'+ @sCRLF
set @spText = @spText + 'T1.SEX_CD AS Casehead_Sex_Code,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.FRST_NM) AS First_Name,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.MID_NM) AS Middle_Initial,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.LST_NM) AS Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T1.UPI),2,9) AS Individual_Id,'+ @sCRLF
set @spText = @spText + 'T1.SEX_CD AS Sex_Code,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.HOUSE_NMB)) || '''' '''' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '''' '''' || LTRIM(RTRIM(T3.STR_NM)))) || '''' '''' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '''' '''' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.CITY)) || '''' '''' || LTRIM(RTRIM(T3.ST_CD)) AS City_State,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,'+ @sCRLF
set @spText = @spText + 'RTRIM(T5.NOMADS_USRID) AS state_worker_id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Birth_Date'+ @sCRLF
set @spText = @spText + 'FROM W026DTF1.TWNPERSON T1,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASE T2,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNPERSON_ADRS_HST T3,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASELD_CASE T4,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNSUP_UNT_POS_HST T5'+ @sCRLF
set @spText = @spText + 'WHERE T1.UPI = T2.NCP_UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T3.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T4.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.CASE_SUFX = T4.CASE_SUFX'+ @sCRLF
set @spText = @spText + 'AND T4.OFC_CD = T5.OFC_CD'+ @sCRLF
set @spText = @spText + 'AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE'+ @sCRLF
set @spText = @spText + 'AND T4.SPRVS_UNIT = T5.SPRVS_UNIT'+ @sCRLF
set @spText = @spText + 'AND T4.PSN_NMB    = T5.PSN_NMB'+ @sCRLF
set @spText = @spText + 'AND T4.CASELD_IND = ''''N'''''+ @sCRLF
set @spText = @spText + 'AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT'+ @sCRLF
set @spText = @spText + 'UNION'+ @sCRLF
set @spText = @spText + 'SELECT DISTINCT '+ @sCRLF
set @spText = @spText + 'CHAR(CURRENT DATE,USA) || '''' '''' || rtrim(CHAR(hour(CURRENT TIME))) || '''':'''' || rtrim(CHAR(minute(CURRENT TIME))) || '''':'''' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,'+ @sCRLF
set @spText = @spText + 'T1.SSN AS Social_Security_Number,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,'+ @sCRLF
set @spText = @spText + 'CAST(NULL AS CHAR) AS County_Case_Number,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.FRST_NM) AS Casehead_First_Name,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.MID_NM) AS Casehead_Middle_Initial,'+ @sCRLF
set @spText = @spText + 'RTRIM(T1.LST_NM) AS Casehead_Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Casehead_Birth_Date,'+ @sCRLF
set @spText = @spText + 'T1.SEX_CD AS Casehead_Sex_Code,'+ @sCRLF
set @spText = @spText + 'RTRIM(T6.FRST_NM) AS First_Name,'+ @sCRLF
set @spText = @spText + 'RTRIM(T6.MID_NM) AS Middle_Initial,'+ @sCRLF
set @spText = @spText + 'RTRIM(T6.LST_NM) AS Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T6.UPI),2,9) AS Individual_Id,'+ @sCRLF
set @spText = @spText + 'T6.SEX_CD AS Sex_Code,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.HOUSE_NMB)) || '''' '''' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '''' '''' || LTRIM(RTRIM(T3.STR_NM)))) || '''' '''' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '''' '''' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.CITY)) || '''' '''' || LTRIM(RTRIM(T3.ST_CD)) AS City_State,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T5.NOMADS_USRID)) AS state_worker_id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Birth_Date'+ @sCRLF
set @spText = @spText + 'FROM W026DTF1.TWNPERSON T1,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASE T2,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNPERSON_ADRS_HST T3,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASELD_CASE T4,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNSUP_UNT_POS_HST T5,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNPERSON T6'+ @sCRLF
set @spText = @spText + 'WHERE T1.UPI = T2.NCP_UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T3.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.CST_UPI = T6.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T4.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.CASE_SUFX = T4.CASE_SUFX'+ @sCRLF
set @spText = @spText + 'AND T4.OFC_CD = T5.OFC_CD'+ @sCRLF
set @spText = @spText + 'AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE'+ @sCRLF
set @spText = @spText + 'AND T4.SPRVS_UNIT = T5.SPRVS_UNIT'+ @sCRLF
set @spText = @spText + 'AND T4.PSN_NMB    = T5.PSN_NMB'+ @sCRLF
set @spText = @spText + 'AND T3.ADR_STS IN (''''C'''', ''''V'''')'+ @sCRLF
set @spText = @spText + 'AND T3.ADR_TYPE IN (''''CM'''', ''''CR'''')'+ @sCRLF
set @spText = @spText + 'AND T4.CASELD_IND = ''''N'''''+ @sCRLF
set @spText = @spText + 'AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT'+ @sCRLF
set @spText = @spText + 'UNION'+ @sCRLF
set @spText = @spText + 'SELECT DISTINCT '+ @sCRLF
set @spText = @spText + 'CHAR(CURRENT DATE,USA) || '''' '''' || rtrim(CHAR(hour(CURRENT TIME))) || '''':'''' || rtrim(CHAR(minute(CURRENT TIME))) || '''':'''' || rtrim(CHAR(second(CURRENT TIME))) AS Daily_Fsis_Load_Date,'+ @sCRLF
set @spText = @spText + 'T1.SSN AS Social_Security_Number,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) || T2.CASE_SUFX AS State_Case_Id,'+ @sCRLF
set @spText = @spText + 'CAST(NULL AS CHAR) AS County_Case_Number,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T1.FRST_NM)) AS Casehead_First_Name,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T1.MID_NM)) AS Casehead_Middle_Initial,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T1.LST_NM)) AS Casehead_Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T2.NCP_UPI),2,9) AS Casehead_Individual_Id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Casehead_Birth_Date,'+ @sCRLF
set @spText = @spText + 'T1.SEX_CD AS Casehead_Sex_Code,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T6.FRST_NM)) AS First_Name,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T6.MID_NM)) AS Middle_Initial,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T6.LST_NM)) AS Last_Name,'+ @sCRLF
set @spText = @spText + 'SUBSTR(DIGITS(T6.UPI),2,9) AS Individual_Id,'+ @sCRLF
set @spText = @spText + 'T6.SEX_CD AS Sex_Code,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.HOUSE_NMB)) || '''' '''' || LTRIM(RTRIM(LTRIM(RTRIM(T3.STR_DIR)) || '''' '''' || LTRIM(RTRIM(T3.STR_NM)))) || '''' '''' || LTRIM(RTRIM(T3.STR_TYPE)) AS Address_Line_1,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(LTRIM(RTRIM(T3.APT_NMB)) || '''' '''' || LTRIM(RTRIM(T3.OTH_ADDR)))) AS Address_Line_2,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T3.CITY)) || '''' '''' || LTRIM(RTRIM(T3.ST_CD)) AS City_State,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,1,5) AS Zip_Code,'+ @sCRLF
set @spText = @spText + 'SUBSTR(T3.ZIP_CD,6,4) AS Zip_Code_Plus_4,'+ @sCRLF
set @spText = @spText + 'LTRIM(RTRIM(T5.NOMADS_USRID)) AS state_worker_id,'+ @sCRLF
set @spText = @spText + 'CHAR(T1.DOB,USA) AS Birth_Date'+ @sCRLF
set @spText = @spText + 'FROM W026DTF1.TWNPERSON T1,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASE T2,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNPERSON_ADRS_HST T3,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASELD_CASE T4,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNSUP_UNT_POS_HST T5,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNPERSON T6,'+ @sCRLF
set @spText = @spText + 'W026DTF1.TWNIVD_CASE_CHILD T7'+ @sCRLF
set @spText = @spText + 'WHERE T1.UPI = T2.NCP_UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T3.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T4.UPI'+ @sCRLF
set @spText = @spText + 'AND T2.CASE_SUFX = T4.CASE_SUFX'+ @sCRLF
set @spText = @spText + 'AND T2.NCP_UPI = T7.NCP_UPI'+ @sCRLF
set @spText = @spText + 'AND T2.CASE_SUFX = T7.CASE_SUFX'+ @sCRLF
set @spText = @spText + 'AND T4.UPI = T7.NCP_UPI'+ @sCRLF
set @spText = @spText + 'AND T4.CASE_SUFX = T7.CASE_SUFX'+ @sCRLF
set @spText = @spText + 'AND T7.CHD_UPI = T6.UPI'+ @sCRLF
set @spText = @spText + 'AND T4.OFC_CD = T5.OFC_CD'+ @sCRLF
set @spText = @spText + 'AND T4.PRGM_OFC_TYPE = T5.PRGM_OFC_TYPE'+ @sCRLF
set @spText = @spText + 'AND T4.SPRVS_UNIT = T5.SPRVS_UNIT'+ @sCRLF
set @spText = @spText + 'AND T4.PSN_NMB    = T5.PSN_NMB'+ @sCRLF
set @spText = @spText + 'AND T3.ADR_STS IN (''''C'''', ''''V'''')'+ @sCRLF
set @spText = @spText + 'AND T3.ADR_TYPE IN (''''CM'''', ''''CR'''')'+ @sCRLF
set @spText = @spText + 'AND T4.CASELD_IND = ''''N'''''+ @sCRLF
set @spText = @spText + 'AND CURRENT DATE  BETWEEN T5.ASMNT_BEG_DT AND T5.ASMNT_END_DT'+ @sCRLF
set @spText = @spText + 'UNION ALL'+ @sCRLF
set @spText = @spText + 'SELECT'+ @sCRLF
set @spText = @spText + 'CAST(''''Daily FSIS Load Date'''' as VARCHAR(20)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Social Security Number'''' as VARCHAR(22)),'+ @sCRLF
set @spText = @spText + 'CAST(''''FSIS Case Id'''' as VARCHAR(12)),'+ @sCRLF
set @spText = @spText + 'CAST(''''County Case Num'''' as VARCHAR(15)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead First Name'''' as VARCHAR(19)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead Midde Initial'''' as VARCHAR(22)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead Last Name'''' as VARCHAR(18)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead Individual Id'''' as VARCHAR(22)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead Birth Date'''' as VARCHAR(19)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Casehead Sex Code'''' as VARCHAR(17)),'+ @sCRLF
set @spText = @spText + 'CAST(''''First Name'''' as VARCHAR(10)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Middle Initial'''' as VARCHAR(14)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Last Name'''' as VARCHAR(9)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Individual Id'''' as VARCHAR(13)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Sex Code'''' as VARCHAR(8)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Address Line 1'''' as VARCHAR(14)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Address Line 2'''' as VARCHAR(14)),'+ @sCRLF
set @spText = @spText + 'CAST(''''City State'''' as VARCHAR(10)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Zip Code'''' as VARCHAR(8)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Zip Code Plus 4'''' as VARCHAR(15)),'+ @sCRLF
set @spText = @spText + 'CAST(''''State Worker Id'''' as VARCHAR(15)),'+ @sCRLF
set @spText = @spText + 'CAST(''''Birth Date'''' as VARCHAR(10))'+ @sCRLF
set @spText = @spText + 'FROM sysibm.sysdummy1'+ @sCRLF
set @spText = @spText + 'WITH UR'')'+ @sCRLF




set @spText2 = @spText2 + 'declare @Status integer'+ @sCRLF
		set @spText2 = @spText2 + ',@Daily_FSIS_Load_Date Varchar(20)'+ @sCRLF
		set @spText2 = @spText2 + ',@Social_Security_Number VARCHAR(22)'+ @sCRLF
		set @spText2 = @spText2 + ',@FSIS_Case_Id VARCHAR(50)'+ @sCRLF
		set @spText2 = @spText2 + ',@County_Case_Num VARCHAR(15)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_First_Name VARCHAR(19)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Midde_Initial VARCHAR(22)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Last_Name VARCHAR(18)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Individual_Id VARCHAR(22)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Birth_Date VARCHAR(19)'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Sex_Code VARCHAR(17)'+ @sCRLF
		set @spText2 = @spText2 + ',@First_Name VARCHAR(10)'+ @sCRLF
		set @spText2 = @spText2 + ',@Middle_Initial VARCHAR(14)'+ @sCRLF
		set @spText2 = @spText2 + ',@Last_Name VARCHAR(9)'+ @sCRLF
		set @spText2 = @spText2 + ',@Individual_Id VARCHAR(13)'+ @sCRLF
		set @spText2 = @spText2 + ',@Sex_Code VARCHAR(8)'+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_1 VARCHAR(14)'+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_2 VARCHAR(14)'+ @sCRLF
		set @spText2 = @spText2 + ',@City_State VARCHAR(10)'+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code VARCHAR(8)'+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code_Plus_4 VARCHAR(15)'+ @sCRLF
		set @spText2 = @spText2 + ',@State_Worker_Id VARCHAR(15)'+ @sCRLF
		set @spText2 = @spText2 + ',@Birth_Date VARCHAR(10)'+ @sCRLF
		
		


set @spText2 = @spText2 + 'Open ImportFSISCursor'+ @sCRLF

set @spText2 = @spText2 + 'Fetch Next from ImportFSISCursor '+ @sCRLF
set @spText2 = @spText2 + 'into  	@Daily_FSIS_Load_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Social_Security_Number'+ @sCRLF
		set @spText2 = @spText2 + ',@FSIS_Case_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@County_Case_Num '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Midde_Initial'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Birth_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Middle_Initial '+ @sCRLF
		set @spText2 = @spText2 + ',@Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_1 '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_2 '+ @sCRLF
		set @spText2 = @spText2 + ',@City_State '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code_Plus_4 '+ @sCRLF
		set @spText2 = @spText2 + ',@State_Worker_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Birth_Date '+ @sCRLF

set @spText2 = @spText2 + '/*-- skip the header */'+ @sCRLF
set @spText2 = @spText2 + 'if @@FETCH_STATUS = 0 '+ @sCRLF
set @spText2 = @spText2 + 'begin'+ @sCRLF
	set @spText2 = @spText2 + 'Fetch Next from ImportFSISCursor '+ @sCRLF
	set @spText2 = @spText2 + 'into  	@Daily_FSIS_Load_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Social_Security_Number'+ @sCRLF
		set @spText2 = @spText2 + ',@FSIS_Case_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@County_Case_Num '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Midde_Initial'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Birth_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Middle_Initial '+ @sCRLF
		set @spText2 = @spText2 + ',@Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_1 '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_2 '+ @sCRLF
		set @spText2 = @spText2 + ',@City_State '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code_Plus_4 '+ @sCRLF
		set @spText2 = @spText2 + ',@State_Worker_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Birth_Date '+ @sCRLF


	set @spText2 = @spText2 + 'Select @Status = @@Fetch_Status'+ @sCRLF
	
set @spText2 = @spText2 + 'end'+ @sCRLF

set @spText2 = @spText2 + 'While @Status = 0'+ @sCRLF
set @spText2 = @spText2 + 'begin'+ @sCRLF
--		set @spText2 = @spText2 + '/*-- insert into CPImportFSIS */'+ @sCRLF

set @spText2 = @spText2 + '		insert into CPImportFSIS'+ @sCRLF
		set @spText2 = @spText2 + '(fkCPImportBatch'+ @sCRLF
		set @spText2 = @spText2 + ',SSN'+ @sCRLF
		set @spText2 = @spText2 + ',CaseID'+ @sCRLF
		set @spText2 = @spText2 + ',CountyCaseNum'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadFirstName'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadMiddleName'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadLastName'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadIndividualID'+ @sCRLF
		set @spText2 = @spText2 + ',ParticipantFirstName'+ @sCRLF
		set @spText2 = @spText2 + ',ParticipantMiddleName'+ @sCRLF
		set @spText2 = @spText2 + ',ParticipantLastName'+ @sCRLF
		set @spText2 = @spText2 + ',ParticipantIndividualID'+ @sCRLF
		set @spText2 = @spText2 + ',ParticipantSex'+ @sCRLF
		set @spText2 = @spText2 + ',Street1'+ @sCRLF
		set @spText2 = @spText2 + ',Street2'+ @sCRLF
		set @spText2 = @spText2 + ',City'+ @sCRLF
		set @spText2 = @spText2 + ',State'+ @sCRLF
		set @spText2 = @spText2 + ',Zip'+ @sCRLF
		set @spText2 = @spText2 + ',ZipPlus4'+ @sCRLF
		set @spText2 = @spText2 + ',WorkerNum'+ @sCRLF
		set @spText2 = @spText2 + ',BirthDate'+ @sCRLF
		set @spText2 = @spText2 + ',Phone'+ @sCRLF
		set @spText2 = @spText2 + ',EffectiveDate'+ @sCRLF
		set @spText2 = @spText2 + ',ProcessDate'+ @sCRLF
		set @spText2 = @spText2 + ',CityState'+ @sCRLF
		set @spText2 = @spText2 + ',SSNFormatted'+ @sCRLF
		set @spText2 = @spText2 + ',BirthDateString'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadBirthDateString'+ @sCRLF
		set @spText2 = @spText2 + ',CaseHeadSex)'+ @sCRLF
		set @spText2 = @spText2 + 'Values (@fkCPImportBatch'+ @sCRLF
		set @spText2 = @spText2 + ',substring(@Social_Security_Number,1,20)'+ @sCRLF
		set @spText2 = @spText2 + ',@FSIS_Case_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@County_Case_Num '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Midde_Initial'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Last_Name'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Middle_Initial '+ @sCRLF
		set @spText2 = @spText2 + ',@Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Sex_Code'+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_1 '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_2 '+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code '+ @sCRLF
		set @spText2 = @spText2 + ',substring(@Zip_Code_Plus_4 ,1,10)'+ @sCRLF
		set @spText2 = @spText2 + ',@State_Worker_Id'+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',@Daily_FSIS_Load_Date '+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',@City_State'+ @sCRLF
		set @spText2 = @spText2 + ',null'+ @sCRLF
		set @spText2 = @spText2 + ',@Birth_Date'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Birth_Date'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Sex_Code'+ @sCRLF
		set @spText2 = @spText2 + ')'+ @sCRLF
		
		

	set @spText2 = @spText2 + 'Fetch Next from ImportFSISCursor '+ @sCRLF
	set @spText2 = @spText2 + 'into @Daily_FSIS_Load_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Social_Security_Number'+ @sCRLF
		set @spText2 = @spText2 + ',@FSIS_Case_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@County_Case_Num '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Midde_Initial'+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Birth_Date '+ @sCRLF
		set @spText2 = @spText2 + ',@Casehead_Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@First_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Middle_Initial '+ @sCRLF
		set @spText2 = @spText2 + ',@Last_Name '+ @sCRLF
		set @spText2 = @spText2 + ',@Individual_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Sex_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_1 '+ @sCRLF
		set @spText2 = @spText2 + ',@Address_Line_2 '+ @sCRLF
		set @spText2 = @spText2 + ',@City_State '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code '+ @sCRLF
		set @spText2 = @spText2 + ',@Zip_Code_Plus_4 '+ @sCRLF
		set @spText2 = @spText2 + ',@State_Worker_Id '+ @sCRLF
		set @spText2 = @spText2 + ',@Birth_Date '+ @sCRLF
		
	set @spText2 = @spText2 + 'Select @Status = @@Fetch_Status'+ @sCRLF
	

set @spText2 = @spText2 + 'end'+ @sCRLF


set @spText2 = @spText2 + 'Close ImportFSISCursor'+ @sCRLF
set @spText2 = @spText2 + 'Deallocate ImportFSISCursor'+ @sCRLF

select @spText
select @spText2



set @spText3 = @spText3 + '/*--- Import CaseManager Data  */'+ @sCRLF

set @spText3 = @spText3 + 'Declare ImportCaseWorkerCursor cursor For'+ @sCRLF
set @spText3 = @spText3 + 'SELECT *'+ @sCRLF
set @spText3 = @spText3 + 'FROM OPENQUERY(NOMADSDEV, ''SELECT DISTINCT'+ @sCRLF
set @spText3 = @spText3 + 'CHAR(T2.ASMNT_BEG_DT, USA) || '''' 0:00'''' AS Effective_Date,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(T2.NOMADS_USRID) AS District_Id,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(T2.NOMADS_USRID) AS PC_Logon_ID,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(FRST_NM) AS First_Name,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(LST_NM) AS Last_Name,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(PHN_NMB) AS Phone_Number,'+ @sCRLF
set @spText3 = @spText3 + 'RTRIM(PHN_EXT) AS Extension,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID1,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID2,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID3,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID4,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID5,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID6,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID7,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID8,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID9,'+ @sCRLF
set @spText3 = @spText3 + 'CAST(NULL AS CHAR) AS Worker_ID10,'+ @sCRLF
set @spText3 = @spText3 + 'T1.OFC_CD AS County_Number'+ @sCRLF
set @spText3 = @spText3 + 'FROM W026DTF1.TWNIVD_CASELD_CASE T1,'+ @sCRLF
set @spText3 = @spText3 + 'W026DTF1.TWNSUP_UNT_POS_HST T2,'+ @sCRLF
set @spText3 = @spText3 + 'W026DTF1.TWNNOMADS_USER T3'+ @sCRLF
set @spText3 = @spText3 + 'WHERE T1.OFC_CD = T2.OFC_CD'+ @sCRLF
set @spText3 = @spText3 + 'AND T1.PRGM_OFC_TYPE = T2.PRGM_OFC_TYPE'+ @sCRLF
set @spText3 = @spText3 + 'AND T1.SPRVS_UNIT = T2.SPRVS_UNIT'+ @sCRLF
set @spText3 = @spText3 + 'AND T1.PSN_NMB    = T2.PSN_NMB'+ @sCRLF
set @spText3 = @spText3 + 'AND T1.CASELD_IND = ''''N'''''+ @sCRLF
set @spText3 = @spText3 + 'AND T2.NOMADS_USRID = T3.NOMADS_USRID'+ @sCRLF
set @spText3 = @spText3 + 'AND CURRENT DATE  BETWEEN T2.ASMNT_BEG_DT AND T2.ASMNT_END_DT'')'+ @sCRLF

set @spText3 = @spText3 + 'declare  @Effective_Date datetime'+ @sCRLF
		set @spText3 = @spText3 + ',@District_ID varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@PC_Logon_ID varchar(20)'+ @sCRLF
		set @spText3 = @spText3 + ',@CFirst_Name varchar(30)'+ @sCRLF
		set @spText3 = @spText3 + ',@CLast_Name varchar(30)'+ @sCRLF
		set @spText3 = @spText3 + ',@Phone_Number varchar(30)'+ @sCRLF
		set @spText3 = @spText3 + ',@Extension varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID1 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID2 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID3 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID4 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID5 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID6 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID7 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID8 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID9 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID10 varchar(50)'+ @sCRLF
		set @spText3 = @spText3 + ',@County_Number varchar(10)'+ @sCRLF

set @spText3 = @spText3 + 'Open ImportCaseWorkerCursor'+ @sCRLF

set @spText3 = @spText3 + 'Fetch Next from ImportCaseWorkerCursor '+ @sCRLF
set @spText3 = @spText3 + 'into  	@Effective_Date '+ @sCRLF
		set @spText3 = @spText3 + ',@District_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@PC_Logon_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@CFirst_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@CLast_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@Phone_Number '+ @sCRLF
		set @spText3 = @spText3 + ',@Extension '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID1 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID2'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID3'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID4 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID5 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID6 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID7 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID8 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID9 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID10 '+ @sCRLF
		set @spText3 = @spText3 + ',@County_Number '+ @sCRLF



set @spText3 = @spText3 + 'Select @Status = @@Fetch_Status'+ @sCRLF
	


set @spText3 = @spText3 + 'While @Status = 0'+ @sCRLF
set @spText3 = @spText3 + 'begin'+ @sCRLF
		set @spText3 = @spText3 + '/*-- insert into CPImportFSIS  */'+ @sCRLF

		set @spText3 = @spText3 + 'insert into CPImportCaseWorker'+ @sCRLF
		set @spText3 = @spText3 + '(fkCPImportBatch'+ @sCRLF
		set @spText3 = @spText3 + ',UserName'+ @sCRLF
		set @spText3 = @spText3 + ',FirstName '+ @sCRLF
		set @spText3 = @spText3 + ',LastName '+ @sCRLF
		set @spText3 = @spText3 + ',PhoneNumber'+ @sCRLF
		set @spText3 = @spText3 + ',CountyCode'+ @sCRLF
		set @spText3 = @spText3 + ',EffectiveDate '+ @sCRLF
		set @spText3 = @spText3 + ',ProcessDate'+ @sCRLF
		set @spText3 = @spText3 + ',Extension '+ @sCRLF
		set @spText3 = @spText3 + ',DistrictID '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID1 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID2'+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID3'+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID4 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID5 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID6 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID7 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID8 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID9 '+ @sCRLF
		set @spText3 = @spText3 + ',WorkerID10  )'+ @sCRLF
		set @spText3 = @spText3 + 'Values (@fkCPImportBatch'+ @sCRLF
		set @spText3 = @spText3 + ',@PC_Logon_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@CFirst_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@CLast_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@Phone_Number '+ @sCRLF
		set @spText3 = @spText3 + ',@County_Number'+ @sCRLF
		set @spText3 = @spText3 + ',@Effective_Date '+ @sCRLF
		set @spText3 = @spText3 + ',null'+ @sCRLF
		set @spText3 = @spText3 + ',@Extension '+ @sCRLF
		set @spText3 = @spText3 + ',@District_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID1 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID2'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID3'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID4 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID5 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID6 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID7 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID8 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID9 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID10 		' + @sCRLF
		set @spText3 = @spText3 + ')'+ @sCRLF
		
		

	set @spText3 = @spText3 + 'Fetch Next from ImportCaseWorkerCursor '+ @sCRLF
	set @spText3 = @spText3 + 'into @Effective_Date '+ @sCRLF
		set @spText3 = @spText3 + ',@District_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@PC_Logon_ID '+ @sCRLF
		set @spText3 = @spText3 + ',@CFirst_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@CLast_Name '+ @sCRLF
		set @spText3 = @spText3 + ',@Phone_Number '+ @sCRLF
		set @spText3 = @spText3 + ',@Extension '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID1 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID2'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID3'+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID4 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID5 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID6 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID7 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID8 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID9 '+ @sCRLF
		set @spText3 = @spText3 + ',@Worker_ID10 '+ @sCRLF
		set @spText3 = @spText3 + ',@County_Number '+ @sCRLF
		
	set @spText3 = @spText3 + 'Select @Status = @@Fetch_Status'+ @sCRLF
	
	
set @spText3 = @spText3 + 'end'+ @sCRLF
set @spText3 = @spText3 + 'Close ImportCaseWorkerCursor'+ @sCRLF
set @spText3 = @spText3 + 'Deallocate ImportCaseWorkerCursor'+ @sCRLF


set @spText3 = @spText3 + '/*-- Call stored procedures to import data to pilot tables */'+ @sCRLF
set @spText3 = @spText3 + 'exec spCPImportProcessPreProcessBatchV2 @fkCPImportBatch'+ @sCRLF
set @spText3 = @spText3 + 'exec spCPImportProcessCaseWorkerV2 @fkCPImportBatch'+ @sCRLF
set @spText3 = @spText3 + 'exec spCPImportProcessFSISNomadsV2 @fkCPImportBatch'+ @sCRLF

set @spText3 = @spText3 + 'end'+ @sCRLF
--set @spText3 = @spText3 + 'GO'+ @sCRLF


exec (@spText + @spText2 + @spText3)






end



