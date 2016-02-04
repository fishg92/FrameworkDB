CREATE TABLE [dbo].[JoinEventTypeFormName] (
    [pkJoinEventTypeFormName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkEventType]             DECIMAL (18) NULL,
    [fkFormName]              DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinEventTypeFormNameForms] PRIMARY KEY CLUSTERED ([pkJoinEventTypeFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkEventType]
    ON [dbo].[JoinEventTypeFormName]([fkEventType] ASC)
    INCLUDE([fkFormName]);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[JoinEventTypeFormName]([fkFormName] ASC)
    INCLUDE([fkEventType]);


GO
CREATE Trigger [dbo].[tr_JoinEventTypeFormNameAudit_UI] On [dbo].[JoinEventTypeFormName]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinEventTypeFormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinEventTypeFormName] = i.[pkJoinEventTypeFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeFormName]
	,[fkEventType]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinEventTypeFormName]
	,[fkEventType]
	,[fkFormName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinEventTypeFormNameAudit_d] On [dbo].[JoinEventTypeFormName]
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
From JoinEventTypeFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinEventTypeFormName] = d.[pkJoinEventTypeFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeFormName]
	,[fkEventType]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinEventTypeFormName]
	,[fkEventType]
	,[fkFormName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table joins Forms to Event types for CoPilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeFormName', @level2type = N'COLUMN', @level2name = N'pkJoinEventTypeFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Event Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeFormName', @level2type = N'COLUMN', @level2name = N'fkEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign Key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeFormName', @level2type = N'COLUMN', @level2name = N'fkFormName';

