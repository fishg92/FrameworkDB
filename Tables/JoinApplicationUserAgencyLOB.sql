CREATE TABLE [dbo].[JoinApplicationUserAgencyLOB] (
    [pkJoinApplicationUserAgencyLOB] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]              DECIMAL (18) NOT NULL,
    [fkAgencyLOB]                    DECIMAL (18) NOT NULL,
    [LUPUser]                        VARCHAR (50) NULL,
    [LUPDate]                        DATETIME     NULL,
    [CreateUser]                     VARCHAR (50) NULL,
    [CreateDate]                     DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserAgencyLOB] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserAgencyLOB] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAgencyLOB]
    ON [dbo].[JoinApplicationUserAgencyLOB]([fkAgencyLOB] ASC)
    INCLUDE([fkApplicationUser]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserAgencyLOB]([fkApplicationUser] ASC)
    INCLUDE([fkAgencyLOB]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserAgencyLOBAudit_UI] On [dbo].[JoinApplicationUserAgencyLOB]
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

Update JoinApplicationUserAgencyLOB
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserAgencyLOB dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserAgencyLOB = i.pkJoinApplicationUserAgencyLOB
	Left Join Deleted d on d.pkJoinApplicationUserAgencyLOB = d.pkJoinApplicationUserAgencyLOB
	Where d.pkJoinApplicationUserAgencyLOB is null

Update JoinApplicationUserAgencyLOB
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserAgencyLOB dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserAgencyLOB = d.pkJoinApplicationUserAgencyLOB
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserAgencyLOBAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserAgencyLOB] = i.[pkJoinApplicationUserAgencyLOB]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserAgencyLOBAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserAgencyLOB]
	,[fkApplicationUser]
	,[fkAgencyLOB]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserAgencyLOB]
	,[fkApplicationUser]
	,[fkAgencyLOB]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserAgencyLOBAudit_d] On [dbo].[JoinApplicationUserAgencyLOB]
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
From JoinApplicationUserAgencyLOBAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserAgencyLOB] = d.[pkJoinApplicationUserAgencyLOB]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserAgencyLOBAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserAgencyLOB]
	,[fkApplicationUser]
	,[fkAgencyLOB]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserAgencyLOB]
	,[fkApplicationUser]
	,[fkAgencyLOB]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Join tables all contain information describing many to many relationships between two tables. This one descibes the relationships between Application Users and Agency LOB.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the application table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ForeignKey to the AgencyLOB table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'fkAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserAgencyLOB', @level2type = N'COLUMN', @level2name = N'CreateDate';

