CREATE TABLE [dbo].[JoinApplicationUserConfiguration] (
    [pkJoinApplicationUserConfiguration] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                  DECIMAL (18) NOT NULL,
    [fkConfiguration]                    DECIMAL (18) NOT NULL,
    [LUPUser]                            VARCHAR (50) NULL,
    [LUPDate]                            DATETIME     NULL,
    [CreateUser]                         VARCHAR (50) NULL,
    [CreateDate]                         DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserConfiguration] PRIMARY KEY NONCLUSTERED ([pkJoinApplicationUserConfiguration] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser_fkConfiguration]
    ON [dbo].[JoinApplicationUserConfiguration]([fkApplicationUser] ASC, [fkConfiguration] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkConfiguration_fkApplicationUser]
    ON [dbo].[JoinApplicationUserConfiguration]([fkConfiguration] ASC, [fkApplicationUser] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserConfigurationAudit_d] On [dbo].[JoinApplicationUserConfiguration]
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
From JoinApplicationUserConfigurationAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserConfiguration] = d.[pkJoinApplicationUserConfiguration]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserConfigurationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserConfiguration]
	,[fkApplicationUser]
	,[fkConfiguration]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserConfiguration]
	,[fkApplicationUser]
	,[fkConfiguration]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserConfigurationAudit_UI] On [dbo].[JoinApplicationUserConfiguration]
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

Update JoinApplicationUserConfiguration
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserConfiguration dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserConfiguration = i.pkJoinApplicationUserConfiguration
	Left Join Deleted d on d.pkJoinApplicationUserConfiguration = d.pkJoinApplicationUserConfiguration
	Where d.pkJoinApplicationUserConfiguration is null

Update JoinApplicationUserConfiguration
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserConfiguration dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserConfiguration = d.pkJoinApplicationUserConfiguration
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserConfigurationAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserConfiguration] = i.[pkJoinApplicationUserConfiguration]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserConfigurationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserConfiguration]
	,[fkApplicationUser]
	,[fkConfiguration]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserConfiguration]
	,[fkApplicationUser]
	,[fkConfiguration]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserConfiguration', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserConfiguration';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserConfiguration', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserConfiguration', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserConfiguration', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserConfiguration', @level2type = N'COLUMN', @level2name = N'CreateDate';

