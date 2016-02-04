CREATE TABLE [dbo].[WorkShareAssignment] (
    [pkWorkShareAssignment] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fksharer]              DECIMAL (18) NOT NULL,
    [fksharee]              DECIMAL (18) NOT NULL,
    [LUPUser]               VARCHAR (50) NULL,
    [LUPDate]               DATETIME     NULL,
    [CreateUser]            VARCHAR (50) NULL,
    [CreateDate]            DATETIME     NULL,
    [fkrefWorkSharingType]  DECIMAL (18) CONSTRAINT [DF_WorkShareAssignment_fkrefWorkSharingType] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_WorkShareAssignment] PRIMARY KEY CLUSTERED ([pkWorkShareAssignment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkSharee_fkSharer]
    ON [dbo].[WorkShareAssignment]([fksharee] ASC, [fksharer] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkSharer_fkSharee]
    ON [dbo].[WorkShareAssignment]([fksharer] ASC, [fksharee] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_WorkShareAssignmentAudit_d] On [dbo].[WorkShareAssignment]
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
From WorkShareAssignmentAudit dbTable
Inner Join deleted d ON dbTable.[pkWorkShareAssignment] = d.[pkWorkShareAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into WorkShareAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkWorkShareAssignment]
	,[fksharer]
	,[fksharee]
	,[fkrefWorkSharingType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkWorkShareAssignment]
	,[fksharer]
	,[fksharee]
	,[fkrefWorkSharingType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_WorkShareAssignmentAudit_UI] On [dbo].[WorkShareAssignment]
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

Update WorkShareAssignment
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From WorkShareAssignment dbTable
	Inner Join Inserted i on dbtable.pkWorkShareAssignment = i.pkWorkShareAssignment
	Left Join Deleted d on d.pkWorkShareAssignment = d.pkWorkShareAssignment
	Where d.pkWorkShareAssignment is null

Update WorkShareAssignment
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From WorkShareAssignment dbTable
	Inner Join Deleted d on dbTable.pkWorkShareAssignment = d.pkWorkShareAssignment
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From WorkShareAssignmentAudit dbTable
Inner Join inserted i ON dbTable.[pkWorkShareAssignment] = i.[pkWorkShareAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into WorkShareAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkWorkShareAssignment]
	,[fksharer]
	,[fksharee]
	,[fkrefWorkSharingType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkWorkShareAssignment]
	,[fksharer]
	,[fksharee]
	,[fkrefWorkSharingType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table shows the work sharing assignments for Tasks.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'pkWorkShareAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser showing the person who is sharing the work', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'fksharer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to application user to show to whom the work is shared', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'fksharee';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refWorkSharingType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkShareAssignment', @level2type = N'COLUMN', @level2name = N'fkrefWorkSharingType';

