CREATE TABLE [dbo].[CPJoinClientNarrativeNT] (
    [pkCPJoinClientNarrativeNT] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    [fkCPClient]                DECIMAL (18) NULL,
    [fkCPNarrativeNT]           DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientNarrativeNT] PRIMARY KEY CLUSTERED ([pkCPJoinClientNarrativeNT] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPJoinClientNarrativeNT]([fkCPClient] ASC)
    INCLUDE([fkCPNarrativeNT]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxfkCPNarrativeNT]
    ON [dbo].[CPJoinClientNarrativeNT]([fkCPNarrativeNT] ASC)
    INCLUDE([fkCPClient]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPJoinClientNarrativeNTAudit_UI] On [dbo].[CPJoinClientNarrativeNT]
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

Update CPJoinClientNarrativeNT
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
	From CPJoinClientNarrativeNT dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientNarrativeNT = i.pkCPJoinClientNarrativeNT
	Left Join Deleted d on d.pkCPJoinClientNarrativeNT = d.pkCPJoinClientNarrativeNT
	Where d.pkCPJoinClientNarrativeNT is null

Update CPJoinClientNarrativeNT
	 Set [CreateUser] = d.createuser
,[CreateDate] = d.createdate
From  CPJoinClientNarrativeNT dbTable
         Inner Join Deleted d on dbTable.pkCPJoinClientNarrativeNT = d.pkCPJoinClientNarrativeNT

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientNarrativeNTAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientNarrativeNT] = i.[pkCPJoinClientNarrativeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientNarrativeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientNarrativeNT]
	,[fkCPClient]
	,[fkCPNarrativeNT]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientNarrativeNT]
	,[fkCPClient]
	,[fkCPNarrativeNT]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinClientNarrativeNTAudit_d] On [dbo].[CPJoinClientNarrativeNT]
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
From CPJoinClientNarrativeNTAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientNarrativeNT] = d.[pkCPJoinClientNarrativeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientNarrativeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientNarrativeNT]
	,[fkCPClient]
	,[fkCPNarrativeNT]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientNarrativeNT]
	,[fkCPClient]
	,[fkCPNarrativeNT]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table collects clients into case narratives.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientNarrativeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) Foreign key to CPNarrativeNT', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientNarrativeNT', @level2type = N'COLUMN', @level2name = N'fkCPNarrativeNT';

