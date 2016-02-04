CREATE TABLE [dbo].[Profile] (
    [pkProfile]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]                 VARCHAR (100) NOT NULL,
    [LongDescription]             VARCHAR (255) NOT NULL,
    [LupUser]                     VARCHAR (50)  NULL,
    [LupDate]                     DATETIME      NULL,
    [CreateUser]                  VARCHAR (50)  NULL,
    [CreateDate]                  DATETIME      NULL,
    [fkrefTaskOrigin]             DECIMAL (18)  CONSTRAINT [DF_Profile_fkrefTaskOrigin] DEFAULT ((-1)) NOT NULL,
    [RecipientMappingKeywordType] VARCHAR (50)  CONSTRAINT [DF_Profile_RecipientMappingKeywordType] DEFAULT ('') NOT NULL,
    [SendDocumentToWorkflow]      BIT           CONSTRAINT [DF_Profile_SendDocumentToWorkflow] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED ([pkProfile] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskOrigin]
    ON [dbo].[Profile]([fkrefTaskOrigin] ASC);


GO
CREATE Trigger [dbo].[tr_ProfileAudit_d] On [dbo].[Profile]
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
From ProfileAudit dbTable
Inner Join deleted d ON dbTable.[pkProfile] = d.[pkProfile]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfile]
	,[Description]
	,[LongDescription]
	,[fkrefTaskOrigin]
	,[RecipientMappingKeywordType]
	,[SendDocumentToWorkflow]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProfile]
	,[Description]
	,[LongDescription]
	,[fkrefTaskOrigin]
	,[RecipientMappingKeywordType]
	,[SendDocumentToWorkflow]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ProfileAudit_UI] On [dbo].[Profile]
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

Update Profile
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Profile dbTable
	Inner Join Inserted i on dbtable.pkProfile = i.pkProfile
	Left Join Deleted d on d.pkProfile = d.pkProfile
	Where d.pkProfile is null

Update Profile
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Profile dbTable
	Inner Join Deleted d on dbTable.pkProfile = d.pkProfile
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProfileAudit dbTable
Inner Join inserted i ON dbTable.[pkProfile] = i.[pkProfile]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfile]
	,[Description]
	,[LongDescription]
	,[fkrefTaskOrigin]
	,[RecipientMappingKeywordType]
	,[SendDocumentToWorkflow]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProfile]
	,[Description]
	,[LongDescription]
	,[fkrefTaskOrigin]
	,[RecipientMappingKeywordType]
	,[SendDocumentToWorkflow]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should newly scanned documents be sent to the workflow?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'SendDocumentToWorkflow';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores basic profile information (names of profile and singular information about it)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'pkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Short description (name) of the profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longer description of the profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'LongDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'LupDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskOrigin to mark the default Task Origin for new tasks', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'fkrefTaskOrigin';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DMS Keyword to map task recipients to (value for the Map recipients to this DMS keyword drop down)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Profile', @level2type = N'COLUMN', @level2name = N'RecipientMappingKeywordType';

