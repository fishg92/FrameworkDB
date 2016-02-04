CREATE TABLE [dbo].[PSPPage] (
    [pkPSPPage]    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkPSPDocType] DECIMAL (18) NOT NULL,
    [PageNumber]   INT          NOT NULL,
    [LUPUser]      VARCHAR (50) NULL,
    [LUPDate]      DATETIME     NULL,
    [CreateUser]   VARCHAR (50) NULL,
    [CreateDate]   DATETIME     NULL,
    CONSTRAINT [PK_PSPPage] PRIMARY KEY CLUSTERED ([pkPSPPage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[PSPPage]([fkPSPDocType] ASC);


GO
CREATE Trigger [dbo].[tr_PSPPageAudit_UI] On [dbo].[PSPPage]
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

Update PSPPage
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPage dbTable
	Inner Join Inserted i on dbtable.pkPSPPage = i.pkPSPPage
	Left Join Deleted d on d.pkPSPPage = d.pkPSPPage
	Where d.pkPSPPage is null

Update PSPPage
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPage dbTable
	Inner Join Deleted d on dbTable.pkPSPPage = d.pkPSPPage
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPPageAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPPage] = i.[pkPSPPage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPage]
	,[fkPSPDocType]
	,[PageNumber]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPPage]
	,[fkPSPDocType]
	,[PageNumber]

From  Inserted
GO
CREATE Trigger [dbo].[tr_PSPPageAudit_d] On [dbo].[PSPPage]
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
From PSPPageAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPPage] = d.[pkPSPPage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPage]
	,[fkPSPDocType]
	,[PageNumber]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPPage]
	,[fkPSPDocType]
	,[PageNumber]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table collects information about individual pages in a PSP object, and links them to their doc types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'pkPSPPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The page number for this print job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPage', @level2type = N'COLUMN', @level2name = N'CreateDate';

