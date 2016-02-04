CREATE TABLE [dbo].[CPJoinClientEmployer] (
    [pkCPJoinClientEmployer] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]             DECIMAL (18) NULL,
    [fkCPEmployer]           DECIMAL (18) NULL,
    [StartDate]              DATETIME     NULL,
    [EndDate]                DATETIME     NULL,
    [LockedUser]             VARCHAR (50) NULL,
    [LockedDate]             DATETIME     NULL,
    [LUPUser]                VARCHAR (50) NULL,
    [LUPDate]                DATETIME     NULL,
    [CreateUser]             VARCHAR (50) NULL,
    [CreateDate]             DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientEmployer] PRIMARY KEY NONCLUSTERED ([pkCPJoinClientEmployer] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPJoinClientEmployer]([fkCPClient] ASC)
    INCLUDE([fkCPEmployer]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxfkCPEmployer]
    ON [dbo].[CPJoinClientEmployer]([fkCPEmployer] ASC)
    INCLUDE([fkCPClient]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPJoinClientEmployerAudit_UI] On [dbo].[CPJoinClientEmployer]
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

Update CPJoinClientEmployer
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientEmployer dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientEmployer = i.pkCPJoinClientEmployer
	Left Join Deleted d on d.pkCPJoinClientEmployer = d.pkCPJoinClientEmployer
	Where d.pkCPJoinClientEmployer is null

Update CPJoinClientEmployer
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientEmployer dbTable
	Inner Join Deleted d on dbTable.pkCPJoinClientEmployer = d.pkCPJoinClientEmployer
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientEmployerAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientEmployer] = i.[pkCPJoinClientEmployer]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientEmployerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientEmployer]
	,[fkCPClient]
	,[fkCPEmployer]
	,[StartDate]
	,[EndDate]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientEmployer]
	,[fkCPClient]
	,[fkCPEmployer]
	,[StartDate]
	,[EndDate]
	,[LockedUser]
	,[LockedDate]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinClientEmployerAudit_d] On [dbo].[CPJoinClientEmployer]
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
From CPJoinClientEmployerAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientEmployer] = d.[pkCPJoinClientEmployer]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientEmployerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientEmployer]
	,[fkCPClient]
	,[fkCPEmployer]
	,[StartDate]
	,[EndDate]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientEmployer]
	,[fkCPClient]
	,[fkCPEmployer]
	,[StartDate]
	,[EndDate]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links CPClient to CPEmployer. CPEmployer may have duplicate record values in it because it is primarily meant to generate a work history for a People client, rather than to be an authoritative source of information about employers.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientEmployer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) foreign key to CPEmployer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'fkCPEmployer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date the employment started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date the employment ended', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientEmployer', @level2type = N'COLUMN', @level2name = N'CreateDate';

