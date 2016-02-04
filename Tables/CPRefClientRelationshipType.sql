CREATE TABLE [dbo].[CPRefClientRelationshipType] (
    [pkCPRefClientRelationshipType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]                   VARCHAR (255) NULL,
    [LUPUser]                       VARCHAR (50)  NULL,
    [LUPDate]                       DATETIME      NULL,
    [CreateUser]                    VARCHAR (50)  NULL,
    [CreateDate]                    DATETIME      NULL,
    [LetterAssignment]              VARCHAR (5)   NULL,
    [LetterAssignmentFont]          VARCHAR (50)  NULL,
    [LetterAssignmentFontIsBold]    BIT           NULL,
    CONSTRAINT [PK_CPRefClientRelationshipType] PRIMARY KEY CLUSTERED ([pkCPRefClientRelationshipType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefClientRelationshipTypeAudit_UI] On [dbo].[CPRefClientRelationshipType]
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

Update CPRefClientRelationshipType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientRelationshipType dbTable
	Inner Join Inserted i on dbtable.pkCPRefClientRelationshipType = i.pkCPRefClientRelationshipType
	Left Join Deleted d on d.pkCPRefClientRelationshipType = d.pkCPRefClientRelationshipType
	Where d.pkCPRefClientRelationshipType is null

Update CPRefClientRelationshipType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientRelationshipType dbTable
	Inner Join Deleted d on dbTable.pkCPRefClientRelationshipType = d.pkCPRefClientRelationshipType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefClientRelationshipTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefClientRelationshipType] = i.[pkCPRefClientRelationshipType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientRelationshipTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientRelationshipType]
	,[Description]
	,[LetterAssignment]
	,[LetterAssignmentFont]
	,[LetterAssignmentFontIsBold]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefClientRelationshipType]
	,[Description]
	,[LetterAssignment]
	,[LetterAssignmentFont]
	,[LetterAssignmentFontIsBold]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPRefClientRelationshipTypeAudit_d] On [dbo].[CPRefClientRelationshipType]
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
From CPRefClientRelationshipTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefClientRelationshipType] = d.[pkCPRefClientRelationshipType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientRelationshipTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientRelationshipType]
	,[Description]
	,[LetterAssignment]
	,[LetterAssignmentFont]
	,[LetterAssignmentFontIsBold]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefClientRelationshipType]
	,[Description]
	,[LetterAssignment]
	,[LetterAssignmentFont]
	,[LetterAssignmentFontIsBold]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains look up values for client relationship types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system id number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'pkCPRefClientRelationshipType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Relationship type description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Watermark stamp for client relationship on icon', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'LetterAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What font should the letter abbreviation be', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'LetterAssignmentFont';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the font on the watermark be bold (1=yes, 0=no)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientRelationshipType', @level2type = N'COLUMN', @level2name = N'LetterAssignmentFontIsBold';

