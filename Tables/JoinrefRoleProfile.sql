CREATE TABLE [dbo].[JoinrefRoleProfile] (
    [pkJoinrefRoleProfile] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefRole]            DECIMAL (18) NOT NULL,
    [fkProfile]            DECIMAL (18) NOT NULL,
    [LUPUser]              VARCHAR (50) NULL,
    [LUPDate]              DATETIME     NULL,
    [CreateUser]           VARCHAR (50) NULL,
    [CreateDate]           DATETIME     NULL,
    CONSTRAINT [PK_JoinrefRoleProfile] PRIMARY KEY CLUSTERED ([pkJoinrefRoleProfile] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProfile_fkrefRole]
    ON [dbo].[JoinrefRoleProfile]([fkProfile] ASC, [fkrefRole] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkrefRole_fkProfile]
    ON [dbo].[JoinrefRoleProfile]([fkrefRole] ASC, [fkProfile] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinrefRoleProfileAudit_UI] On [dbo].[JoinrefRoleProfile]
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

Update JoinrefRoleProfile
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefRoleProfile dbTable
	Inner Join Inserted i on dbtable.pkJoinrefRoleProfile = i.pkJoinrefRoleProfile
	Left Join Deleted d on d.pkJoinrefRoleProfile = d.pkJoinrefRoleProfile
	Where d.pkJoinrefRoleProfile is null

Update JoinrefRoleProfile
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefRoleProfile dbTable
	Inner Join Deleted d on dbTable.pkJoinrefRoleProfile = d.pkJoinrefRoleProfile
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinrefRoleProfileAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinrefRoleProfile] = i.[pkJoinrefRoleProfile]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefRoleProfileAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefRoleProfile]
	,[fkrefRole]
	,[fkProfile]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinrefRoleProfile]
	,[fkrefRole]
	,[fkProfile]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinrefRoleProfileAudit_d] On [dbo].[JoinrefRoleProfile]
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
From JoinrefRoleProfileAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinrefRoleProfile] = d.[pkJoinrefRoleProfile]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefRoleProfileAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefRoleProfile]
	,[fkrefRole]
	,[fkProfile]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinrefRoleProfile]
	,[fkrefRole]
	,[fkProfile]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table links profiles to roles', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'pkJoinrefRoleProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refRole table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'fkrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRoleProfile', @level2type = N'COLUMN', @level2name = N'CreateDate';

