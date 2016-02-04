CREATE TABLE [dbo].[JoinProfileAutoFillSchemaDataView] (
    [pkJoinProfileAutoFillSchemaDataView] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProfile]                           DECIMAL (18) NOT NULL,
    [fkAutoFillSchemaDataView]            DECIMAL (18) NOT NULL,
    [LUPUser]                             VARCHAR (50) NULL,
    [LUPDate]                             DATETIME     NULL,
    [CreateUser]                          VARCHAR (50) NULL,
    [CreateDate]                          DATETIME     NULL,
    CONSTRAINT [PK_JoinProfileAutoFillSchemaDataView] PRIMARY KEY CLUSTERED ([pkJoinProfileAutoFillSchemaDataView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutoFillSchemaDataView]
    ON [dbo].[JoinProfileAutoFillSchemaDataView]([fkAutoFillSchemaDataView] ASC)
    INCLUDE([fkProfile]);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[JoinProfileAutoFillSchemaDataView]([fkProfile] ASC)
    INCLUDE([fkAutoFillSchemaDataView]);


GO
CREATE Trigger [dbo].[tr_JoinProfileAutoFillSchemaDataViewAudit_d] On [dbo].[JoinProfileAutoFillSchemaDataView]
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
From JoinProfileAutoFillSchemaDataViewAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinProfileAutoFillSchemaDataView] = d.[pkJoinProfileAutoFillSchemaDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileAutoFillSchemaDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileAutoFillSchemaDataView]
	,[fkProfile]
	,[fkAutoFillSchemaDataView]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinProfileAutoFillSchemaDataView]
	,[fkProfile]
	,[fkAutoFillSchemaDataView]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinProfileAutoFillSchemaDataViewAudit_UI] On [dbo].[JoinProfileAutoFillSchemaDataView]
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

Update JoinProfileAutoFillSchemaDataView
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileAutoFillSchemaDataView dbTable
	Inner Join Inserted i on dbtable.pkJoinProfileAutoFillSchemaDataView = i.pkJoinProfileAutoFillSchemaDataView
	Left Join Deleted d on d.pkJoinProfileAutoFillSchemaDataView = d.pkJoinProfileAutoFillSchemaDataView
	Where d.pkJoinProfileAutoFillSchemaDataView is null

Update JoinProfileAutoFillSchemaDataView
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileAutoFillSchemaDataView dbTable
	Inner Join Deleted d on dbTable.pkJoinProfileAutoFillSchemaDataView = d.pkJoinProfileAutoFillSchemaDataView
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinProfileAutoFillSchemaDataViewAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinProfileAutoFillSchemaDataView] = i.[pkJoinProfileAutoFillSchemaDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileAutoFillSchemaDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileAutoFillSchemaDataView]
	,[fkProfile]
	,[fkAutoFillSchemaDataView]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinProfileAutoFillSchemaDataView]
	,[fkProfile]
	,[fkAutoFillSchemaDataView]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the many-to-many relationship between Profile and AutoFillSchemaDataView tables', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'pkJoinProfileAutoFillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillSchemaDataView table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'fkAutoFillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillSchemaDataView', @level2type = N'COLUMN', @level2name = N'CreateDate';

