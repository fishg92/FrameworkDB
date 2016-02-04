CREATE TABLE [dbo].[PSPPrintJobIndexValue] (
    [pkPSPPrintJobIndexValue] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkPSPPrintJob]           DECIMAL (18)  NOT NULL,
    [KeywordName]             VARCHAR (255) NOT NULL,
    [KeywordValue]            VARCHAR (255) NOT NULL,
    [LUPUser]                 VARCHAR (50)  NULL,
    [LUPDate]                 DATETIME      NULL,
    [CreateUser]              VARCHAR (50)  NULL,
    [CreateDate]              DATETIME      NULL,
    CONSTRAINT [PK_PSPPrintJobIndexValue] PRIMARY KEY CLUSTERED ([pkPSPPrintJobIndexValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPPrintJob]
    ON [dbo].[PSPPrintJobIndexValue]([fkPSPPrintJob] ASC);


GO
CREATE Trigger [dbo].[tr_PSPPrintJobIndexValueAudit_d] On [dbo].[PSPPrintJobIndexValue]
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
From PSPPrintJobIndexValueAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPPrintJobIndexValue] = d.[pkPSPPrintJobIndexValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPrintJobIndexValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPrintJobIndexValue]
	,[fkPSPPrintJob]
	,[KeywordName]
	,[KeywordValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPPrintJobIndexValue]
	,[fkPSPPrintJob]
	,[KeywordName]
	,[KeywordValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPPrintJobIndexValueAudit_UI] On [dbo].[PSPPrintJobIndexValue]
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

Update PSPPrintJobIndexValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPrintJobIndexValue dbTable
	Inner Join Inserted i on dbtable.pkPSPPrintJobIndexValue = i.pkPSPPrintJobIndexValue
	Left Join Deleted d on d.pkPSPPrintJobIndexValue = d.pkPSPPrintJobIndexValue
	Where d.pkPSPPrintJobIndexValue is null

Update PSPPrintJobIndexValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPrintJobIndexValue dbTable
	Inner Join Deleted d on dbTable.pkPSPPrintJobIndexValue = d.pkPSPPrintJobIndexValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPPrintJobIndexValueAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPPrintJobIndexValue] = i.[pkPSPPrintJobIndexValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPrintJobIndexValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPrintJobIndexValue]
	,[fkPSPPrintJob]
	,[KeywordName]
	,[KeywordValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPPrintJobIndexValue]
	,[fkPSPPrintJob]
	,[KeywordName]
	,[KeywordValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table stores the actual keywords for each instance of any print job.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'pkPSPPrintJobIndexValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPPrintJob', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'fkPSPPrintJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The keyword who''s value is going to be saved', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'KeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The value for the keyword in question', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'KeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobIndexValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

