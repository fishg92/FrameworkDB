CREATE TABLE [dbo].[CPRefAlertFlagTypeNT] (
    [pkCPRefAlertFlagTypeNT] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]            VARCHAR (255) NULL,
    [AlertDisplay]           BIT           NULL,
    [LockedUser]             VARCHAR (20)  NULL,
    [LockedDate]             DATETIME      NULL,
    [LUPUser]                VARCHAR (50)  NULL,
    [LUPDate]                DATETIME      NULL,
    [CreateUser]             VARCHAR (50)  NULL,
    [CreateDate]             DATETIME      NULL,
    CONSTRAINT [PK_CPRefNarrativeFlagType] PRIMARY KEY CLUSTERED ([pkCPRefAlertFlagTypeNT] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefAlertFlagTypeNTAudit_d] On [dbo].[CPRefAlertFlagTypeNT]
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
From CPRefAlertFlagTypeNTAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefAlertFlagTypeNT] = d.[pkCPRefAlertFlagTypeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefAlertFlagTypeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefAlertFlagTypeNT]
	,[Description]
	,[AlertDisplay]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefAlertFlagTypeNT]
	,[Description]
	,[AlertDisplay]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefAlertFlagTypeNTAudit_UI] On [dbo].[CPRefAlertFlagTypeNT]
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

Update CPRefAlertFlagTypeNT
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefAlertFlagTypeNT dbTable
	Inner Join Inserted i on dbtable.pkCPRefAlertFlagTypeNT = i.pkCPRefAlertFlagTypeNT
	Left Join Deleted d on d.pkCPRefAlertFlagTypeNT = d.pkCPRefAlertFlagTypeNT
	Where d.pkCPRefAlertFlagTypeNT is null

Update CPRefAlertFlagTypeNT
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefAlertFlagTypeNT dbTable
	Inner Join Deleted d on dbTable.pkCPRefAlertFlagTypeNT = d.pkCPRefAlertFlagTypeNT
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefAlertFlagTypeNTAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefAlertFlagTypeNT] = i.[pkCPRefAlertFlagTypeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefAlertFlagTypeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefAlertFlagTypeNT]
	,[Description]
	,[AlertDisplay]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefAlertFlagTypeNT]
	,[Description]
	,[AlertDisplay]
	,[LockedUser]
	,[LockedDate]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table keeps the different user-defined alert flags (for example, Violent or Fraud History) that might be used for different People clients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'pkCPRefAlertFlagTypeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A text description for the flag', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=Show an alert in People, 0=Don''t', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'AlertDisplay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'CreateDate';

