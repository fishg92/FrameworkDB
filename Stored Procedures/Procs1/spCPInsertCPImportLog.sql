


CREATE Proc [dbo].[spCPInsertCPImportLog]
(	@fkCPImportFSIS decimal(18, 0) = NULL,
	@fkCPImportEISCase decimal(18, 0) = NULL,
	@fkCPImportEISIndividual decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL,
	@fkCPJoinClientClientCase decimal(18, 0) = NULL,
	@fkCPClientAddress decimal(18, 0) = NULL,
	@fkCPJoinClientClientAddress decimal(18, 0) = NULL,
	@fkCPClientPhone decimal(18, 0) = NULL,
	@fkCPJoinClientClientPhone decimal(18, 0) = NULL,
	@fkCPRefImportLogEventType decimal(18, 0),
	@pkCPImportLog decimal(18,0) = 0 Output
)
as

	Return 0 --@pkCPImportLog  --currently turn logging off

	Insert Into CPImportLog
	(	CreateUser,
		CreateDate,
		fkCPImportFSIS,
		fkCPImportEISCase,
		fkCPImportEISIndividual,
		fkCPClient,
		fkCPClientCase,
		fkCPJoinClientClientCase,
		fkCPClientAddress,
		fkCPJoinClientClientAddress,
		fkCPClientPhone,
		fkCPJoinClientClientPhone,
		fkCPRefImportLogEventType) 
	Values
	(	Host_Name(),
		GetDate(),
		@fkCPImportFSIS,
		@fkCPImportEISCase,
		@fkCPImportEISIndividual,
		@fkCPClient,
		@fkCPClientCase,
		@fkCPJoinClientClientCase,
		@fkCPClientAddress,
		@fkCPJoinClientClientAddress,
		@fkCPClientPhone,
		@fkCPJoinClientClientPhone,
		@fkCPRefImportLogEventType)

	Set @pkCPImportLog = Scope_Identity()




