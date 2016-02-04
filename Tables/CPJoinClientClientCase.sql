CREATE TABLE [dbo].[CPJoinClientClientCase] (
    [pkCPJoinClientClientCase]      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    [fkCPClient]                    DECIMAL (18) NULL,
    [PrimaryParticipantOnCase]      TINYINT      NULL,
    [fkCPRefClientRelationshipType] DECIMAL (18) NULL,
    [LockedUser]                    VARCHAR (50) NULL,
    [LockedDate]                    DATETIME     NULL,
    [LUPUser]                       VARCHAR (50) NULL,
    [LUPDate]                       DATETIME     NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientCaseClient] PRIMARY KEY NONCLUSTERED ([pkCPJoinClientClientCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPJoinClientClientCase]([fkCPClient] ASC)
    INCLUDE([fkCPClientCase]);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClientCase]
    ON [dbo].[CPJoinClientClientCase]([fkCPClientCase] ASC)
    INCLUDE([fkCPClient]);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientRelationshipType]
    ON [dbo].[CPJoinClientClientCase]([fkCPRefClientRelationshipType] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinClientClientCaseAudit_d] On [dbo].[CPJoinClientClientCase]
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
From CPJoinClientClientCaseAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientClientCase] = d.[pkCPJoinClientClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientCase]
	,[fkCPClientCase]
	,[fkCPClient]
	,[PrimaryParticipantOnCase]
	,[fkCPRefClientRelationshipType]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientClientCase]
	,[fkCPClientCase]
	,[fkCPClient]
	,[PrimaryParticipantOnCase]
	,[fkCPRefClientRelationshipType]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPJoinClientClientCaseAudit_UI] On [dbo].[CPJoinClientClientCase]
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

Update CPJoinClientClientCase
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientCase dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientClientCase = i.pkCPJoinClientClientCase
	Left Join Deleted d on d.pkCPJoinClientClientCase = d.pkCPJoinClientClientCase
	Where d.pkCPJoinClientClientCase is null

Update CPJoinClientClientCase
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientCase dbTable
	Inner Join Deleted d on dbTable.pkCPJoinClientClientCase = d.pkCPJoinClientClientCase
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientClientCaseAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientClientCase] = i.[pkCPJoinClientClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientCase]
	,[fkCPClientCase]
	,[fkCPClient]
	,[PrimaryParticipantOnCase]
	,[fkCPRefClientRelationshipType]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientClientCase]
	,[fkCPClientCase]
	,[fkCPClient]
	,[PrimaryParticipantOnCase]
	,[fkCPRefClientRelationshipType]
	,[LockedUser]
	,[LockedDate]

From  Inserted

--make the corresponding case record active if this a new member being added
Update CPClientCase
Set CaseStatus = 1
From CPClientCase cc
Inner Join Inserted i on cc.pkCPClientCase = i.fkCPClientCase
Left Join Deleted d on cc.pkCPClientCase = d.fkCPClientCase
Where d.pkCPJoinClientClientCase is null
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table stores the relationship between clients and cases.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates if the user is the primary participant on the case', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'PrimaryParticipantOnCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPRefClientRelationshipType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'fkCPRefClientRelationshipType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientCase', @level2type = N'COLUMN', @level2name = N'CreateDate';

