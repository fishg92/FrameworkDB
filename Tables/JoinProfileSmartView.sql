CREATE TABLE [dbo].[JoinProfileSmartView] (
    [pkJoinProfileSmartView] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProfile]              DECIMAL (18) NOT NULL,
    [fkSmartView]            DECIMAL (18) NOT NULL,
    [LUPUser]                VARCHAR (50) NULL,
    [LUPDate]                DATETIME     NULL,
    [CreateUser]             VARCHAR (50) NULL,
    [CreateDate]             DATETIME     NULL,
    CONSTRAINT [PK_JoinProfileSmartView] PRIMARY KEY CLUSTERED ([pkJoinProfileSmartView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[JoinProfileSmartView]([fkProfile] ASC);


GO
CREATE NONCLUSTERED INDEX [fkSmartView]
    ON [dbo].[JoinProfileSmartView]([fkSmartView] ASC);


GO
CREATE Trigger [dbo].[tr_JoinProfileSmartViewAudit_UI] On [dbo].[JoinProfileSmartView]
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

Update JoinProfileSmartView
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From JoinProfileSmartView dbTable
	Inner Join Inserted i on dbtable.pkJoinProfileSmartView = i.pkJoinProfileSmartView
	Left Join Deleted d on d.pkJoinProfileSmartView = d.pkJoinProfileSmartView
	Where d.pkJoinProfileSmartView is null

Update JoinProfileSmartView
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
FROM JoinProfileSmartView JPSV
Inner Join Deleted d on JPSV.pkJoinProfileSmartView = d.pkJoinProfileSmartView


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinProfileSmartViewAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinProfileSmartView] = i.[pkJoinProfileSmartView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileSmartViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileSmartView]
	,[fkProfile]
	,[fkSmartView]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinProfileSmartView]
	,[fkProfile]
	,[fkSmartView]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinProfileSmartViewAudit_d] On [dbo].[JoinProfileSmartView]
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
From JoinProfileSmartViewAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinProfileSmartView] = d.[pkJoinProfileSmartView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileSmartViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileSmartView]
	,[fkProfile]
	,[fkSmartView]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinProfileSmartView]
	,[fkProfile]
	,[fkSmartView]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links Smart Views to individual profiles.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'pkJoinProfileSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key smartview', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'fkSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileSmartView', @level2type = N'COLUMN', @level2name = N'LUPDate';

