CREATE TABLE [dbo].[AutoFill] (
    [pkAutoFill]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [SSN]           VARCHAR (11)  NULL,
    [CaseNumber]    VARCHAR (50)  NULL,
    [FirstName]     VARCHAR (40)  NULL,
    [LastName]      VARCHAR (40)  NULL,
    [Address1]      VARCHAR (150) NULL,
    [Address2]      VARCHAR (100) NULL,
    [City]          VARCHAR (50)  NULL,
    [State]         VARCHAR (2)   NULL,
    [Zip]           VARCHAR (50)  NULL,
    [CaseManager]   VARCHAR (15)  NULL,
    [LastName1char] CHAR (1)      NULL,
    [LastName2char] CHAR (2)      NULL,
    [LastName3char] CHAR (3)      NULL,
    [LastName4char] CHAR (4)      NULL,
    [LastName5char] CHAR (5)      NULL,
    [LUPUser]       VARCHAR (50)  NULL,
    [LUPDate]       DATETIME      NULL,
    [CreateUser]    VARCHAR (50)  NULL,
    [CreateDate]    DATETIME      NULL,
    CONSTRAINT [PK_AutoFill] PRIMARY KEY CLUSTERED ([pkAutoFill] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillSSN]
    ON [dbo].[AutoFill]([SSN] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillCaseNumber]
    ON [dbo].[AutoFill]([CaseNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillFirstName]
    ON [dbo].[AutoFill]([FirstName] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName]
    ON [dbo].[AutoFill]([LastName] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName1]
    ON [dbo].[AutoFill]([LastName1char] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName2]
    ON [dbo].[AutoFill]([LastName2char] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName3]
    ON [dbo].[AutoFill]([LastName3char] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName4]
    ON [dbo].[AutoFill]([LastName4char] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AutoFillLastName5]
    ON [dbo].[AutoFill]([LastName5char] ASC);


GO
CREATE Trigger [dbo].[tr_AutoFillAudit_d] On [dbo].[AutoFill]
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
From AutoFillAudit dbTable
Inner Join deleted d ON dbTable.[pkAutoFill] = d.[pkAutoFill]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFill]
	,[SSN]
	,[CaseNumber]
	,[FirstName]
	,[LastName]
	,[Address1]
	,[Address2]
	,[City]
	,[State]
	,[Zip]
	,[CaseManager]
	,[LastName1char]
	,[LastName2char]
	,[LastName3char]
	,[LastName4char]
	,[LastName5char]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutoFill]
	,[SSN]
	,[CaseNumber]
	,[FirstName]
	,[LastName]
	,[Address1]
	,[Address2]
	,[City]
	,[State]
	,[Zip]
	,[CaseManager]
	,[LastName1char]
	,[LastName2char]
	,[LastName3char]
	,[LastName4char]
	,[LastName5char]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AutoFillAudit_UI] On [dbo].[AutoFill]
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

Update AutoFill
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFill dbTable
	Inner Join Inserted i on dbtable.pkAutoFill = i.pkAutoFill
	Left Join Deleted d on d.pkAutoFill = d.pkAutoFill
	Where d.pkAutoFill is null

Update AutoFill
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFill dbTable
	Inner Join Deleted d on dbTable.pkAutoFill = d.pkAutoFill
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutoFillAudit dbTable
Inner Join inserted i ON dbTable.[pkAutoFill] = i.[pkAutoFill]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFill]
	,[SSN]
	,[CaseNumber]
	,[FirstName]
	,[LastName]
	,[Address1]
	,[Address2]
	,[City]
	,[State]
	,[Zip]
	,[CaseManager]
	,[LastName1char]
	,[LastName2char]
	,[LastName3char]
	,[LastName4char]
	,[LastName5char]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutoFill]
	,[SSN]
	,[CaseNumber]
	,[FirstName]
	,[LastName]
	,[Address1]
	,[Address2]
	,[City]
	,[State]
	,[Zip]
	,[CaseManager]
	,[LastName1char]
	,[LastName2char]
	,[LastName3char]
	,[LastName4char]
	,[LastName5char]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Autofill data for document keywords. This table is only used for autofill data in specific scenarios. Autofill data is normally queried directly from Compass People tables through a customer-specific view.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'pkAutoFill';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client social security number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'SSN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Case number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'CaseNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client first name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client last name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client address line 1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'Address1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client address line 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'Address2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client address city', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'City';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client address state', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'State';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client address zip code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'Zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Assigned case manager', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'CaseManager';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First character of last name, used for improved query performance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName1char';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First two characters of last name, used for improved query performance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName2char';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First three characters of last name, used for improved query performance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName3char';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First four characters of last name, used for improved query performance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName4char';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First five characters of last name, used for improved query performance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LastName5char';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFill', @level2type = N'COLUMN', @level2name = N'CreateDate';

