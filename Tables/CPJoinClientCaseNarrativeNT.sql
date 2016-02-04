CREATE TABLE [dbo].[CPJoinClientCaseNarrativeNT] (
    [pkCPJoinClientCaseNarrativeNT] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    [fkCPNarrativeNT]               DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientCaseNarrativeNT] PRIMARY KEY CLUSTERED ([pkCPJoinClientCaseNarrativeNT] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CPJoinClientCaseNarrativeNT_fkClientCase_to_CPNarrativeNT]
    ON [dbo].[CPJoinClientCaseNarrativeNT]([fkCPClientCase] ASC, [fkCPNarrativeNT] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPJoinClientCaseNarrativeNT_fkCPNarrativeNT_to_fkCPClientCase]
    ON [dbo].[CPJoinClientCaseNarrativeNT]([fkCPNarrativeNT] ASC, [fkCPClientCase] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinClientCaseNarrativeNTAudit_d] On [dbo].[CPJoinClientCaseNarrativeNT]
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
From CPJoinClientCaseNarrativeNTAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientCaseNarrativeNT] = d.[pkCPJoinClientCaseNarrativeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientCaseNarrativeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientCaseNarrativeNT]
	,[fkCPClientCase]
	,[fkCPNarrativeNT]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientCaseNarrativeNT]
	,[fkCPClientCase]
	,[fkCPNarrativeNT]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPJoinClientCaseNarrativeNTAudit_UI] On [dbo].[CPJoinClientCaseNarrativeNT]
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

Update CPJoinClientCaseNarrativeNT
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
	From CPJoinClientCaseNarrativeNT dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientCaseNarrativeNT = i.pkCPJoinClientCaseNarrativeNT
	Left Join Deleted d on d.pkCPJoinClientCaseNarrativeNT = d.pkCPJoinClientCaseNarrativeNT
	Where d.pkCPJoinClientCaseNarrativeNT is null

Update CPJoinClientCaseNarrativeNT
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
FROM CPJoinClientCaseNarrativeNT dbTable
         Inner Join Deleted d on dbTable.pkCPJoinClientCaseNarrativeNT = d.pkCPJoinClientCaseNarrativeNT

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientCaseNarrativeNTAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientCaseNarrativeNT] = i.[pkCPJoinClientCaseNarrativeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientCaseNarrativeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientCaseNarrativeNT]
	,[fkCPClientCase]
	,[fkCPNarrativeNT]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientCaseNarrativeNT]
	,[fkCPClientCase]
	,[fkCPNarrativeNT]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links People clients to narratives.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, autoincrementing system ID number (possible candidate to be replaced with dual key on fkCPClientCase and fkCPNarrativeNT)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientCaseNarrativeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indexed foreign key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indexed foreign key to CPNarrativeNT', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientCaseNarrativeNT', @level2type = N'COLUMN', @level2name = N'fkCPNarrativeNT';

