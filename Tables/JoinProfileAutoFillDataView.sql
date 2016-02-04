CREATE TABLE [dbo].[JoinProfileAutoFillDataView] (
    [pkJoinProfileAutoFillDataView] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProfile]                     DECIMAL (18) NOT NULL,
    [fkAutoFillDataView]            DECIMAL (18) NOT NULL,
    [LUPUser]                       VARCHAR (50) NULL,
    [LUPDate]                       DATETIME     NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    CONSTRAINT [PK_JoinProfileAutoFillDataView] PRIMARY KEY CLUSTERED ([pkJoinProfileAutoFillDataView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutoFillDataView_fkProfile]
    ON [dbo].[JoinProfileAutoFillDataView]([fkAutoFillDataView] ASC, [fkProfile] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkProfile_fkAutoFillDataView]
    ON [dbo].[JoinProfileAutoFillDataView]([fkProfile] ASC, [fkAutoFillDataView] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinProfileAutoFillDataViewAudit_UI] On [dbo].[JoinProfileAutoFillDataView]
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

Update JoinProfileAutoFillDataView
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileAutoFillDataView dbTable
	Inner Join Inserted i on dbtable.pkJoinProfileAutoFillDataView = i.pkJoinProfileAutoFillDataView
	Left Join Deleted d on d.pkJoinProfileAutoFillDataView = d.pkJoinProfileAutoFillDataView
	Where d.pkJoinProfileAutoFillDataView is null

Update JoinProfileAutoFillDataView
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileAutoFillDataView dbTable
	Inner Join Deleted d on dbTable.pkJoinProfileAutoFillDataView = d.pkJoinProfileAutoFillDataView
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinProfileAutoFillDataViewAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinProfileAutoFillDataView] = i.[pkJoinProfileAutoFillDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileAutoFillDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileAutoFillDataView]
	,[fkProfile]
	,[fkAutoFillDataView]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinProfileAutoFillDataView]
	,[fkProfile]
	,[fkAutoFillDataView]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinProfileAutoFillDataViewAudit_d] On [dbo].[JoinProfileAutoFillDataView]
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
From JoinProfileAutoFillDataViewAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinProfileAutoFillDataView] = d.[pkJoinProfileAutoFillDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileAutoFillDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileAutoFillDataView]
	,[fkProfile]
	,[fkAutoFillDataView]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinProfileAutoFillDataView]
	,[fkProfile]
	,[fkAutoFillDataView]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the many-to-many relationship between profiles and AutoFill data views', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'pkJoinProfileAutoFillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillDataView table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'fkAutoFillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileAutoFillDataView', @level2type = N'COLUMN', @level2name = N'CreateDate';

