CREATE TABLE [dbo].[CPJoinCPClientCPClientrefRelationship] (
    [pkCPJoinCPClientCPClientrefRelationship] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientParent]                        DECIMAL (18) NULL,
    [fkCPClientChild]                         DECIMAL (18) NULL,
    [fkParentCPrefClientRelationshipType]     DECIMAL (18) NULL,
    [fkChildCPrefClientRelationshipType]      DECIMAL (18) NULL,
    [CreateUser]                              VARCHAR (50) NULL,
    [CreateDate]                              DATETIME     NULL,
    [LUPUser]                                 VARCHAR (50) NULL,
    [LUPDate]                                 DATETIME     NULL,
    CONSTRAINT [PK_CPJoinCPClientCPClientrefRelationship] PRIMARY KEY CLUSTERED ([pkCPJoinCPClientCPClientrefRelationship] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_fkChildCPrefClientRelationshipType]
    ON [dbo].[CPJoinCPClientCPClientrefRelationship]([fkChildCPrefClientRelationshipType] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fkCPClientChild]
    ON [dbo].[CPJoinCPClientCPClientrefRelationship]([fkCPClientChild] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fkCPClientParent]
    ON [dbo].[CPJoinCPClientCPClientrefRelationship]([fkCPClientParent] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fkParentCPrefClientRelationshipType]
    ON [dbo].[CPJoinCPClientCPClientrefRelationship]([fkParentCPrefClientRelationshipType] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinCPClientCPClientrefRelationshipAudit_UI] On [dbo].[CPJoinCPClientCPClientrefRelationship]
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

Update CPJoinCPClientCPClientrefRelationship
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCPClientCPClientrefRelationship dbTable
	Inner Join Inserted i on dbtable.pkCPJoinCPClientCPClientrefRelationship = i.pkCPJoinCPClientCPClientrefRelationship
	Left Join Deleted d on d.pkCPJoinCPClientCPClientrefRelationship = d.pkCPJoinCPClientCPClientrefRelationship
	Where d.pkCPJoinCPClientCPClientrefRelationship is null

Update CPJoinCPClientCPClientrefRelationship
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCPClientCPClientrefRelationship dbTable
	Inner Join Deleted d on dbTable.pkCPJoinCPClientCPClientrefRelationship = d.pkCPJoinCPClientCPClientrefRelationship
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinCPClientCPClientrefRelationshipAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinCPClientCPClientrefRelationship] = i.[pkCPJoinCPClientCPClientrefRelationship]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCPClientCPClientrefRelationshipAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCPClientCPClientrefRelationship]
	,[fkCPClientParent]
	,[fkCPClientChild]
	,[fkParentCPrefClientRelationshipType]
	,[fkChildCPrefClientRelationshipType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinCPClientCPClientrefRelationship]
	,[fkCPClientParent]
	,[fkCPClientChild]
	,[fkParentCPrefClientRelationshipType]
	,[fkChildCPrefClientRelationshipType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinCPClientCPClientrefRelationshipAudit_d] On [dbo].[CPJoinCPClientCPClientrefRelationship]
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
From CPJoinCPClientCPClientrefRelationshipAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinCPClientCPClientrefRelationship] = d.[pkCPJoinCPClientCPClientrefRelationship]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCPClientCPClientrefRelationshipAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCPClientCPClientrefRelationship]
	,[fkCPClientParent]
	,[fkCPClientChild]
	,[fkParentCPrefClientRelationshipType]
	,[fkChildCPrefClientRelationshipType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinCPClientCPClientrefRelationship]
	,[fkCPClientParent]
	,[fkCPClientChild]
	,[fkParentCPrefClientRelationshipType]
	,[fkChildCPrefClientRelationshipType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table is used to define relationships between different People clients. It models the way that different CPClient records relate to each other.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'pkCPJoinCPClientCPClientrefRelationship';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) foreign key to CPClient, indicating one half of the relationship.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'fkCPClientParent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) foreign key to CPClient, indicating the other half of a relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'fkCPClientChild';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) Foreign key to CPrefClientRelationshipType, defining the "Parent" client''s role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'fkParentCPrefClientRelationshipType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) Foreign key to CPrefClientRelationshipType, defining the "child" client''s role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'fkChildCPrefClientRelationshipType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCPClientCPClientrefRelationship', @level2type = N'COLUMN', @level2name = N'LUPDate';

