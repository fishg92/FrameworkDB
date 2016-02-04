CREATE TABLE [dbo].[BackfileImport] (
    [pkBackfileImport]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [SourceFilename]      VARCHAR (500) NULL,
    [DestinationFilename] VARCHAR (500) NULL,
    [SourceID]            SMALLINT      NULL,
    [BOXID]               VARCHAR (100) NULL,
    [Docket]              VARCHAR (100) NULL,
    [CaseUPI]             VARCHAR (20)  NULL,
    [CaseSuffix]          CHAR (1)      NULL,
    [SSN]                 VARCHAR (9)   NULL,
    [Category]            VARCHAR (50)  NULL,
    [DocumentType]        VARCHAR (100) NULL,
    [DocumentDate]        DATETIME      NULL,
    [NorthwoodsNumber]    VARCHAR (50)  NULL,
    [Message]             VARCHAR (255) NULL,
    [Success]             BIT           NULL,
    [LUPUser]             VARCHAR (50)  NULL,
    [LUPDate]             DATETIME      NULL,
    [CreateUser]          VARCHAR (50)  NULL,
    [CreateDate]          DATETIME      NULL,
    CONSTRAINT [PK_BackfileImport] PRIMARY KEY CLUSTERED ([pkBackfileImport] ASC)
);


GO
CREATE Trigger [dbo].[tr_BackfileImportAudit_d] On [dbo].[BackfileImport]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From BackfileImportAudit dbTable
Inner Join deleted d ON dbTable.[pkBackfileImport] = d.[pkBackfileImport]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BackfileImportAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBackfileImport]
	,[SourceFilename]
	,[DestinationFilename]
	,[SourceID]
	,[BOXID]
	,[Docket]
	,[CaseUPI]
	,[CaseSuffix]
	,[SSN]
	,[Category]
	,[DocumentType]
	,[DocumentDate]
	,[NorthwoodsNumber]
	,[Message]
	,[Success]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkBackfileImport]
	,[SourceFilename]
	,[DestinationFilename]
	,[SourceID]
	,[BOXID]
	,[Docket]
	,[CaseUPI]
	,[CaseSuffix]
	,[SSN]
	,[Category]
	,[DocumentType]
	,[DocumentDate]
	,[NorthwoodsNumber]
	,[Message]
	,[Success]
From  Deleted
GO
CREATE Trigger [dbo].[tr_BackfileImportAudit_UI] On [dbo].[BackfileImport]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

Update BackfileImport
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BackfileImport dbTable
	Inner Join Inserted i on dbtable.pkBackfileImport = i.pkBackfileImport
	Left Join Deleted d on d.pkBackfileImport = d.pkBackfileImport
	Where d.pkBackfileImport is null

Update BackfileImport
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BackfileImport dbTable
	Inner Join Deleted d on dbTable.pkBackfileImport = d.pkBackfileImport
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From BackfileImportAudit dbTable
Inner Join inserted i ON dbTable.[pkBackfileImport] = i.[pkBackfileImport]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BackfileImportAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBackfileImport]
	,[SourceFilename]
	,[DestinationFilename]
	,[SourceID]
	,[BOXID]
	,[Docket]
	,[CaseUPI]
	,[CaseSuffix]
	,[SSN]
	,[Category]
	,[DocumentType]
	,[DocumentDate]
	,[NorthwoodsNumber]
	,[Message]
	,[Success]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkBackfileImport]
	,[SourceFilename]
	,[DestinationFilename]
	,[SourceID]
	,[BOXID]
	,[Docket]
	,[CaseUPI]
	,[CaseSuffix]
	,[SSN]
	,[Category]
	,[DocumentType]
	,[DocumentDate]
	,[NorthwoodsNumber]
	,[Message]
	,[Success]

From  Inserted