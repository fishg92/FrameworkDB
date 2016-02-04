CREATE TABLE [dbo].[ProvisionalAssignment] (
    [pkProvisionalAssignment] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkRecipientPool]         DECIMAL (18) NOT NULL,
    [fkSuggestedUser]         DECIMAL (18) NOT NULL,
    [fkAssigningUser]         DECIMAL (18) NOT NULL,
    [SuggestionAccepted]      BIT          NOT NULL,
    [LUPUser]                 VARCHAR (50) NULL,
    [LUPDate]                 DATETIME     NULL,
    [CreateUser]              VARCHAR (50) NULL,
    [CreateDate]              DATETIME     NULL,
    CONSTRAINT [PK_ProvisionalAssignment] PRIMARY KEY CLUSTERED ([pkProvisionalAssignment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ProvisionalAssignment_fkRecipientPool]
    ON [dbo].[ProvisionalAssignment]([fkRecipientPool] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ProvisionalAssignment_fkSuggestedUser]
    ON [dbo].[ProvisionalAssignment]([fkSuggestedUser] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ProvisionalAssignment_fkAssigningUser]
    ON [dbo].[ProvisionalAssignment]([fkAssigningUser] ASC);


GO
CREATE Trigger [dbo].[tr_ProvisionalAssignmentAudit_UI] On [dbo].[ProvisionalAssignment]
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

Update ProvisionalAssignment
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ProvisionalAssignment dbTable
	Inner Join Inserted i on dbtable.pkProvisionalAssignment = i.pkProvisionalAssignment
	Left Join Deleted d on d.pkProvisionalAssignment = d.pkProvisionalAssignment
	Where d.pkProvisionalAssignment is null

Update ProvisionalAssignment
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProvisionalAssignment dbTable
	Inner Join Deleted d on dbTable.pkProvisionalAssignment = d.pkProvisionalAssignment

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProvisionalAssignmentAudit dbTable
Inner Join inserted i ON dbTable.[pkProvisionalAssignment] = i.[pkProvisionalAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProvisionalAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProvisionalAssignment]
	,[fkRecipientPool]
	,[fkSuggestedUser]
	,[fkAssigningUser]
	,[SuggestionAccepted]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProvisionalAssignment]
	,[fkRecipientPool]
	,[fkSuggestedUser]
	,[fkAssigningUser]
	,[SuggestionAccepted]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ProvisionalAssignmentAudit_d] On [dbo].[ProvisionalAssignment]
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
From ProvisionalAssignmentAudit dbTable
Inner Join deleted d ON dbTable.[pkProvisionalAssignment] = d.[pkProvisionalAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProvisionalAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProvisionalAssignment]
	,[fkRecipientPool]
	,[fkSuggestedUser]
	,[fkAssigningUser]
	,[SuggestionAccepted]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProvisionalAssignment]
	,[fkRecipientPool]
	,[fkSuggestedUser]
	,[fkAssigningUser]
	,[SuggestionAccepted]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Suggested recipients for task assignment from a recipient pool. Used for tracking assignment history for a recipient pool.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'pkProvisionalAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the Recipient Pool this assignment was created for', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'fkRecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the Application User that was suggested as the task recipient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'fkSuggestedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the Application User that requested the assignment suggestion from the recipient pool', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'fkAssigningUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag determining whether or not the suggested recipient was assigned to the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'SuggestionAccepted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProvisionalAssignment', @level2type = N'COLUMN', @level2name = N'CreateDate';

