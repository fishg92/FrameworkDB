CREATE TABLE [dbo].[FormRendition] (
    [pkFormRendition] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormName]      DECIMAL (18) NOT NULL,
    [Finished]        TINYINT      NULL,
    [CaseNumber]      VARCHAR (50) NULL,
    [SSN]             VARCHAR (50) NULL,
    [FirstName]       VARCHAR (50) NULL,
    [LastName]        VARCHAR (50) NULL,
    [LUPUser]         VARCHAR (50) NULL,
    [LUPDate]         DATETIME     NULL,
    [CreateUser]      VARCHAR (50) NULL,
    [CreateDate]      DATETIME     NULL,
    CONSTRAINT [PK_RENDITION] PRIMARY KEY CLUSTERED ([pkFormRendition] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormRendition]([fkFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormRenditionAudit_UI] On [dbo].[FormRendition]
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

Update FormRendition
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormRendition dbTable
	Inner Join Inserted i on dbtable.pkFormRendition = i.pkFormRendition
	Left Join Deleted d on d.pkFormRendition = d.pkFormRendition
	Where d.pkFormRendition is null

Update FormRendition
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormRendition dbTable
	Inner Join Deleted d on dbTable.pkFormRendition = d.pkFormRendition
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormRenditionAudit dbTable
Inner Join inserted i ON dbTable.[pkFormRendition] = i.[pkFormRendition]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormRenditionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormRendition]
	,[fkFormName]
	,[Finished]
	,[CaseNumber]
	,[SSN]
	,[FirstName]
	,[LastName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormRendition]
	,[fkFormName]
	,[Finished]
	,[CaseNumber]
	,[SSN]
	,[FirstName]
	,[LastName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormRenditionAudit_d] On [dbo].[FormRendition]
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
From FormRenditionAudit dbTable
Inner Join deleted d ON dbTable.[pkFormRendition] = d.[pkFormRendition]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormRenditionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormRendition]
	,[fkFormName]
	,[Finished]
	,[CaseNumber]
	,[SSN]
	,[FirstName]
	,[LastName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormRendition]
	,[fkFormName]
	,[Finished]
	,[CaseNumber]
	,[SSN]
	,[FirstName]
	,[LastName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This tables stores various versions of the form as it is saved before completion. Apparently used in barcoding.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'pkFormRendition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indication of whether or not this is the final rendition of the form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'Finished';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Case number for the form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'CaseNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SSN for the client that the form is for.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'SSN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First name of the client the form is for', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last name of the client the form is for', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormRendition', @level2type = N'COLUMN', @level2name = N'CreateDate';

